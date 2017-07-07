package com.nicolasguo.express.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.nicolasguo.express.common.ProjectConfig;

@Entity
@Table(name = "tb_express")
public class Express extends BaseEntityObject {

	private Customer sender;

	private Customer recipient;

	private Area origin;

	private Area destination;

	private char type;

	@ManyToOne
	public Customer getSender() {
		return sender;
	}

	public void setSender(Customer sender) {
		this.sender = sender;
	}

	@ManyToOne
	public Customer getRecipient() {
		return recipient;
	}

	public void setRecipient(Customer recipient) {
		this.recipient = recipient;
	}

	@ManyToOne
	public Area getOrigin() {
		return origin;
	}

	public void setOrigin(Area origin) {
		this.origin = origin;
	}

	@ManyToOne
	public Area getDestination() {
		return destination;
	}

	public void setDestination(Area destination) {
		this.destination = destination;
	}

	@Column
	public char getType() {
		return type;
	}

	public void setType(char type) {
		this.type = type;
	}

}
