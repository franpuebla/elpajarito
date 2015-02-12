package fran.programacion2.trabajofinal.web;
import fran.programacion2.trabajofinal.domain.Hashtag;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/hashtags")
@Controller
@RooWebScaffold(path = "hashtags", formBackingObject = Hashtag.class)
public class HashtagController {
}
