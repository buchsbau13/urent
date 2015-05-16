package at.fh.swenga.urent.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.User;

@Repository
@Transactional
public class UserDao {

	@PersistenceContext
	protected EntityManager entityManager;

	public User getUser(String name) throws DataAccessException {
		return entityManager.find(User.class, name);
	}

	public void persist(User user) {
		entityManager.persist(user);

	}

}
