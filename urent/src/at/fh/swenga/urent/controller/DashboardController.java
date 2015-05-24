package at.fh.swenga.urent.controller;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import at.fh.swenga.urent.dao.RentableDao;
import at.fh.swenga.urent.model.Address;
import at.fh.swenga.urent.model.Rentable;
import at.fh.swenga.urent.model.RentableForm;

@Controller
public class DashboardController {

	@Autowired
	RentableDao rentableDao;

	@RequestMapping(value = "/editRentable", method = RequestMethod.GET)
	public String showEditRentableForm(Model model, @RequestParam int id) {

		model.addAttribute("rentable", rentableDao.getRentable(id));
		model.addAttribute("command", new RentableForm());

		return "editRentable";
	}

	@RequestMapping(value = "/editRentable", method = RequestMethod.POST)
	public String newRentable(@Valid @ModelAttribute RentableForm rentable,
			BindingResult bindingResult, Model model) {

		Rentable changedRentable = rentableDao.getRentable(rentable.getId());

		if (changedRentable == null) {
			model.addAttribute("errorMessage", "Rentable does not exist!<br>");
		} else {
			changedRentable.setTitle(rentable.getTitle());
			changedRentable.setDescription(rentable.getDescription());
			changedRentable.setPrice(rentable.getPrice());

			Address location = new Address(rentable.getStreet(),
					rentable.getCity(), rentable.getCountry(),
					rentable.getZip());
			changedRentable.setLocation(location);
			rentableDao.merge(changedRentable);
			
			model.addAttribute("message", "Changed Rentable " + changedRentable.getId());
		}

		return "forward:/list";
	}

}
