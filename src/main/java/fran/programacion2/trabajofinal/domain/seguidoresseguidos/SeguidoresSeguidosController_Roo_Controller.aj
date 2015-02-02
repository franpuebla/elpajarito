// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.domain.seguidoresseguidos;

import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import fran.programacion2.trabajofinal.domain.User;
import fran.programacion2.trabajofinal.domain.seguidoresseguidos.SeguidoresSeguidosController;
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

privileged aspect SeguidoresSeguidosController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String SeguidoresSeguidosController.create(@Valid SeguidoresSeguidos seguidoresSeguidos, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, seguidoresSeguidos);
            return "seguidoresseguidoses/create";
        }
        uiModel.asMap().clear();
        seguidoresSeguidos.persist();
        return "redirect:/seguidoresseguidoses/" + encodeUrlPathSegment(seguidoresSeguidos.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String SeguidoresSeguidosController.createForm(Model uiModel) {
        populateEditForm(uiModel, new SeguidoresSeguidos());
        List<String[]> dependencies = new ArrayList<String[]>();
        if (User.countUsers() == 0) {
            dependencies.add(new String[] { "user", "users" });
        }
        if (User.countUsers() == 0) {
            dependencies.add(new String[] { "user", "users" });
        }
        uiModel.addAttribute("dependencies", dependencies);
        return "seguidoresseguidoses/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String SeguidoresSeguidosController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("seguidoresseguidos", SeguidoresSeguidos.findSeguidoresSeguidos(id));
        uiModel.addAttribute("itemId", id);
        return "seguidoresseguidoses/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String SeguidoresSeguidosController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("seguidoresseguidoses", SeguidoresSeguidos.findSeguidoresSeguidosEntries(firstResult, sizeNo));
            float nrOfPages = (float) SeguidoresSeguidos.countSeguidoresSeguidoses() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("seguidoresseguidoses", SeguidoresSeguidos.findAllSeguidoresSeguidoses());
        }
        return "seguidoresseguidoses/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String SeguidoresSeguidosController.update(@Valid SeguidoresSeguidos seguidoresSeguidos, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, seguidoresSeguidos);
            return "seguidoresseguidoses/update";
        }
        uiModel.asMap().clear();
        seguidoresSeguidos.merge();
        return "redirect:/seguidoresseguidoses/" + encodeUrlPathSegment(seguidoresSeguidos.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String SeguidoresSeguidosController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, SeguidoresSeguidos.findSeguidoresSeguidos(id));
        return "seguidoresseguidoses/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String SeguidoresSeguidosController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        SeguidoresSeguidos seguidoresSeguidos = SeguidoresSeguidos.findSeguidoresSeguidos(id);
        seguidoresSeguidos.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/seguidoresseguidoses";
    }
    
    void SeguidoresSeguidosController.populateEditForm(Model uiModel, SeguidoresSeguidos seguidoresSeguidos) {
        uiModel.addAttribute("seguidoresSeguidos", seguidoresSeguidos);
        uiModel.addAttribute("users", User.findAllUsers());
    }
    
    String SeguidoresSeguidosController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
