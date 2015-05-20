package at.fh.swenga.urent.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Version;

@Embeddable
public class Address {

	@Column(name = "address_street")
	private String street;

	@Column(name = "address_city")
	private String city;

	@Column(name = "address_country")
	private String country;

	@Column(name = "address_zip")
	private String zip;

	public Address() {
	}

	public Address(String street, String city, String country, String zip) {
		super();
		this.street = street;
		this.city = city;
		this.country = country;
		this.zip = zip;
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
