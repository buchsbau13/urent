package at.fh.swenga.urent.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import at.fh.swenga.urent.dao.RentableDao;
import at.fh.swenga.urent.dao.UserDao;
import at.fh.swenga.urent.model.Rentable;
import at.fh.swenga.urent.model.User;

@Controller
public class RentableController {

	@Autowired
	RentableDao rentableDao;

	@Autowired
	UserDao userDao;

	@RequestMapping(value = "/addToWishlist")
	public String addToWishlist(Model model, @RequestParam int id,
			Principal principal) {

		Rentable currentRentable = rentableDao.getRentable(id);

		try {
			String name = principal.getName();
			User currentUser = userDao.getUser(name);
			String currentUsername = currentUser.getUsername(); 
			String rentableUsername = currentRentable.getUser().getUsername();
			

			if (rentableUsername.equals(currentUsername)) {
				model.addAttribute("errorMessage", "It is not possible to add your own products to your wishlist!");
				return "dashboard";
			} else {
				List<User> wishlistUsers = currentRentable.getWishlistUsers();
				wishlistUsers.add(currentUser);
				currentRentable.setWishlistUsers(wishlistUsers);
				rentableDao.merge(currentRentable);
				model.addAttribute("message", "Added Rentable "
						+ currentRentable.getTitle() + " to your wishlist!");
				return "forward:/dashboard";
			}

		} catch (Exception e) {
			model.addAttribute(
					"errorMessage",
					"It is not possilbe to add Rentable"
							+ currentRentable.getTitle()+ " to your wishlist");
			return "dashboard";
		}

	}
}
