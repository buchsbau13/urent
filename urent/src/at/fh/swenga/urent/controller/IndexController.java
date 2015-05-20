package at.fh.swenga.urent.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
public class IndexController {

	@Autowired
	RentableDao rentableDao;

	@Autowired
	CategoryDao categoryDao;

	@Autowired
	UserDao userDao;

	@Autowired
	UserRoleDao userRoleDao;

	@RequestMapping(value = { "/", "list" })
	public String index(Model model) {

		List<Rentable> rentables = rentableDao.getRentables();
		model.addAttribute("rentables", rentables);

		return "index";
	}

	@RequestMapping(value = "/getImage/{id}")
	public void showImage(HttpServletResponse response,
			@PathVariable("id") int rentableId) throws IOException {

		Rentable rentable = rentableDao.getRentable(rentableId);
		response.setContentType("image/jpeg");
		OutputStream out = response.getOutputStream();
		out.write(rentable.getImage());
		out.flush();

	}

	@RequestMapping("/init")
	@Transactional
	public String init(Model model) {

		Category entertainment = categoryDao.getCategory("Entertainment");
		if (entertainment == null)
			entertainment = new Category("Entertainment");
		categoryDao.persist(entertainment);

		Category garden = categoryDao.getCategory("Garden");
		if (garden == null)
			garden = new Category("Garden");
		categoryDao.persist(garden);

		Category hobby = categoryDao.getCategory("Hobby");
		if (hobby == null)
			hobby = new Category("Hobby");
		categoryDao.persist(hobby);

		Category kitchen = categoryDao.getCategory("Kitchen");
		if (kitchen == null)
			kitchen = new Category("Kitchen");
		categoryDao.persist(kitchen);

		Category music = categoryDao.getCategory("Music");
		if (music == null)
			music = new Category("Music");
		categoryDao.persist(music);

		Category sport = categoryDao.getCategory("Sport");
		if (sport == null)
			sport = new Category("Sport");
		categoryDao.persist(sport);

		Category tools = categoryDao.getCategory("Tools");
		if (tools == null)
			tools = new Category("Tools");
		categoryDao.persist(tools);

		User admin = userDao.getUser("admin");
		if (admin == null)
			admin = new User(
					"admin",
					"$2a$10$2BZh7qw/FSh23ZCbojA.OOoo7vzg7KaqHUp34l8/i9.ktxzcr3vJm",
					true);
		userDao.persist(admin);

		UserRole roleAdmin1 = new UserRole(admin, "ROLE_ADMIN");
		userRoleDao.persist(roleAdmin1);

		UserRole roleUser1 = new UserRole(admin, "ROLE_USER");
		userRoleDao.persist(roleUser1);

		User user = userDao.getUser("user");
		if (user == null)
			user = new User(
					"user",
					"$2a$10$2BZh7qw/FSh23ZCbojA.OOoo7vzg7KaqHUp34l8/i9.ktxzcr3vJm",
					true);
		userDao.persist(user);

		UserRole roleUser2 = new UserRole(user, "ROLE_USER");
		userRoleDao.persist(roleUser2);

		User julia = userDao.getUser("julia");
		if (julia == null)
			julia = new User(
					"julia",
					"$2a$10$2BZh7qw/FSh23ZCbojA.OOoo7vzg7KaqHUp34l8/i9.ktxzcr3vJm",
					true);
		userDao.persist(julia);

		UserRole roleAdmin2 = new UserRole(julia, "ROLE_ADMIN");
		userRoleDao.persist(roleAdmin2);

		UserRole roleUser3 = new UserRole(julia, "ROLE_USER");
		userRoleDao.persist(roleUser3);

		return "forward:/list";

	}

	@RequestMapping(value = "/newRentable", method = RequestMethod.GET)
	public String showNewRentableForm(Model model) {

		List<Category> categories = categoryDao.getCategories();
		model.addAttribute("categories", categories);
		model.addAttribute("command", new RentableForm());
		return "newRentable";
	}

