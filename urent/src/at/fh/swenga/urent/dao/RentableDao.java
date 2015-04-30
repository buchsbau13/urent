package at.fh.swenga.urent.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
		TypedQuery<Rentable> typedQuery = entityManager.createQuery(
				"select r from Rentable r", Rentable.class);
		List<Rentable> typedResultList = typedQuery.getResultList();
		return typedResultList;
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
		entityManager.remove(rentable);
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

}
