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

	@RequestMapping(value = "/getImage/{id}")
	public void showImage(HttpServletResponse response,
			@PathVariable("id") int rentableId) throws IOException {

		Rentable rentable = rentableDao.getRentable(rentableId);
		response.setContentType("image/jpeg");
		OutputStream out = response.getOutputStream();
		out.write(rentable.getImage());
		out.flush();

	}
	
	@RequestMapping(value = { "/", "list" })
	public String index(Model model) {
		return "index";
	}

	@RequestMapping("/init")
	@Transactional
	public String init(Model model) throws IOException {

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

		File rootDirAdmin = new File(
				servletContext.getRealPath("/WEB-INF/images/admin.jpg"));
		BufferedImage adminPic = ImageIO.read(rootDirAdmin);
		ByteArrayOutputStream baos8 = new ByteArrayOutputStream();
		ImageIO.write(adminPic, "jpg", baos8);
		baos8.flush();
		byte[] adminByte = baos8.toByteArray();
		baos8.close();
		
		User admin = userDao.getUser("admin");
		if (admin == null)
			admin = new User(
					"admin",
					"$2a$10$2BZh7qw/FSh23ZCbojA.OOoo7vzg7KaqHUp34l8/i9.ktxzcr3vJm",
					"Admin", "Admin", "admin@urent.com", "123", true);
		admin.setImage(adminByte);
		userDao.persist(admin);

		UserRole roleAdmin1 = new UserRole(admin, "ROLE_ADMIN");
		userRoleDao.persist(roleAdmin1);
		
		File rootDirEmma = new File(
				servletContext.getRealPath("/WEB-INF/images/emma.jpg"));
		BufferedImage emmaPic = ImageIO.read(rootDirEmma);
		ByteArrayOutputStream baos7 = new ByteArrayOutputStream();
		ImageIO.write(emmaPic, "jpg", baos7);
		baos7.flush();
		byte[] emmaByte = baos7.toByteArray();
		baos7.close();

		User user = userDao.getUser("user");
		if (user == null)
			user = new User(
					"user",
					"$2a$10$2BZh7qw/FSh23ZCbojA.OOoo7vzg7KaqHUp34l8/i9.ktxzcr3vJm",
					"User", "User", "user@urent.com", "123", true);
		user.setImage(emmaByte);
		userDao.persist(user);

		UserRole roleUser2 = new UserRole(user, "ROLE_USER");
		userRoleDao.persist(roleUser2);
		
		File rootDirJulia = new File(
				servletContext.getRealPath("/WEB-INF/images/julia.jpg"));
		BufferedImage juliaPic = ImageIO.read(rootDirJulia);
		ByteArrayOutputStream baos6 = new ByteArrayOutputStream();
		ImageIO.write(juliaPic, "jpg", baos6);
		baos6.flush();
		byte[] juliaByte = baos6.toByteArray();
		baos6.close();

		User julia = userDao.getUser("julia");
		if (julia == null)
			julia = new User(
					"julia",
					"$2a$10$2BZh7qw/FSh23ZCbojA.OOoo7vzg7KaqHUp34l8/i9.ktxzcr3vJm",
					"Julia", "Buchsbaum", "julia@urent.com", "123", true);
		julia.setImage(juliaByte);
		userDao.persist(julia);

		UserRole roleAdmin2 = new UserRole(julia, "ROLE_ADMIN");
		userRoleDao.persist(roleAdmin2);

		UserRole roleUser3 = new UserRole(julia, "ROLE_USER");
		userRoleDao.persist(roleUser3);

		Address graz1 = new Address("Mandellstraﬂe 3", "Graz", "Austria",
				"8010");
		Address graz2 = new Address("Odilienweg 6", "Graz", "Austria", "8010");
		Address graz3 = new Address("Neuholdaugasse 51", "Graz", "Austria",
				"8010");
		Address graz4 = new Address("Alte Poststraﬂe 147", "Graz", "Austria",
				"8010");
		Address graz5 = new Address("Johann-Strauﬂ-Gasse 6", "Graz", "Austria",
				"8010");

		File rootDirStandmixer = new File(
				servletContext.getRealPath("/WEB-INF/images/standmixer.jpg"));
		BufferedImage standmixer = ImageIO.read(rootDirStandmixer);
		ByteArrayOutputStream baos1 = new ByteArrayOutputStream();
		ImageIO.write(standmixer, "jpg", baos1);
		baos1.flush();
		byte[] standmixerByte = baos1.toByteArray();
		baos1.close();

		File rootDirMountainbike = new File(
				servletContext.getRealPath("/WEB-INF/images/mountainbike.jpg"));
		BufferedImage mountainbike = ImageIO.read(rootDirMountainbike);
		ByteArrayOutputStream baos2 = new ByteArrayOutputStream();
		ImageIO.write(mountainbike, "jpg", baos2);
		baos2.flush();
		byte[] mountainbikeByte = baos2.toByteArray();
		baos2.close();

		File rootDirGardentools = new File(
				servletContext.getRealPath("/WEB-INF/images/gardentools.jpg"));
		BufferedImage gardentools = ImageIO.read(rootDirGardentools);
		ByteArrayOutputStream baos3 = new ByteArrayOutputStream();
		ImageIO.write(gardentools, "jpg", baos3);
		baos3.flush();
		byte[] gardentoolsByte = baos3.toByteArray();
		baos3.close();

		File rootDirSewingMachine = new File(
				servletContext.getRealPath("/WEB-INF/images/sewingmachine.jpg"));
		BufferedImage sewingmachine = ImageIO.read(rootDirSewingMachine);
		ByteArrayOutputStream baos4 = new ByteArrayOutputStream();
		ImageIO.write(sewingmachine, "jpg", baos4);
		baos4.flush();
		byte[] sewingmachineByte = baos4.toByteArray();
		baos4.close();

		File rootDirRadio = new File(
				servletContext.getRealPath("/WEB-INF/images/radio.jpg"));
		BufferedImage radio = ImageIO.read(rootDirRadio);
		ByteArrayOutputStream baos5 = new ByteArrayOutputStream();
		ImageIO.write(radio, "jpg", baos5);
		baos5.flush();
		byte[] radioByte = baos5.toByteArray();
		baos5.close();

		Rentable mountainbikeRentable = rentableDao.getRentable(1);
		if (mountainbikeRentable == null)
			mountainbikeRentable = new Rentable(
					julia,
					sport,
					"Mountainbike",
					"Santa Cruz Mountainbike. Best Mountainbike ever. You will love it!",
					5.00, mountainbikeByte, graz1, null);
		rentableDao.persist(mountainbikeRentable);

		Rentable standmixerRentable = rentableDao.getRentable(2);
		if (standmixerRentable == null)
			standmixerRentable = new Rentable(julia, kitchen, "Standmixer",
					"Beautiful standmixer. Very easy to use.", 5.00,
					standmixerByte, graz3, null);
		rentableDao.persist(standmixerRentable);

		Rentable gardentoolsRentable = rentableDao.getRentable(3);
		if (gardentoolsRentable == null)
			gardentoolsRentable = new Rentable(julia, garden, "Gardentools",
					"Beautiful gardentools.", 5.00, gardentoolsByte, graz2,
					null);
		rentableDao.persist(gardentoolsRentable);

		Rentable sewingmachineRentable = rentableDao.getRentable(4);
		if (sewingmachineRentable == null)
			sewingmachineRentable = new Rentable(julia, hobby,
					"Sewing Machine", "Simple sewing machine for beginners",
					6.00, sewingmachineByte, graz4, null);
		rentableDao.persist(sewingmachineRentable);

		Rentable radioRentable = rentableDao.getRentable(5);
		if (radioRentable == null)
			radioRentable = new Rentable(
					julia,
					entertainment,
					"Wooden Radio",
					"Stylisch Radio. Perfect for a camping trip. You can also connect a phone to it!",
					3.00, radioByte, graz5, null);
		rentableDao.persist(radioRentable);

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
						servletContext
								.getRealPath("/WEB-INF/images/defaultRentable.jpg"));
				BufferedImage defaultImage = ImageIO.read(rootDir);
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				ImageIO.write(defaultImage, "jpg", baos);
				baos.flush();
				byte[] defaultImageByte = baos.toByteArray();
				baos.close();
				rentable.setImage(defaultImageByte);

				// byte[] image = file.getBytes();
				// rentable.setImage(image);

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
	public String search(Model model, @RequestParam String searchString) {
		List<Rentable> rentables = null;
		rentables = rentableRepository.findBySomething(searchString,
				searchString);
		model.addAttribute("rentables", rentables);

		return "search";

	}

	@RequestMapping("/delete")
	public String deleteData(Model model, Principal principal,
			@RequestParam int id) {

		String username = principal.getName();
		String rentableUsername = rentableDao.getRentable(id).getUser()
				.getUsername();

		if (username.equals(rentableUsername)) {
			rentableDao.delete(id);
			model.addAttribute("message", "Rentable deleted!");
			return "forward:/dashboard";
		} else {
			model.addAttribute("errorMessage",
					"Your are not allowed to delete Rentables from other People!");
			return "forward:/dashboard";
		}
	}

	@RequestMapping("/deleteAdmin")
	public String deleteDataAdmin(Model model, Principal principal,
			@RequestParam int id) {

		try {
			rentableDao.delete(id);
			model.addAttribute("message", "Rentable deleted!");
			return "forward:/dashboard";
		} catch (Exception e) {
			model.addAttribute("errorMessage",
					"It is not possible to delete this Rentable!");
			return "forward:/dashboard";
		}
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
