package at.fh.swenga.urent.controller;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
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
	@Transactional
	public String signUp(@Valid @ModelAttribute User user,
			BindingResult bindingResult, Model model) {
		
		if (bindingResult.hasErrors()) {
			String errorMessage = "";
			for (FieldError fieldError : bindingResult.getFieldErrors()) {
				errorMessage += fieldError.getField() + " is invalid<br>";
			}
			model.addAttribute("errorMessage", errorMessage);
			return "signup";
		}

		String errorMessage = "";

		try {
			User existingUser = userDao.getUser(user.getUsername());
			if (existingUser == null) {

				User newUser = new User();
				newUser.setUsername(user.getUsername());
				newUser.setFirstname(user.getFirstname());
				newUser.setLastname(user.getLastname());
				newUser.setEmail(user.getEmail());
				newUser.setTelephone(user.getTelephone());
				BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
				newUser.setPassword(encoder.encode(user.getPassword()));
				newUser.setEnabled(true);
				userDao.persist(newUser);

				UserRole standardUser = new UserRole();
				standardUser.setUser(newUser);
				standardUser.setRole("ROLE_USER");
				userRoleDao.persist(standardUser);

				model.addAttribute("message", "User " + newUser.getUsername()
						+ " successfully added!");
				return "forward:/list";
			} else {
				model.addAttribute("errorMessage",
						"There is already a User with this Username");
				return "signup";
			}

		} catch (Exception e) {
			errorMessage += "Invalid data";
			return "signup";
		}

	}

}
