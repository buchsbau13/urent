package at.fh.swenga.urent.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RegisterController {

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String showSignup(Model model) {

		return "signup";
	}

}
