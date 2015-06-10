package at.fh.swenga.urent.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;

import org.hibernate.validator.constraints.Email;

@Entity
public class User implements java.io.Serializable {
	private static final long serialVersionUID = 8198173157518983615L;

	private String username;
	private String password;
	private String firstname;
	private String lastname;
	private String email;
	private int telephone;
	private boolean enabled;
	private Set<UserRole> userRole = new HashSet<UserRole>(0);
	private Set<Rentable> rentables;
	private Set<Rating> ratings;
	
	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(length = 100000)
	private byte[] image;


	public User() {
	}

	public User(String username, String password, String firstname,
			String lastname, String email, int telephone, boolean enabled) {
		this.username = username;
		this.password = password;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.telephone = telephone;
		this.enabled = enabled;
	}

	public User(String username, String password, boolean enabled,
			Set<UserRole> userRole) {
		this.username = username;
		this.password = password;
		this.enabled = enabled;
		this.userRole = userRole;
	}

	@Id
	@Column(name = "username", unique = true, nullable = false, length = 45)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "password", nullable = false, length = 60)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "firstname", length = 45, nullable = false)
	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	@Column(name = "lastname", length = 45, nullable = false)
	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	@Email
	@Column(nullable = false)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(nullable = false)
	public int getTelephone() {
		return telephone;
	}

	public void setTelephone(int telephone) {
		this.telephone = telephone;
	}

	@Column(name = "enabled", nullable = false)
	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
	public Set<UserRole> getUserRole() {
		return userRole;
	}

	public void setUserRole(Set<UserRole> userRole) {
		this.userRole = userRole;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "user")
	public Set<Rentable> getRentables() {
		return rentables;
	}

	public void setRentables(Set<Rentable> rentables) {
		this.rentables = rentables;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "author")
	public Set<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(Set<Rating> ratings) {
		this.ratings = ratings;
	}

	@Override
	public boolean equals(Object obj) {
		User other = (User) obj;
		if (username == other.username)
			return true;
		return false;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}
	
}
