package at.fh.swenga.urent.dao;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.UserRole;

@Repository
@Transactional
public class UserRoleDao {

	@PersistenceContext
	protected EntityManager entityManager;

	public UserRole getUserRole(String role) {
		try {

			TypedQuery<UserRole> typedQuery = entityManager.createQuery(
					"select r from UserRole r where r.role = :role",
					UserRole.class);
			typedQuery.setParameter("role", role);
			UserRole userRole = typedQuery.getSingleResult();
			return userRole;
		} catch (NoResultException e) {
			return null;
		}
	}

	public void persist(UserRole userRole) {
		entityManager.persist(userRole);

	}

}
