package com.woof.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Cart {

	private int cartNo;
	private String username;
	private int itemNo;
	private String itemName;
	private int quantity;
	private int price;
	private String itemMainPic;
	private String checkStatus;
	
	private int newQuantity;
}
