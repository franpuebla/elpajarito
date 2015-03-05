package fran.programacion2.trabajofinal.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.persistence.ManyToOne;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.TypedQuery;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.json.RooJson;

import fran.programacion2.trabajofinal.web.MensajeController;

import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.OneToMany;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
@RooJson
@RooWebJson(jsonObject = MensajeController.class)
public class Mensaje implements Comparable<Mensaje> {

    /**
     */
    @NotNull
    @Size(min = 1, max = 140)
    private String texto;

    /**
     */
    @NotNull
    @ManyToOne
    private User autor;
    
    private String fecha;

    private String autorOriginal;
    
    /**
     */
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "M-")
    private Date fechaPublicacion;

    public static List<Mensaje> findAllMensajesforUser(User user) {
        EntityManager em = Mensaje.entityManager();
        TypedQuery<Mensaje> q = em.createQuery("SELECT o FROM Mensaje AS o WHERE o.autor = :autor", Mensaje.class);
        q.setParameter("autor", user);
        return q.getResultList();
    }

    /**
     */
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idMensaje")
    private Set<Hashtag> hashtag = new HashSet<Hashtag>();

    /**
     */
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idMensaje")
    private Set<Referencia> referencias = new HashSet<Referencia>();

    @Override
    public int compareTo(Mensaje otroMensaje) {
    	 Date a = getFechaPublicacion();
         Date b = otroMensaje.getFechaPublicacion();
         if (a.after(b)) 
           return -1;
         else if (a.equals(b)) // it's equals
            return 0;
         else
            return 1;
      
    }

}
