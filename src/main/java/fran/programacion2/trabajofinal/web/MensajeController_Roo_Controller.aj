// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package fran.programacion2.trabajofinal.web;

import fran.programacion2.trabajofinal.domain.Hashtag;
import fran.programacion2.trabajofinal.domain.Mensaje;
import fran.programacion2.trabajofinal.domain.Referencia;
import fran.programacion2.trabajofinal.domain.User;
import fran.programacion2.trabajofinal.web.MensajeController;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect MensajeController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String MensajeController.create(@Valid Mensaje mensaje, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, mensaje);
            return "mensajes/create";
        }
        uiModel.asMap().clear();
        mensaje.persist();
        return "redirect:/mensajes/" + encodeUrlPathSegment(mensaje.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String MensajeController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Mensaje());
        List<String[]> dependencies = new ArrayList<String[]>();
        if (User.countUsers() == 0) {
            dependencies.add(new String[] { "user", "users" });
        }
        uiModel.addAttribute("dependencies", dependencies);
        return "mensajes/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String MensajeController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("mensaje", Mensaje.findMensaje(id));
        uiModel.addAttribute("itemId", id);
        return "mensajes/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String MensajeController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("mensajes", Mensaje.findMensajeEntries(firstResult, sizeNo));
            float nrOfPages = (float) Mensaje.countMensajes() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("mensajes", Mensaje.findAllMensajes());
        }
        addDateTimeFormatPatterns(uiModel);
        return "mensajes/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String MensajeController.update(@Valid Mensaje mensaje, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, mensaje);
            return "mensajes/update";
        }
        uiModel.asMap().clear();
        mensaje.merge();
        return "redirect:/mensajes/" + encodeUrlPathSegment(mensaje.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String MensajeController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Mensaje.findMensaje(id));
        return "mensajes/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String MensajeController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Mensaje mensaje = Mensaje.findMensaje(id);
        mensaje.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/mensajes";
    }
    
    void MensajeController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("mensaje_fechapublicacion_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    void MensajeController.populateEditForm(Model uiModel, Mensaje mensaje) {
        uiModel.addAttribute("mensaje", mensaje);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("hashtags", Hashtag.findAllHashtags());
        uiModel.addAttribute("referencias", Referencia.findAllReferencias());
        uiModel.addAttribute("users", User.findAllUsers());
    }
    
    String MensajeController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
