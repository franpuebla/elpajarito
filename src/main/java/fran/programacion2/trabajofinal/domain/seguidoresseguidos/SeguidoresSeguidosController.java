package fran.programacion2.trabajofinal.domain.seguidoresseguidos;
import java.util.List;

import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import fran.programacion2.trabajofinal.domain.User;

import org.springframework.http.ResponseEntity;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/seguidoresseguidoses")
@Controller
@RooWebScaffold(path = "seguidoresseguidoses", formBackingObject = SeguidoresSeguidos.class)
public class SeguidoresSeguidosController {
	

	@RequestMapping(value="/nuevoSeguidor", method = RequestMethod.GET, produces = "text/html")
    public String nuevoSeguidor(Model model) {
				
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
        User user = User.findUsersByEmailAddress(userName).getSingleResult();
 		
		List<User> seguidos = SeguidoresSeguidos.findSeguidos(user);
		List<User> todos = User.findAllUsers();
        
        model.addAttribute("users",todos);
        model.addAttribute("logueado",user);
        model.addAttribute("seguidos",seguidos);
    	
        return "seguidoresseguidoses/nuevoSeguidor";
    }
	
	@RequestMapping(value = "/seguir/{id}", method = RequestMethod.GET, produces = "text/html")
    public String Seguir(@PathVariable("id") Long id)  {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
        User userLogueado = User.findUsersByEmailAddress(userName).getSingleResult();
		User user = User.findUser(id);
		SeguidoresSeguidos seguidoresSeguidos = new SeguidoresSeguidos();
		seguidoresSeguidos.setSeguido(user);
		seguidoresSeguidos.setSeguidor(userLogueado);
		seguidoresSeguidos.persist();
		
    	
		return "redirect:/seguidoresseguidoses/nuevoSeguidor";
    }

    @RequestMapping(value = "/noSeguir/{id}", method = RequestMethod.GET)
    public String NoSeguir(@PathVariable("id") Long idUser) {
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
        User userLogueado = User.findUsersByEmailAddress(userName).getSingleResult();
        User userSeguido = User.findUser(idUser);
    	SeguidoresSeguidos seguidorSeguido = SeguidoresSeguidos.findSeguidoresSeguidosById(userLogueado, userSeguido);
    	seguidorSeguido.remove();
        return "redirect:/seguidoresseguidoses/nuevoSeguidor";
    }
}
