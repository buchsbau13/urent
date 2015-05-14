package at.fh.swenga.urent.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
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

	@Column(nullable = false, length = 50)
	private String title;

	@Column(nullable = false)
	private String description;

	// Bild

	/*
	 * @OneToOne private Rating rating;
	 */

	@Column(nullable = false)
	private double price;

	// Verfügbarkeit

	public Rentable() {
	}

	public Rentable(User user, Category category, String title, String description,
			double price) {
		super();
		this.user = user; 
		this.category = category;
		this.title = title;
		this.description = description;
		this.price = price;
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

	/*
	 * public Rating getRating() { return rating; }
	 * 
	 * public void setRating(Rating rating) { this.rating = rating; }
	 */

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

}
