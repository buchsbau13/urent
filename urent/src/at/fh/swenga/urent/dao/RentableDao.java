package at.fh.swenga.urent.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.Rentable;

@Repository
@Transactional
public class RentableDao {

	@PersistenceContext
	protected EntityManager entityManager;

	public List<Rentable> getRentables() {
		Query query = entityManager.createQuery("select r from Rentable r");
		List<Rentable> resultList = query.getResultList();
		return resultList;
	}

	public Rentable getRentable(int i) throws DataAccessException {
		return entityManager.find(Rentable.class, i);
	}

	public void persist(Rentable rentable) {
		entityManager.persist(rentable);
	}

	public Rentable merge(Rentable rentable) {
		return entityManager.merge(rentable);
	}


	public void delete(Rentable rentable) {
		entityManager.remove(entityManager.contains(rentable) ? rentable : entityManager.merge(rentable));
	}

	public int delteAllRentables() {
		int count = entityManager.createQuery("DELETE FROM Rentable")
				.executeUpdate();
		return count;
	}

	public void delete(int id) {
		Rentable rentable = getRentable(id);
		if (rentable != null)
			delete(rentable);
	}
	
	public List<Rentable> searchRentables(String category) {
		TypedQuery<Rentable> typedQuery = entityManager
				.createQuery(
						"select r from Rentable r where r.category.name like :search",
						Rentable.class);
		typedQuery.setParameter("search", category);
		List<Rentable> typedResultList = typedQuery.getResultList();
		return typedResultList;
	}
	
	public List<Rentable> userRentables(String user) {
		TypedQuery<Rentable> typedQuery = entityManager
				.createQuery(
						"select r from Rentable r where r.user.username like :search",
						Rentable.class);
		typedQuery.setParameter("search", user);
		List<Rentable> typedResultList = typedQuery.getResultList();
		return typedResultList;
	}

}
