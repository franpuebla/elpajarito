package fran.programacion2.trabajofinal.web;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import fran.programacion2.trabajofinal.domain.User;




//Indica que a este controlador se podra acceder a traves de la direccion http://localhost:8080/ProyectoJDBC/controla/
@RequestMapping("/controla")
//Le indica al springMVC que esta clase es un controlador (servlet)
@Controller
public class Controlador1Controller {


 
	
	@RequestMapping(value={"/listar", "/listar2"}, method = { RequestMethod.GET, RequestMethod.POST }, produces = "text/html")
    public String listar(Model uiModel, HttpServletRequest request, HttpServletResponse response) {
    	// el metodo findAll??? esta definido en todos los modelos y recupera todos los registros
		// de la tabla y los coloca en una List.
		
		
		List<Mensaje> mensajes = Mensaje.findAllMensajes();
	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
       
		List<Mensaje> mensajesUser = Mensaje.findAllMensajesforUser(User.findUsersByEmailAddress(userName).getSingleResult());
    	
		uiModel.addAttribute("mensajes", mensajes);
    	uiModel.addAttribute("mensajesUser", mensajesUser);
    	
    	//Indico que quiero acceder a la vista referenciada por "controla/listar"
    	return "controla/listar";
    }

	
	@RequestMapping(value={"/listarMS"}, method = { RequestMethod.GET, RequestMethod.POST }, produces = "text/html")
    public String listarMS(Model uiModel, HttpServletRequest request, HttpServletResponse response) {
    	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
        User user = User.findUsersByEmailAddress(userName).getSingleResult();
        
        List<User> seguidos = SeguidoresSeguidos.findSeguidos(user);
        
        List<Mensaje> listaGrande = new ArrayList<Mensaje>();
       
        for(int i = 0 ; i < seguidos.size() ; i++){
		 	User seguido = seguidos.get(i);
		 	
		 	List<Mensaje> mensajesdeSeguido = Mensaje.findAllMensajesforUser(seguido);
		 	listaGrande.addAll(mensajesdeSeguido);
		 	
        }
         
		 	uiModel.addAttribute("mensajesdeSeguido", listaGrande);
	    	
        return "controla/listarMS";
    }


	/*
	Se invoca este método cuando se accede a http://localhost:8080/ProyectoJDBC/controla/editar
	utilizando metodo GET y produce como resultado un HTML.
	* Este metodo recupera una persona de acuerdo a su ID para armar el formulario de modificacion de los datos.
	El ID viene como parametro normal y se lee con @RequestParam
	*/
/*	@RequestMapping(value = "/editar", method = RequestMethod.GET, produces = "text/html")
    public String editar(@RequestParam("id") Long id, Model uiModel, HttpServletRequest request, HttpServletResponse response) {
    	//Recupero la persona con el id
		User persona = User.findUser(id);
		// coloco el objeto en uiModel
		uiModel.addAttribute("persona", persona);
		//Indico que quiero acceder a la vista referenciada por "controla/editar"
		return "controla/editar";
    }

	/*
	Se invoca este método cuando se accede a http://localhost:8080/ProyectoJDBC/controla/edicionGrabar
	utilizando metodo GET y produce como resultado un HTML.
	* Este metodo recupera un objeto persona de acuerdo a los campos del formulario. Si hay error en los datos devuelvo el control
	a la vista de formulario, si esta bien lo modifico (merge) y retorno un mensaje de accion a la accion de listar
	*/
	
	
	/*
	Se invoca este método cuando se accede a http://localhost:8080/ProyectoJDBC/controla/accion/--accion--/--id--
	utilizando metodo GET y produce como resultado un HTML.
	* Se utiliza la anotacion @PathVariable para extrar la porcion que se encuentra encerrada entre {}, se puede
	recuperar mas de un parametro
	* Este metodo recupera borra (por que es la accion que seleccione) el objeto persona de acuerdo a su ID.
	*/

	
	
	
	
	
	
	
	
	
	
	
	
}
