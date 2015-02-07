// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.domain;

import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect SeguidoresSeguidos_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager SeguidoresSeguidos.entityManager;
    
    public static final EntityManager SeguidoresSeguidos.entityManager() {
        EntityManager em = new SeguidoresSeguidos().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long SeguidoresSeguidos.countSeguidoresSeguidoses() {
        return entityManager().createQuery("SELECT COUNT(o) FROM SeguidoresSeguidos o", Long.class).getSingleResult();
    }
    
    public static List<SeguidoresSeguidos> SeguidoresSeguidos.findAllSeguidoresSeguidoses() {
        return entityManager().createQuery("SELECT o FROM SeguidoresSeguidos o", SeguidoresSeguidos.class).getResultList();
    }
    
    public static SeguidoresSeguidos SeguidoresSeguidos.findSeguidoresSeguidos(Long id) {
        if (id == null) return null;
        return entityManager().find(SeguidoresSeguidos.class, id);
    }
    
    public static List<SeguidoresSeguidos> SeguidoresSeguidos.findSeguidoresSeguidosEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM SeguidoresSeguidos o", SeguidoresSeguidos.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void SeguidoresSeguidos.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void SeguidoresSeguidos.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            SeguidoresSeguidos attached = SeguidoresSeguidos.findSeguidoresSeguidos(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void SeguidoresSeguidos.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void SeguidoresSeguidos.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public SeguidoresSeguidos SeguidoresSeguidos.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        SeguidoresSeguidos merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
