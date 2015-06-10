package at.fh.swenga.urent.controller;

import java.io.IOException;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import at.fh.swenga.urent.dao.CategoryDao;
import at.fh.swenga.urent.dao.RentableDao;
import at.fh.swenga.urent.dao.UserDao;
import at.fh.swenga.urent.dao.UserRoleDao;
import at.fh.swenga.urent.model.Address;
import at.fh.swenga.urent.model.Category;
import at.fh.swenga.urent.model.Rentable;
import at.fh.swenga.urent.model.RentableForm;
import at.fh.swenga.urent.model.User;
import at.fh.swenga.urent.model.UserRole;

@Controller
public class DashboardController {

	@Autowired
	RentableDao rentableDao;

	@Autowired
	CategoryDao categoryDao;

	@Autowired
	UserDao userDao;
	
	@Autowired 
	UserRoleDao userRoleDao; 

	@RequestMapping(value = "/editRentable", method = RequestMethod.GET)
	public String showEditRentableForm(Model model, @RequestParam int id) {

		List<Category> categories = categoryDao.getCategories();
		model.addAttribute("rentable", rentableDao.getRentable(id));
		model.addAttribute("command", new RentableForm());
		model.addAttribute("categories", categories);

		return "editRentable";
	}

	@RequestMapping(value = "/editRentable", method = RequestMethod.POST)
	public String editRentable(@Valid @ModelAttribute RentableForm rentable,
			BindingResult bindingResult,
			@RequestParam("file") MultipartFile file, Model model)
			throws IOException {

		Rentable changedRentable = rentableDao.getRentable(rentable.getId());

		if (changedRentable == null) {
			model.addAttribute("errorMessage", "Rentable does not exist!<br>");
		} else {
			byte[] image = file.getBytes();
			changedRentable.setTitle(rentable.getTitle());
			changedRentable.setDescription(rentable.getDescription());
			changedRentable.setPrice(rentable.getPrice());
			changedRentable.setImage(image);

			Address location = new Address(rentable.getStreet(),
					rentable.getCity(), rentable.getCountry(),
					rentable.getZip());
			changedRentable.setLocation(location);
			rentableDao.merge(changedRentable);

			model.addAttribute("message",
					"Changed Rentable " + changedRentable.getId());
		}

		return "forward:/list";
	}

	@RequestMapping(value = "/showRentable", method = RequestMethod.GET)
	public String showRentable(Model model, @RequestParam int id) {

		model.addAttribute("rentable", rentableDao.getRentable(id));

		return "showRentable";
	}

	@RequestMapping(value = "/editUser", method = RequestMethod.GET)
	public String showEditUser(Model model, @RequestParam String username) {

		model.addAttribute("user", userDao.getUser(username));

		return "editUser";
	}

	@RequestMapping(value = "/editUser", method = RequestMethod.POST)
	public String editUser(@Valid @ModelAttribute User user,
			BindingResult bindingResult, Model model) throws IOException {

		User changedUser = userDao.getUser(user.getUsername());

		if (changedUser == null) {
			model.addAttribute("errorMessage", "User does not exist!<br>");
		} else {
			changedUser.setEmail(user.getEmail());
			changedUser.setFirstname(user.getFirstname());
			changedUser.setLastname(user.getLastname());
			changedUser.setTelephone(user.getTelephone());
			userDao.merge(changedUser); 
			
			model.addAttribute("message",
					"Changed User " + changedUser.getUsername());
		}

		return "forward:/dashboard";
	}

}
