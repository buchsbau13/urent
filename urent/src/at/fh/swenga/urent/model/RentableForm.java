package at.fh.swenga.urent.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

public class RentableForm implements Serializable{

	private static final long serialVersionUID = 5881114270120151424L;
	
	@Version
	private long version;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	private int categoryId; 
	
	@Column(nullable = false, length = 50)
	private String title;

	@Column(nullable = false)
	private String description;
	
	@Column(nullable = false)
	private double price;
	
	private byte[] image; 
	
	private String street; 
	private String city; 
	private String country; 
	private String zip; 

	public RentableForm() {
	}

	public RentableForm(int categoryId, String title, String description,
			double price, byte[] image, String street, String city, String country, String zip) {
		super();
		this.categoryId = categoryId;
		this.title = title;
		this.description = description;
		this.price = price;
		this.image = image; 
		this.street = street; 
		this.city = city; 
		this.country = country; 
		this.zip = zip; 
	}

	public long getVersion() {
		return version;
	}

	public void setVersion(long version) {
		this.version = version;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
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

	public void setImage(byte[] image) {
		this.image = image;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}
	
	
	
	

}
