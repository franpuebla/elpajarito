package fran.programacion2.trabajofinal.web;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import fran.programacion2.trabajofinal.domain.Photo;
import fran.programacion2.trabajofinal.domain.User;

import org.apache.commons.io.IOUtils;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;

@RequestMapping("/photos")
@Controller
@RooWebScaffold(path = "photos", formBackingObject = Photo.class, update=false)
public class PhotoController {
	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder)
	                   throws ServletException {
	    binder.registerCustomEditor(byte[].class, new ByteArrayMultipartFileEditor());
	    }
	@RequestMapping(value="savepho",  method = RequestMethod.POST)
	public String createdoc(@Valid Photo photo, BindingResult result, Model model, @RequestParam("content") MultipartFile content,
	                            HttpServletRequest request) throws IOException {
	         
	        photo.setContentType(content.getContentType());
	        photo.setFilename(content.getOriginalFilename());
	        photo.setContent(content.getBytes());
	        //System.out.println("Document: ");
	        //System.out.println("Name: "+content.getOriginalFilename());
	        //System.out.println("Type: "+content.getContentType());
	       // if (result.hasErrors()) {
	         //   model.addAttribute("photo", photo);
	           // return "photos/create";
	        //}
	        photo.persist();
	        return show(photo.getId(),model); 
	       
	    }
	
	@RequestMapping(value = "showpho", method = RequestMethod.GET)
	public String showdoc1(HttpServletResponse response,
	                    Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userName = auth.getName(); //get logged in username
        User userLogueado = User.findUsersByEmailAddress(userName).getSingleResult();
		if(userLogueado != null){
        return showdoc(userLogueado.getIdPhoto().getId(), response, model);
		}
		else{
			return "";
		}
	}   
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") Long id, Model model) {
        Photo pho = Photo.findPhoto(id);
        pho.setUrl("photos/showpho/"+id);
        model.addAttribute("photo", Photo.findPhoto(id));
        model.addAttribute("itemId", id);
        return "photos/show";
    }
	     
	@RequestMapping(value = "/showpho/{id}", method = RequestMethod.GET)
	public String showdoc(  @PathVariable("id") Long id,
	                    HttpServletResponse response,
	                    Model model) {
	   Photo pho = Photo.findPhoto(id);
	                 
	   try {
	          //response.setHeader("Content-Disposition", "inline;filename=\"" +pho.getFilename()+ "\"");
	 
	          OutputStream out = response.getOutputStream();
	          response.setContentType(pho.getContentType());
	          IOUtils.copy( new ByteArrayInputStream(pho.getContent()),out);
	            out.flush();
	          
	        } catch (IOException e) {
	            e.printStackTrace();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return null;
	    }

}
