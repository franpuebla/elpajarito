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
        
        model.addAttribute("users", todos);
        model.addAttribute("logueado", user);
        model.addAttribute("seguidos", seguidos);
    	
        return "seguidoresseguidoses/nuevoSeguidor";
    }
	
	@RequestMapping(value="/guardarSeguidor", method = RequestMethod.POST, produces = "text/html")
    public void createFromJson(@RequestBody String data) {
        System.out.println("\n\n\nEstoy aca\n"+data);
		
	//	SeguidoresSeguidos seguidoresSeguidos =;
	}
}
