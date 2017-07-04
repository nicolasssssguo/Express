package com.nicolasguo.express.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.nicolasguo.express.common.ProjectConfig;

@Entity
@Table(name = ProjectConfig.PREFIX + "_area")
public class Area extends BaseEntityObject {

	private String code;

	private String name;

	private int level;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

}
