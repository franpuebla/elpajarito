package fran.programacion2.trabajofinal.web;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import fran.programacion2.trabajofinal.domain.Hashtag;
import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.domain.Referencia;
import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import fran.programacion2.trabajofinal.domain.User;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;

@RequestMapping("/mensajes")
@Controller
@RooWebScaffold(path = "mensajes", formBackingObject = Mensaje.class)
@RooWebJson(jsonObject = Mensaje.class)
public class MensajeController {

	
	@RequestMapping(value= "/getAll")
    @ResponseBody
    public ResponseEntity<String> listJson() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json; charset=utf-8");
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
        User user = User.findUsersByEmailAddress(userName).getSingleResult();
       
		List<Mensaje> mensajesUser = Mensaje.findAllMensajesforUser(user);
		
		List<User> seguidos = SeguidoresSeguidos.findSeguidos(user);
        
        List<Mensaje> listaGrande = new ArrayList<Mensaje>();
       
        for(int i = 0 ; i < seguidos.size() ; i++){
		 	User seguido = seguidos.get(i);
		 	
		 	List<Mensaje> mensajesdeSeguido = Mensaje.findAllMensajesforUser(seguido);
		 	listaGrande.addAll(mensajesdeSeguido);
		 	
        }
        listaGrande.addAll(mensajesUser);
        Collections.sort(listaGrande);
        
        
        return new ResponseEntity<String>(Mensaje.toJsonArray(listaGrande), headers, HttpStatus.OK);
    }
	
    @RequestMapping(method = RequestMethod.POST, headers = "Accept=application/json")
    public ResponseEntity<String> createFromJson(@RequestBody String json) {
        Mensaje mensaje = Mensaje.fromJsonToMensaje(json);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
        mensaje.setAutor(User.findUsersByEmailAddress(userName).getSingleResult());
        mensaje.setFechaPublicacion(new Date());
        mensaje.persist();
        parsearMensaje(mensaje);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        return new ResponseEntity<String>(headers, HttpStatus.CREATED);
    }

    private void parsearMensaje(Mensaje mensaje) {
        String[] tokens = mensaje.getTexto().split("\\s+");
        parsearHashtag(tokens, mensaje);
        parsearReferencias(tokens, mensaje);
    }

    private void parsearHashtag(String[] tokens, Mensaje mensaje) {
        for (int i = 0; i < tokens.length; i++) {
            if (tokens[i].contains("#")) {
                String[] subTokens = tokens[i].split("#");
                for (int j = 1; j < subTokens.length; j++) {
                    String hash = subTokens[j];
                    Hashtag hashtag = new Hashtag();
                    hashtag.setHash(hash);
                    hashtag.setIdMensaje(mensaje);
                    hashtag.persist();
                }
            }
        }
    }

    private void parsearReferencias(String[] tokens, Mensaje mensaje) {
        for (int i = 0; i < tokens.length; i++) {
            if (tokens[i].contains("@")) {
                String[] subTokens = tokens[i].split("@");
                for (int j = 1; j < subTokens.length; j++) {
                    String referido = subTokens[j];
                    User nick = User.findUsersByNick(referido).getSingleResult();
                    if(nick != null){
	                    Referencia referencia = new Referencia();
	                    referencia.setReferido(nick);
	                    referencia.setIdMensaje(mensaje);
	                    referencia.persist();
                    }
                }
            }
        }
    }
}
