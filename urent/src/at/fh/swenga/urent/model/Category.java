package at.fh.swenga.urent.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Version;

@Entity
public class Category implements Serializable {

	private static final long serialVersionUID = -6101910788088567320L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id; 
	
	private String name; 
	
	@OneToMany(mappedBy = "category", fetch = FetchType.EAGER)
	private Set<Rentable> rentables; 
	
	@Version
	private long version;

	public Category() {
	}

	public Category(String name) {
		super();
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<Rentable> getRentables() {
		return rentables;
	}

	public void setRentables(Set<Rentable> rentables) {
		this.rentables = rentables;
	}
	
	
	
	
	
	
}
