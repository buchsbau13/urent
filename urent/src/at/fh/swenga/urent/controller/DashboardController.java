package at.fh.swenga.urent.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

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
import at.fh.swenga.urent.dao.RentableDao;
import at.fh.swenga.urent.dao.UserDao;
import at.fh.swenga.urent.dao.UserRoleDao;
import at.fh.swenga.urent.model.Address;
import at.fh.swenga.urent.model.Category;
import at.fh.swenga.urent.model.Rentable;
import at.fh.swenga.urent.model.RentableForm;
import at.fh.swenga.urent.model.User;

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
				Rentable oldRentable = rentableDao.getRentable(rentable.getId()); 
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
