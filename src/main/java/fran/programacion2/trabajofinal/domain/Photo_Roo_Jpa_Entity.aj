// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.domain;

import fran.programacion2.trabajofinal.domain.Photo;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

privileged aspect Photo_Roo_Jpa_Entity {
    
    declare @type: Photo: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Photo.id;
    
    @Version
    @Column(name = "version")
    private Integer Photo.version;
    
    public Long Photo.getId() {
        return this.id;
    }
    
    public void Photo.setId(Long id) {
        this.id = id;
    }
    
    public Integer Photo.getVersion() {
        return this.version;
    }
    
    public void Photo.setVersion(Integer version) {
        this.version = version;
    }
    
}
