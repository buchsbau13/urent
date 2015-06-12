package at.fh.swenga.urent.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Version;

@Entity
public class Rentable implements Serializable {

	private static final long serialVersionUID = -2890486897223592187L;

	@Version
	private long version;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@ManyToOne(cascade = CascadeType.MERGE)
	private User user;

	@ManyToOne(cascade = CascadeType.MERGE)
	private Category category;

	@OneToMany(mappedBy = "rentable", fetch = FetchType.EAGER)
	private Set<Rating> ratings;

	@Column(nullable = false, length = 50)
	private String title;

	@Column(nullable = false)
	private String description;

	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(length = 100000)
	private byte[] image;

	@Column(nullable = false)
	private double price;

	@Column(nullable = false)
	private Address location;

	@ManyToMany(cascade = CascadeType.MERGE, fetch=FetchType.EAGER)
	private List<User> wishlistUsers;

	public Rentable() {
	}

	public Rentable(User user, Category category, String title,
			String description, double price, byte[] image, Address location,
			List<User> wishlistUsers) {
		super();
		this.user = user;
		this.category = category;
		this.title = title;
		this.description = description;
		this.price = price;
		this.image = image;
		this.location = location;
		this.wishlistUsers = wishlistUsers;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] bs) {
		this.image = bs;
	}

	public Address getLocation() {
		return location;
	}

	public void setLocation(Address location) {
		this.location = location;
	}

	public Set<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(Set<Rating> ratings) {
		this.ratings = ratings;
	}

	public void addRating(Rating rating) {
		if (ratings == null) {
			ratings = new HashSet<Rating>();
		}
		ratings.add(rating);
	}

	public List<User> getWishlistUsers() {
		return wishlistUsers;
	}

	public void setWishlistUsers(List<User> wishlistUsers) {
		this.wishlistUsers = wishlistUsers;
	}

}
