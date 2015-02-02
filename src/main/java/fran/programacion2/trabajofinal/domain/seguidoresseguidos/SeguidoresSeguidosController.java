package fran.programacion2.trabajofinal.domain.seguidoresseguidos;
import fran.programacion2.trabajofinal.domain.SeguidoresSeguidos;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/seguidoresseguidoses")
@Controller
@RooWebScaffold(path = "seguidoresseguidoses", formBackingObject = SeguidoresSeguidos.class)
public class SeguidoresSeguidosController {
}
