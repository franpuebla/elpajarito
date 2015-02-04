// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.domain;

import fran.programacion2.trabajofinal.domain.Mensaje;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Mensaje_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Mensaje.entityManager;
    
    public static final EntityManager Mensaje.entityManager() {
        EntityManager em = new Mensaje().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Mensaje.countMensajes() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Mensaje o", Long.class).getSingleResult();
    }
    
    public static List<Mensaje> Mensaje.findAllMensajes() {
        return entityManager().createQuery("SELECT o FROM Mensaje o", Mensaje.class).getResultList();
    }
   
    
    public static Mensaje Mensaje.findMensaje(Long id) {
        if (id == null) return null;
        return entityManager().find(Mensaje.class, id);
    }
    
    public static List<Mensaje> Mensaje.findMensajeEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Mensaje o", Mensaje.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Mensaje.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Mensaje.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Mensaje attached = Mensaje.findMensaje(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Mensaje.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Mensaje.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Mensaje Mensaje.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Mensaje merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
