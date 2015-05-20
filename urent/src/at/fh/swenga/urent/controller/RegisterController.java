package at.fh.swenga.urent.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import at.fh.swenga.urent.dao.UserDao;
import at.fh.swenga.urent.dao.UserRoleDao;
import at.fh.swenga.urent.model.User;
import at.fh.swenga.urent.model.UserRole;

@Controller
public class RegisterController {
	
	@Autowired
	UserDao userDao; 
	
	@Autowired
	UserRoleDao userRoleDao; 

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String showSignup(Model model) {

		return "signup";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signupProcess(
			@Valid @ModelAttribute User user,
			BindingResult bindingResult, Model model) {
		
		User newUser = new User(); 
		newUser.setUsername(user.getUsername());
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		newUser.setPassword(encoder.encode(user.getPassword()));
		newUser.setEnabled(true);
		userDao.persist(newUser);
		
		UserRole standardUser = new UserRole(); 
		standardUser.setUser(newUser);
		standardUser.setRole("ROLE_USER");
		userRoleDao.persist(standardUser);
		
		return "forward:list"; 
	}

}
