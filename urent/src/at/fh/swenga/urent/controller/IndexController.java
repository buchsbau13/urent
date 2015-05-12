package at.fh.swenga.urent.controller;

import java.util.List;

import javax.transaction.Transactional;
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
import at.fh.swenga.urent.model.RentableForm;

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

	@RequestMapping("/init")
	@Transactional
	public String init(Model model) {

		Category entertainment = categoryDao.getCategory("Entertainment");
		if (entertainment == null)
			entertainment = new Category("Entertainment");
		categoryDao.persist(entertainment);

		Category sport = categoryDao.getCategory("Sport");
		if (sport == null)
			sport = new Category("Sport");
		categoryDao.persist(sport);

		Category music = categoryDao.getCategory("Music");
		if (music == null)
			music = new Category("Music");
		categoryDao.persist(music);
		
		Category kitchen = categoryDao.getCategory("Kitchen");
		if (kitchen == null)
			kitchen = new Category("Kitchen");
		categoryDao.persist(kitchen);

		Category garden = categoryDao.getCategory("Garden");
		if (garden == null)
			garden = new Category("Garden");
		categoryDao.persist(garden);
		
		Category tools = categoryDao.getCategory("Tools");
		if (tools == null)
			tools = new Category("Tools");
		categoryDao.persist(tools);
		
		Category hobby = categoryDao.getCategory("Hobby");
		if (hobby == null)
			hobby = new Category("Hobby");
		categoryDao.persist(hobby);
		
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
			BindingResult bindingResult, Model model) {

		if (bindingResult.hasErrors()) {
			String errorMessage = "";
			for (FieldError fieldError : bindingResult.getFieldErrors()) {
				errorMessage += fieldError.getField() + " is invalid<br>";
			}
			model.addAttribute("errorMessage", errorMessage);
			return "forward:/list";
		}

		Rentable rentable = new Rentable();
		rentable.setTitle(newRentableForm.getTitle());
		Category category = categoryDao.getCategoryId(newRentableForm
				.getCategoryId());
		rentable.setCategory(category);
		rentable.setDescription(newRentableForm.getDescription());
		rentable.setPrice(newRentableForm.getPrice());
		rentableDao.persist(rentable);

		return "forward:/list";
	}

	@RequestMapping("/categorySport")
	public String showCategorySport(Model model) {

		List<Rentable> rentables = rentableDao.searchRentables("Sport");
		model.addAttribute("rentables", rentables);

		return "categorySport";

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
