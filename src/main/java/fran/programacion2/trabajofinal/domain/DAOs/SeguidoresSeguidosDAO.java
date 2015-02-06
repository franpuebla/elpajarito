package fran.programacion2.trabajofinal.domain.DAOs;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import fran.programacion2.trabajofinal.domain.User;

public class SeguidoresSeguidosDAO extends SeguidoresSeguidos {
	
	public static List<User> findSeguidos(User user) {
    	EntityManager em = entityManager();
        TypedQuery<User> q = em.createQuery("SELECT seguido FROM SeguidoresSeguidos WHERE seguidor = :seguidor", User.class);
        q.setParameter("seguidor", user);
        return q.getResultList();
    }

}
