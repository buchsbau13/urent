package at.fh.swenga.urent.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;

@Entity
public class Rating {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Version
	private long version;

	@ManyToOne(cascade = CascadeType.MERGE)
	private User author;

	@Temporal(TemporalType.DATE)
	private Date date;

	@Column(nullable = false)
	private String title;

	@Column(nullable = false)
	private String text;

	@ManyToOne(cascade = CascadeType.MERGE)
	private Rentable rentable;

	public Rating() {
	}

	public Rating(User author, Date date, String title, String text, Rentable rentable) {
		super();
		this.author = author; 
		this.date = date;
		this.title = title;
		this.text = text;
		this.rentable = rentable;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Rentable getRentable() {
		return rentable;
	}

	public void setRentable(Rentable rentable) {
		this.rentable = rentable;
	}

}
