// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.domain;

import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

privileged aspect SeguidoresSeguidos_Roo_Jpa_Entity {
    
    declare @type: SeguidoresSeguidos: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long SeguidoresSeguidos.id;
    
    @Version
    @Column(name = "version")
    private Integer SeguidoresSeguidos.version;
    
    public Long SeguidoresSeguidos.getId() {
        return this.id;
    }
    
    public void SeguidoresSeguidos.setId(Long id) {
        this.id = id;
    }
    
    public Integer SeguidoresSeguidos.getVersion() {
        return this.version;
    }
    
    public void SeguidoresSeguidos.setVersion(Integer version) {
        this.version = version;
    }
    
}
