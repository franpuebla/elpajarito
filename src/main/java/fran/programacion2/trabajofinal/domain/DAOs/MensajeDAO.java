package fran.programacion2.trabajofinal.domain.DAOs;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.domain.User;

public class MensajeDAO extends Mensaje {
	
	public static List<Mensaje> findAllMensajesforUser(User user) {
    	EntityManager em = Mensaje.entityManager();
        TypedQuery<Mensaje> q = em.createQuery("SELECT o FROM Mensaje AS o WHERE o.autor = :autor", Mensaje.class);
        q.setParameter("autor", user);
        return q.getResultList();
    }

}