	@RequestMapping(value = "/newRentable", method = RequestMethod.POST)
	public String newRentable(
			@Valid @ModelAttribute RentableForm newRentableForm,
			BindingResult bindingResult, Principal principal,
			@RequestParam("file") MultipartFile file, Model model)
			throws IOException {

		if (bindingResult.hasErrors()) {
			String errorMessage = "";
			for (FieldError fieldError : bindingResult.getFieldErrors()) {
				errorMessage += fieldError.getField() + " is invalid<br>";
			}
			model.addAttribute("errorMessage", errorMessage);
			return "forward:/list";
		}

		String name = principal.getName();
		User currentUser = userDao.getUser(name);

		if (!file.isEmpty()) {

			byte[] image = file.getBytes();
			InputStream in = new ByteArrayInputStream(image);
			BufferedImage originalImage = ImageIO.read(in);
			
			

			Rentable rentable = new Rentable();
			rentable.setTitle(newRentableForm.getTitle());
			Category category = categoryDao.getCategoryId(newRentableForm
					.getCategoryId());
			rentable.setUser(currentUser);
			rentable.setImage(image);
			rentable.setCategory(category);
			rentable.setDescription(newRentableForm.getDescription());
			rentable.setPrice(newRentableForm.getPrice());

			Address location = new Address(newRentableForm.getStreet(),
					newRentableForm.getCity(), newRentableForm.getCountry(),
					newRentableForm.getZip());
			rentable.setLocation(location);

			rentableDao.persist(rentable);

			return "forward:/list";
		}

		return "forward:/list";
	}

	@RequestMapping("/categoryEntertainment")
	public String showCategoryEntertainment(Model model) {

		List<Rentable> rentables = rentableDao.searchRentables("Entertainment");
		model.addAttribute("rentables", rentables);

		return "categoryEntertainment";

	}

	@RequestMapping("/categoryGarden")
	public String showCategoryGarden(Model model) {

		List<Rentable> rentables = rentableDao.searchRentables("Garden");
		model.addAttribute("rentables", rentables);

		return "categoryGarden";

	}

	@RequestMapping("/categoryHobby")
	public String showCategoryHobby(Model model) {

		List<Rentable> rentables = rentableDao.searchRentables("Hobby");
		model.addAttribute("rentables", rentables);

		return "categoryHobby";

	}

	@RequestMapping("/categoryKitchen")
	public String showCategoryKitchen(Model model) {

		List<Rentable> rentables = rentableDao.searchRentables("Kitchen");
		model.addAttribute("rentables", rentables);

		return "categoryKitchen";

	}

	@RequestMapping("/categoryMusic")
	public String showCategoryMusic(Model model) {

		List<Rentable> rentables = rentableDao.searchRentables("Music");
		model.addAttribute("rentables", rentables);

		return "categoryMusic";

	}

	@RequestMapping("/categorySport")
	public String showCategorySport(Model model) {

		List<Rentable> rentables = rentableDao.searchRentables("Sport");
		model.addAttribute("rentables", rentables);

		return "categorySport";

	}

	@RequestMapping("/categoryTools")
	public String showCategoryTools(Model model) {

		List<Rentable> rentables = rentableDao.searchRentables("Tools");
		model.addAttribute("rentables", rentables);

		return "categoryTools";

	}

	@RequestMapping("/dashboard")
	public String showDashboard(Principal principal, Model model) {

		String name = principal.getName();

		List<Rentable> rentables = rentableDao.userRentables(name);
		model.addAttribute("rentables", rentables);

		return "dashboard";

	}

	@RequestMapping("/delete")
	public String deleteData(Model model, @RequestParam int id) {

		rentableDao.delete(id);
		return "forward:/list";

	}

	// @ExceptionHandler(Exception.class)
	public String handleAllException(Exception ex) {

		return "showError";

	}

}
