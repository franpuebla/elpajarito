// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.web;

import fran.programacion2.trabajofinal.domain.Hashtag;
import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.web.HashtagController;
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

privileged aspect HashtagController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String HashtagController.create(@Valid Hashtag hashtag, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, hashtag);
            return "hashtags/create";
        }
        uiModel.asMap().clear();
        hashtag.persist();
        return "redirect:/hashtags/" + encodeUrlPathSegment(hashtag.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String HashtagController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Hashtag());
        List<String[]> dependencies = new ArrayList<String[]>();
        if (Mensaje.countMensajes() == 0) {
            dependencies.add(new String[] { "mensaje", "mensajes" });
        }
        uiModel.addAttribute("dependencies", dependencies);
        return "hashtags/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String HashtagController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("hashtag", Hashtag.findHashtag(id));
        uiModel.addAttribute("itemId", id);
        return "hashtags/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String HashtagController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("hashtags", Hashtag.findHashtagEntries(firstResult, sizeNo));
            float nrOfPages = (float) Hashtag.countHashtags() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("hashtags", Hashtag.findAllHashtags());
        }
        return "hashtags/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String HashtagController.update(@Valid Hashtag hashtag, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, hashtag);
            return "hashtags/update";
        }
        uiModel.asMap().clear();
        hashtag.merge();
        return "redirect:/hashtags/" + encodeUrlPathSegment(hashtag.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String HashtagController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Hashtag.findHashtag(id));
        return "hashtags/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String HashtagController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Hashtag hashtag = Hashtag.findHashtag(id);
        hashtag.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/hashtags";
    }
    
    void HashtagController.populateEditForm(Model uiModel, Hashtag hashtag) {
        uiModel.addAttribute("hashtag", hashtag);
        uiModel.addAttribute("mensajes", Mensaje.findAllMensajes());
    }
    
    String HashtagController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
