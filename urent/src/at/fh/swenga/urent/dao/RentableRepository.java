package at.fh.swenga.urent.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import at.fh.swenga.urent.model.Rentable;

@Repository
@Transactional
public interface RentableRepository extends JpaRepository<Rentable, Integer> {

	@Query("select r from Rentable r where r.title like :search% or r.location.city like :search2%")
	public List<Rentable> findBySomething(@Param("search") String searchString, @Param("search2") String searchString2);

}
