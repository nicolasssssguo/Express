package com.nicolasguo.webtemplate.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.codehaus.jackson.annotate.JsonIgnore;

@SuppressWarnings("serial")
@MappedSuperclass
public class BaseEntityObject implements Serializable {

	private String id;

	private String title;

	private transient Account created;

	private transient Folder parent;

	private String type;

	private Date createTime;

	private Date modifyTime;

	private String path;

	private int index;

	private boolean link;

	private boolean deleted;

	private String deleteCode;

	private Link linkEntity;

	@Id
	@Column(nullable = false, updatable = false, length = 32)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(length = 255)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	public Account getCreated() {
		return created;
	}

	public void setCreated(Account created) {
		this.created = created;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	public Folder getParent() {
		return parent;
	}

	public void setParent(Folder parent) {
		this.parent = parent;
	}

	@Column(length = 8)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Temporal(TemporalType.TIMESTAMP)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	@Transient
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@Transient
	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public boolean isLink() {
		return link;
	}

	public void setLink(boolean link) {
		this.link = link;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	@Column(length=16)
	public String getDeleteCode() {
		return deleteCode;
	}

	public void setDeleteCode(String deleteCode) {
		this.deleteCode = deleteCode;
	}

	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL,orphanRemoval=true)
	public Link getLinkEntity() {
		return linkEntity;
	}

	public void setLinkEntity(Link linkEntity) {
		this.linkEntity = linkEntity;
	}
}
