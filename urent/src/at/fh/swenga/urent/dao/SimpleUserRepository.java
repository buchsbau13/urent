package at.fh.swenga.urent.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.User;

@Repository
@Transactional
public interface SimpleUserRepository extends JpaRepository<User, Integer> {
	
	List<User> findByUsername(String userName);
}
