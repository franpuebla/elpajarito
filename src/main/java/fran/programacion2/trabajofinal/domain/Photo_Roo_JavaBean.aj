// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.domain;

import fran.programacion2.trabajofinal.domain.Photo;

privileged aspect Photo_Roo_JavaBean {
    
    public String Photo.getFilename() {
        return this.filename;
    }
    
    public void Photo.setFilename(String filename) {
        this.filename = filename;
    }
    
    public String Photo.getContentType() {
        return this.contentType;
    }
    
    public void Photo.setContentType(String contentType) {
        this.contentType = contentType;
    }
    
    public byte[] Photo.getContent() {
        return this.content;
    }
    
    public void Photo.setContent(byte[] content) {
        this.content = content;
    }
    
    public String Photo.getUrl() {
        return this.url;
    }
    
    public void Photo.setUrl(String url) {
        this.url = url;
    }
    
}