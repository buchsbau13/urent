package at.fh.swenga.urent.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.Rentable;
import at.fh.swenga.urent.model.User;

@Repository
@Transactional
public class UserDao {

	@PersistenceContext
	protected EntityManager entityManager;

	public User getUser(String name) throws DataAccessException {
		return entityManager.find(User.class, name);
	}
	
	public List<User> getUsers() {
		Query query = entityManager.createQuery("select u from User u");
		List<User> resultList = query.getResultList();
		return resultList;
	}

	public void persist(User user) {
		entityManager.persist(user);

	}

	public void merge(User user) {
		entityManager.merge(user);

	}

	public void delete(User user) {
		entityManager.remove(entityManager.contains(user) ? user : entityManager.merge(user));
		
	}

}
