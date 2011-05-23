package com.ez;

public class Node implements java.io.Serializable {
	private static final long serialVersionUID = 432509327611624427L;
	private int id;
	private String name;

	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return id;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	@Override
	public String toString() {
		return name;
	}
}
