package fran.programacion2.trabajofinal.web;
import fran.programacion2.trabajofinal.domain.Referencia;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/referencias")
@Controller
@RooWebScaffold(path = "referencias", formBackingObject = Referencia.class)
public class ReferenciaController {
}
