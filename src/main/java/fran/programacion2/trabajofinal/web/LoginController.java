package fran.programacion2.trabajofinal.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import fran.programacion2.trabajofinal.domain.Hashtag;
import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.domain.Photo;
import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import fran.programacion2.trabajofinal.domain.User;


@RequestMapping("/")
@Controller
public class LoginController {

	@RequestMapping(method = RequestMethod.GET)
    public String listar(Model model) {
				
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
        
        model.addAttribute("mensajes", listaGrande);
    	
        return "index";
    }
	
	
}
