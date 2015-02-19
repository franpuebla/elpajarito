package fran.programacion2.trabajofinal.web;

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
import fran.programacion2.trabajofinal.domain.User;


@RequestMapping("/")
@Controller
public class LoginController {

	@RequestMapping(method = RequestMethod.GET)
    public String listar(Model model) {
		List<Mensaje> mensajes = Mensaje.findAllMensajes();
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
       
		List<Mensaje> mensajesUser = Mensaje.findAllMensajesforUser(User.findUsersByEmailAddress(userName).getSingleResult());
    	
		model.addAttribute("mensajes", mensajes);
    	model.addAttribute("mensajesUser", mensajesUser);
        return "index";
    }
	
	
}
