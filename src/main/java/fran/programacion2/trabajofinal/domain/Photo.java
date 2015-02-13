package fran.programacion2.trabajofinal.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

import javax.persistence.Basic;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Photo {

    /**
     */
    @NotNull
    private String filename;

    /**
     */
    @NotNull
    private String contentType;
    
    @NotNull
    @Lob
    @Basic(fetch = FetchType.LAZY)
    private byte[] content;
    
    @Transient
    @Size(max = 100)
    private String url;
}
