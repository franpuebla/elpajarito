// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.web;

import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.domain.Referencia;
import fran.programacion2.trabajofinal.domain.User;
import fran.programacion2.trabajofinal.web.ReferenciaController;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect ReferenciaController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String ReferenciaController.create(@Valid Referencia referencia, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, referencia);
            return "referencias/create";
        }
        uiModel.asMap().clear();
        referencia.persist();
        return "redirect:/referencias/" + encodeUrlPathSegment(referencia.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String ReferenciaController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Referencia());
        List<String[]> dependencies = new ArrayList<String[]>();
        if (Mensaje.countMensajes() == 0) {
            dependencies.add(new String[] { "mensaje", "mensajes" });
        }
        if (User.countUsers() == 0) {
            dependencies.add(new String[] { "user", "users" });
        }
        uiModel.addAttribute("dependencies", dependencies);
        return "referencias/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String ReferenciaController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("referencia", Referencia.findReferencia(id));
        uiModel.addAttribute("itemId", id);
        return "referencias/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String ReferenciaController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("referencias", Referencia.findReferenciaEntries(firstResult, sizeNo));
            float nrOfPages = (float) Referencia.countReferencias() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("referencias", Referencia.findAllReferencias());
        }
        return "referencias/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String ReferenciaController.update(@Valid Referencia referencia, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, referencia);
            return "referencias/update";
        }
        uiModel.asMap().clear();
        referencia.merge();
        return "redirect:/referencias/" + encodeUrlPathSegment(referencia.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String ReferenciaController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Referencia.findReferencia(id));
        return "referencias/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String ReferenciaController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Referencia referencia = Referencia.findReferencia(id);
        referencia.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/referencias";
    }
    
    void ReferenciaController.populateEditForm(Model uiModel, Referencia referencia) {
        uiModel.addAttribute("referencia", referencia);
        uiModel.addAttribute("mensajes", Mensaje.findAllMensajes());
        uiModel.addAttribute("users", User.findAllUsers());
    }
    
    String ReferenciaController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
