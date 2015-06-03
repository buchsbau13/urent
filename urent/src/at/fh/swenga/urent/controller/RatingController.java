package at.fh.swenga.urent.controller;

import java.security.Principal;
import java.util.Date;
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

import at.fh.swenga.urent.dao.RatingDao;
import at.fh.swenga.urent.dao.RentableDao;
import at.fh.swenga.urent.dao.UserDao;
import at.fh.swenga.urent.model.Rating;
import at.fh.swenga.urent.model.Rentable;
import at.fh.swenga.urent.model.User;

@Controller
public class RatingController {

	@Autowired
	RentableDao rentableDao;

	@Autowired
	RatingDao ratingDao;

	@Autowired
	UserDao userDao;

	@RequestMapping(value = "/rateRentable", method = RequestMethod.GET)
	public String showRateRentable(Model model, @RequestParam int id) {

		model.addAttribute("rentable", rentableDao.getRentable(id));

		return "rateRentable";
	}

	@RequestMapping(value = "/rateRentable", method = RequestMethod.POST)
	public String rateRentable(@Valid @ModelAttribute Rating rating,
			Rentable rentable, BindingResult bindingResult,
			Principal principal, Model model) {

		Rentable currentRentable = rentableDao.getRentable(rentable.getId());
		String ownerRentable = currentRentable.getUser().getUsername();

		String name = principal.getName();
		User currentUser = userDao.getUser(name);

		if (name.equals(ownerRentable)) {
			model.addAttribute("errorMessage",
					"You are not allowed to rate your own products");
			return "rateRentable";
		} else {
			Rating newRating = new Rating();
			newRating.setDate(new Date());
			newRating.setTitle(rating.getTitle());
			newRating.setText(rating.getText());
			newRating.setRentable(rentable);
			newRating.setAuthor(currentUser);
			ratingDao.persist(newRating);
			currentRentable.addRating(newRating);
			rentableDao.merge(currentRentable);

			model.addAttribute("message", "Rentable " + rentable.getTitle()
					+ " successfully rated!");
			return "forward:/list";
		}

	}

	@RequestMapping(value = "/ratings", method = RequestMethod.GET)
	public String showRatings(Model model, @RequestParam int id) {

		List<Rating> ratings = ratingDao.getRentableRatings(id);
		model.addAttribute("ratings", ratings);

		return "ratings";
	}

}
