package at.fh.swenga.urent.dao;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.Rentable;

@Repository
@Transactional
public interface RentableRepository extends JpaRepository<Rentable, Integer> {
	
	public List<Rentable> findByTitle(String title);
}
