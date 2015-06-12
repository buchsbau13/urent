package at.fh.swenga.urent.controller;

import java.security.Principal;
import java.util.ArrayList;
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

		try {
			String name = principal.getName();
			User currentUser = userDao.getUser(name);

			Rentable currentRentable = rentableDao.getRentable(id);

			User rentableUser = currentRentable.getUser();

			if (rentableUser.equals(currentUser)) {

				return "index";
			} else {
				List<User> wishlistUsers = currentRentable.getWishlistUsers();
				wishlistUsers.add(currentUser);
				currentRentable.setWishlistUsers(wishlistUsers);
				rentableDao.merge(currentRentable);
				return "forward:/dashboard";
			}

		} catch (Exception e) {
			return "index";
		}

	}
}
