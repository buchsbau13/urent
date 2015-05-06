package at.fh.swenga.urent.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.Category;
import at.fh.swenga.urent.model.Rentable;

@Repository
@Transactional
public class CategoryDao {

	@PersistenceContext
	protected EntityManager entityManager;

	public List<Category> getCategories() {

		TypedQuery<Category> typedQuery = entityManager.createQuery(
				"select c from Category c", Category.class);
		List<Category> typedResultList = typedQuery.getResultList();
		return typedResultList;
	}

	public Category getCategory(String name) {
		try {

			TypedQuery<Category> typedQuery = entityManager.createQuery(
					"select c from Category c where c.name = :name",
					Category.class);
			typedQuery.setParameter("name", name);
			Category category = typedQuery.getSingleResult();
			return category;
		} catch (NoResultException e) {
			return null;
		}
	}

}
