package at.fh.swenga.urent.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import at.fh.swenga.urent.dao.CategoryDao;
import at.fh.swenga.urent.dao.RentableDao;
import at.fh.swenga.urent.model.Category;
import at.fh.swenga.urent.model.Rentable;

@Controller
public class IndexController {

	@Autowired
	RentableDao rentableDao;

	@Autowired
	CategoryDao categoryDao;

	@RequestMapping(value = { "/", "list" })
	public String index(Model model) {

		List<Rentable> rentables = rentableDao.getRentables();
		model.addAttribute("rentables", rentables);

		return "index";

	}

	@RequestMapping(value = "/newRentable", method = RequestMethod.GET)
	public String showNewRentableForm(Model model) {

		List<Category> categories = new ArrayList<Category>();

		categories.add(new Category("Hobby"));
		categories.add(new Category("Sport"));
		categories.add(new Category("Music"));
		model.addAttribute("categories", categories);

		return "newRentable";
	}

	@RequestMapping(value = "/newRentable", method = RequestMethod.POST)
	public String newRentable(@Valid @ModelAttribute Rentable newRentable,
			BindingResult bindingResult, Model model) {

		if (bindingResult.hasErrors()) {
			String errorMessage = "";
			for (FieldError fieldError : bindingResult.getFieldErrors()) {
				errorMessage += fieldError.getField() + " is invalid<br>";
			}
			model.addAttribute("errorMessage", errorMessage);
			return "forward:/list";
		}

		Rentable rentable = rentableDao.getRentable(newRentable.getId());

		if (rentable != null) {
			model.addAttribute("errorMessage", "Rentable already exists!<br>");
		} else {
			rentableDao.persist(newRentable);
			model.addAttribute("message", "New Rentable " + newRentable.getId()
					+ " added.");
		}

		return "forward:/list";
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
