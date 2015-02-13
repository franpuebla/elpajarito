package fran.programacion2.trabajofinal.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.persistence.Column;
import java.util.Date;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.OneToMany;
import javax.persistence.ManyToOne;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(finders = { "findUsersByEmailAddress", "findUsersByActivationKeyAndEmailAddress", "findUsersByNick" })
public class User {

    /**
     */
    @NotNull
    @Size(min = 1)
    private String firstName;

    /**
     */
    @NotNull
    @Size(min = 1)
    private String lastName;

    /**
     */
    @NotNull
    @Column(unique = true)
    @Size(min = 1)
    private String emailAddress;

    /**
     */
    @NotNull
    @Size(min = 1)
    private String password;

    /**
     */
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "M-")
    private Date activationDate;

    /**
     */
    private String activationKey;

    /**
     */
    private Boolean enabled;

    /**
     */
    private Boolean locked;

    /**
     */
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "autor")
    private Set<Mensaje> listaMensajes = new HashSet<Mensaje>();

    /**
     */
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "seguido")
    private Set<SeguidoresSeguidos> listaSeguidores = new HashSet<SeguidoresSeguidos>();

    /**
     */
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "seguidor")
    private Set<SeguidoresSeguidos> listaSeguidos = new HashSet<SeguidoresSeguidos>();

    /**
     */
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "referido")
    private Set<Referencia> referencias = new HashSet<Referencia>();

    /**
     */
    @NotNull
    @Column(unique = true)
    @Size(min = 1, max = 15)
    private String nick;

    /**
     */
    @Size(min = 1, max = 500)
    private String description;

    /**
     */
    @ManyToOne
    private Photo idPhoto;
}
