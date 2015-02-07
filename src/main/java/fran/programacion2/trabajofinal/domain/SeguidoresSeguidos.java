package fran.programacion2.trabajofinal.domain;
import java.util.List;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

import javax.persistence.EntityManager;
import javax.persistence.ManyToOne;
import javax.persistence.TypedQuery;
import javax.validation.constraints.NotNull;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class SeguidoresSeguidos {

    /**
     */
    @NotNull
    @ManyToOne
    private User seguidor;

    /**
     */
    @NotNull
    @ManyToOne
    private User seguido;

	public static List<User> findSeguidos(User user) {
    	EntityManager em = entityManager();
        TypedQuery<User> q = em.createQuery("SELECT seguido FROM SeguidoresSeguidos WHERE seguidor = :seguidor", User.class);
        q.setParameter("seguidor", user);
        return q.getResultList();
    }


}
