// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.domain;

import fran.programacion2.trabajofinal.domain.Hashtag;
import fran.programacion2.trabajofinal.domain.Mensaje;

privileged aspect Hashtag_Roo_JavaBean {
    
    public Mensaje Hashtag.getIdMensaje() {
        return this.idMensaje;
    }
    
    public void Hashtag.setIdMensaje(Mensaje idMensaje) {
        this.idMensaje = idMensaje;
    }
    
    public String Hashtag.getHash() {
        return this.hash;
    }
    
    public void Hashtag.setHash(String hash) {
        this.hash = hash;
    }
    
}
