package at.fh.swenga.urent.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
import at.fh.swenga.urent.dao.RentableRepository;
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
	RentableRepository rentableRepository;
	
	@Autowired
	CategoryDao categoryDao;

	@Autowired
	UserDao userDao;

	@Autowired
	UserRoleDao userRoleDao;
	
	@Autowired
	ServletContext servletContext; 

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
					"Admin", "Admin", "admin@urent.com", 123, true);
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
					"User", "User", "user@urent.com", 123, true);
		userDao.persist(user);

		UserRole roleUser2 = new UserRole(user, "ROLE_USER");
		userRoleDao.persist(roleUser2);

		User julia = userDao.getUser("julia");
		if (julia == null)
			julia = new User(
					"julia",
					"$2a$10$2BZh7qw/FSh23ZCbojA.OOoo7vzg7KaqHUp34l8/i9.ktxzcr3vJm",
					"Julia", "Buchsbaum", "julia@urent.com", 123, true);
		userDao.persist(julia);

		UserRole roleAdmin2 = new UserRole(julia, "ROLE_ADMIN");
		userRoleDao.persist(roleAdmin2);

		UserRole roleUser3 = new UserRole(julia, "ROLE_USER");
		userRoleDao.persist(roleUser3);

		Address graz = new Address("Mandellstraße 3", "Graz", "Austria", "8010");

		Rentable soccerball = rentableDao.getRentable(0);
		if (soccerball == null)
			soccerball = new Rentable(julia, sport, "Soccerball",
					"A very good Ball", 29.99, null, graz, null);
		rentableDao.persist(soccerball);

		Rentable basketball = rentableDao.getRentable(1);
		if (basketball == null)
			basketball = new Rentable(julia, sport, "basketball",
					"A very good Ball", 19.99, null, graz, null);
		rentableDao.persist(basketball);

		Rentable tennisracket = rentableDao.getRentable(2);
		if (tennisracket == null)
			tennisracket = new Rentable(julia, sport, "tennisracket",
					"A very good Ball", 39.99, null, graz, null);
		rentableDao.persist(tennisracket);

		Rentable soccerjersey = rentableDao.getRentable(3);
		if (soccerjersey == null)
			soccerjersey = new Rentable(julia, sport, "soccerjersey",
					"A very good Ball", 29.99, null, graz, null);
		rentableDao.persist(soccerjersey);

		Rentable basketballjersey = rentableDao.getRentable(4);
		if (basketballjersey == null)
			basketballjersey = new Rentable(julia, sport, "basketballjersey",
					"A very good Ball", 25.99, null, graz, null);
		rentableDao.persist(basketballjersey);

		Rentable tennisball = rentableDao.getRentable(5);
		if (tennisball == null)
			tennisball = new Rentable(julia, sport, "tennisball",
					"A very good Ball", 25.99, null, graz, null);
		rentableDao.persist(tennisball);

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
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request, Model model) throws IOException {

		if (bindingResult.hasErrors()) {
			String errorMessage = "";
			for (FieldError fieldError : bindingResult.getFieldErrors()) {
				errorMessage += fieldError.getField() + " is invalid<br>";
			}
			model.addAttribute("errorMessage", errorMessage);
			return "newRentable";
		}

		String name = principal.getName();
		User currentUser = userDao.getUser(name);

		try {
			Rentable rentable = new Rentable();
			rentable.setTitle(newRentableForm.getTitle());
			Category category = categoryDao.getCategoryId(newRentableForm
					.getCategoryId());
			rentable.setUser(currentUser);
			rentable.setCategory(category);
			rentable.setDescription(newRentableForm.getDescription());
			rentable.setPrice(newRentableForm.getPrice());

			Address location = new Address(newRentableForm.getStreet(),
					newRentableForm.getCity(), newRentableForm.getCountry(),
					newRentableForm.getZip());
			rentable.setLocation(location);

			if (file.isEmpty()) {
				File rootDir = new File(
						servletContext.getRealPath("/WEB-INF/images/defaultRentable.jpg"));
				BufferedImage defaultImage = ImageIO.read(rootDir);
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				ImageIO.write(defaultImage, "jpg", baos);
				baos.flush();
				byte[] defaultImageByte = baos.toByteArray();
				baos.close();
				rentable.setImage(defaultImageByte);

				//byte[] image = file.getBytes();
				//rentable.setImage(image);

			} else {
				BufferedImage croppedImage = cropImageSquare(file.getBytes());
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				ImageIO.write(croppedImage, "jpg", baos);
				baos.flush();
				byte[] imageInByte = baos.toByteArray();
				baos.close();
				rentable.setImage(imageInByte);
			}

			List<User> wishlistUsers = new ArrayList<User>();
			rentable.setWishlistUsers(wishlistUsers);

			rentableDao.persist(rentable);

			model.addAttribute("message", "Rentable " + rentable.getTitle()
					+ " successfully added!");

		} catch (Exception e) {
			model.addAttribute("errorMessage", "Invalid Data!");
			return "newRentable";
		}

		return "forward:dashboard";
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
		List<Rentable> wishlistRentables = userDao.getUser(name)
				.getWishlistRentables();
		model.addAttribute("rentables", rentables);
		model.addAttribute("wishlistRentables", wishlistRentables);
		model.addAttribute("user", userDao.getUser(name));

		return "dashboard";

	}
	
	@RequestMapping("/search")
	public String search(Model model, @RequestParam String searchString) 
	{
		List<Rentable> rentables = new ArrayList<Rentable>();
		rentables=rentableRepository.findAll();
		System.out.println(rentables);
		System.out.println(rentables.size());
		rentables=rentableRepository.findByTitle(searchString);
		System.out.println(rentables);
		System.out.println(rentables.size());
		rentables.add(new Rentable());
		System.out.println(rentables.size());
		rentables=rentableDao.getRentables();
		System.out.println(rentables.size());
		rentables=rentableRepository.findAll();
		System.out.println("Hello Worlds");
		model.addAttribute("searchString", searchString);
		model.addAttribute("rentables", rentables);
		System.out.println(searchString);
		
		
		
		return "search";

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

	private BufferedImage cropImageSquare(byte[] image) throws IOException {
		InputStream in = new ByteArrayInputStream(image);
		BufferedImage originalImage = ImageIO.read(in);

		int height = originalImage.getHeight();
		int width = originalImage.getWidth();

		if (height == width) {
			return originalImage;
		}

		int squareSize = (height > width ? width : height);

		int xc = width / 2;
		int yc = height / 2;

		BufferedImage croppedImage = originalImage.getSubimage(xc
				- (squareSize / 2), yc - (squareSize / 2), squareSize,
				squareSize);

		return croppedImage;
	}

}
