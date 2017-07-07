package com.nicolasguo.express.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.nicolasguo.express.common.ProjectConfig;

@Entity
@Table(name = ProjectConfig.PREFIX + "_area")
public class Area extends BaseEntityObject {

	private String code;

	private String name;

	private int level;

	private Area parent;

	@Column(nullable = false, length = 128)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(nullable = false, length = 255)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column
	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	public Area getParent() {
		return parent;
	}

	public void setParent(Area parent) {
		this.parent = parent;
	}

}
