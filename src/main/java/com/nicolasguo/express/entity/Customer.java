package com.nicolasguo.express.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.nicolasguo.express.common.ProjectConfig;

@Entity
@Table(name = "tb_customer")
public class Customer extends BaseEntityObject {

	private String name;
	
	private String idcard;
	
	private String phoneNumber;

	@Column(length = 255)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(length = 18)
	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	@Column(length = 11)
	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

}
