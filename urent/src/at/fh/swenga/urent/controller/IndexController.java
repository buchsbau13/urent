package at.fh.swenga.urent.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		
		List<Category> categories = categoryDao.getCategories();
		model.addAttribute("categories", categories);

		return "index";

	}

	// @ExceptionHandler(Exception.class)
	public String handleAllException(Exception ex) {

		return "showError";

	}

}
