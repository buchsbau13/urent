package at.fh.swenga.urent.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.Rating;
import at.fh.swenga.urent.model.Rentable;

@Repository
@Transactional
public class RatingDao {

	@PersistenceContext
	protected EntityManager entityManager;

	public List<Rating> getRatings() {

		TypedQuery<Rating> typedQuery = entityManager.createQuery(
				"select r from Rating r", Rating.class);
		List<Rating> typedResultList = typedQuery.getResultList();
		return typedResultList;
	}

	public List<Rating> getRentableRatings(int id) {
		TypedQuery<Rating> typedQuery = entityManager.createQuery(
				"select r from Rating r where r.rentable.id like :search",
				Rating.class);
		typedQuery.setParameter("search", id);
		List<Rating> typedResultList = typedQuery.getResultList();
		return typedResultList;
	}

	public Rating getRating(int i) throws DataAccessException {
		return entityManager.find(Rating.class, i);
	}

	public void persist(Rating rating) {
		entityManager.persist(rating);

	}
	
	public void delete(Rating rating) {
		entityManager.remove(entityManager.contains(rating) ? rating : entityManager.merge(rating));
	}

	public void delete(int id) {
		Rating rating = getRating(id);
		if (rating != null)
			delete(rating);
		
	}
}
