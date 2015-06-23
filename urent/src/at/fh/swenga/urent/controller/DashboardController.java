package at.fh.swenga.urent.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import at.fh.swenga.urent.dao.CategoryDao;
import at.fh.swenga.urent.dao.RatingDao;
import at.fh.swenga.urent.dao.RentableDao;
import at.fh.swenga.urent.dao.UserDao;
import at.fh.swenga.urent.dao.UserRoleDao;
import at.fh.swenga.urent.model.Address;
import at.fh.swenga.urent.model.Category;
import at.fh.swenga.urent.model.Rating;
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
	ServletContext servletContext;

	@Autowired
	RatingDao ratingDao;

	@Autowired
	UserRoleDao userRoleDao;

	@RequestMapping(value = "/editRentable", method = RequestMethod.GET)
	public String showEditRentableForm(Model model, Principal principal,
			@RequestParam int id) {

		String username = principal.getName();
		String rentableUsername = rentableDao.getRentable(id).getUser()
				.getUsername();

		if (username.equals(rentableUsername)) {
			List<Category> categories = categoryDao.getCategories();
			model.addAttribute("rentable", rentableDao.getRentable(id));
			model.addAttribute("command", new RentableForm());
			model.addAttribute("categories", categories);
			return "editRentable";
		} else {
			model.addAttribute("errorMessage",
					"You are not allowed to edit Rentables from other Users!");
			return "dashboard";
		}

	}

	@RequestMapping(value = "/editRentable", method = RequestMethod.POST)
	public String editRentable(@Valid @ModelAttribute RentableForm rentable,
			BindingResult bindingResult, HttpServletRequest request,
			@RequestParam("file") MultipartFile file, Model model)
			throws IOException {

		Rentable changedRentable = rentableDao.getRentable(rentable.getId());

		if (changedRentable == null) {
			model.addAttribute("errorMessage", "Rentable does not exist!<br>");
		} else {
			changedRentable.setTitle(rentable.getTitle());
			changedRentable.setDescription(rentable.getDescription());
			changedRentable.setPrice(rentable.getPrice());

			if (file.isEmpty()) {
				Rentable oldRentable = rentableDao
						.getRentable(rentable.getId());
				changedRentable.setImage(oldRentable.getImage());

			} else {
				BufferedImage croppedImage = cropImageSquare(file.getBytes());
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				ImageIO.write(croppedImage, "jpg", baos);
				baos.flush();
				byte[] imageInByte = baos.toByteArray();
				baos.close();
				changedRentable.setImage(imageInByte);
			}

			Address location = new Address(rentable.getStreet(),
					rentable.getCity(), rentable.getCountry(),
					rentable.getZip());
			changedRentable.setLocation(location);
			rentableDao.merge(changedRentable);

			model.addAttribute("message",
					"Changed Rentable " + changedRentable.getTitle());
		}

		return "forward:/dashboard";
	}

	@RequestMapping(value = "/editUser", method = RequestMethod.GET)
	public String showEditUser(Model model, Principal principal,
			@RequestParam String username) {

		String currentUsername = principal.getName();
		String editUsername = userDao.getUser(username).getUsername();

		if (currentUsername.equals(editUsername)) {
			model.addAttribute("user", userDao.getUser(username));
			return "editUser";
		} else {
			model.addAttribute("errorMessage",
					"You are not allowed to edit other Users!");
			return "dashboard";
		}

	}

	@RequestMapping(value = "/editUser", method = RequestMethod.POST)
	public String editUser(@Valid @ModelAttribute User user,
			BindingResult bindingResult,
			@RequestParam("file") MultipartFile file, Model model)
			throws IOException {

		User changedUser = userDao.getUser(user.getUsername());

		if (changedUser == null) {
			model.addAttribute("errorMessage", "User does not exist!<br>");
		} else {
			changedUser.setEmail(user.getEmail());
			changedUser.setFirstname(user.getFirstname());
			changedUser.setLastname(user.getLastname());
			changedUser.setTelephone(user.getTelephone());
			changedUser.setDescription(user.getDescription());

			if (file.isEmpty()) {
				User oldUser = userDao.getUser(user.getUsername());
				changedUser.setImage(oldUser.getImage());

			} else {
				BufferedImage croppedImage = cropImageSquare(file.getBytes());
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				ImageIO.write(croppedImage, "jpg", baos);
				baos.flush();
				byte[] imageInByte = baos.toByteArray();
				baos.close();
				changedUser.setImage(imageInByte);
			}

			userDao.merge(changedUser);

			model.addAttribute("message",
					"Changed User " + changedUser.getUsername());
		}

		return "forward:/dashboard";
	}

	@RequestMapping(value = "/getUserImage/{username}")
	public void showUserImage(HttpServletResponse response,
			@PathVariable("username") String username) throws IOException {

		User currentUser = userDao.getUser(username);
		response.setContentType("image/jpeg");
		OutputStream out = response.getOutputStream();
		out.write(currentUser.getImage());
		out.flush();

	}

	@RequestMapping("/showUser")
	public String showDashboard(Principal principal, @RequestParam int id,
			Model model) {

		String username = rentableDao.getRentable(id).getUser().getUsername();
		List<Rentable> rentables = rentableDao.userRentables(username);
		model.addAttribute("rentables", rentables);
		model.addAttribute("user", rentableDao.getRentable(id).getUser());

		return "showUser";

	}

	@RequestMapping("/deleteUsers")
	public String showDeleteUsers(Model model) {

		List<User> users = userDao.getUsers();
		model.addAttribute("users", users);

		return "deleteUsers";

	}

	@RequestMapping("/deleteUser")
	public String deleteUser(@RequestParam String username, Model model) {

		try {

			Set<Rentable> userRentables = userDao.getUser(username)
					.getRentables();
			if (!userRentables.isEmpty()) {
				for (Rentable rentable : userRentables) {
					Set<Rating> rentableRatings = rentable.getRatings();
					if (!rentableRatings.isEmpty()) {
						for (Rating rating : rentableRatings) {
							ratingDao.delete(rating.getId());
						}
					}

					rentableDao.delete(rentable.getId());
				}
			}

			Set<UserRole> userRoles = userDao.getUser(username).getUserRole();
			if (!userRoles.isEmpty()) {
				for (UserRole userRole : userRoles) {
					userRoleDao.delete(userRole);
				}
			}
			userDao.delete(userDao.getUser(username));

			model.addAttribute("message", "User deleted!");
			return "forward:/deleteUsers";
		}

		catch (Exception e) {
			model.addAttribute("errorMessage",
					"It is not possible to delete this User!");
			return "forward:/deleteUsers";
		}

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
