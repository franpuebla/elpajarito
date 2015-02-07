// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.domain;

import fran.programacion2.trabajofinal.domain.Hashtag;
import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.domain.Referencia;
import fran.programacion2.trabajofinal.domain.User;
import java.util.Date;
import java.util.Set;

privileged aspect Mensaje_Roo_JavaBean {
    
    public String Mensaje.getTexto() {
        return this.texto;
    }
    
    public void Mensaje.setTexto(String texto) {
        this.texto = texto;
    }
    
    public User Mensaje.getAutor() {
        return this.autor;
    }
    
    public void Mensaje.setAutor(User autor) {
        this.autor = autor;
    }
    
    public Date Mensaje.getFechaPublicacion() {
        return this.fechaPublicacion;
    }
    
    public void Mensaje.setFechaPublicacion(Date fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }
    
    public Set<Hashtag> Mensaje.getHashtag() {
        return this.hashtag;
    }
    
    public void Mensaje.setHashtag(Set<Hashtag> hashtag) {
        this.hashtag = hashtag;
    }
    
    public Set<Referencia> Mensaje.getReferencias() {
        return this.referencias;
    }
    
    public void Mensaje.setReferencias(Set<Referencia> referencias) {
        this.referencias = referencias;
    }
    
}
