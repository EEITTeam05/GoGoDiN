package com.cart.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class CartMap {
	
	
	private Map<Integer, CartBean> cart = new HashMap< >();
	public CartMap() {
	}
	public Map<Integer, CartBean>  getContent() {  // ${ShoppingCart.content}
		return cart;
	}
	
	public void addToCart(int TktId, CartBean  oi) {
		if (oi.getQty() <= 0 ) {
			return;
		}
		// 如果客戶在伺服器端沒有此項商品的資料，則客戶第一次購買此項商品
		if ( cart.get(TktId) == null ) {
		    cart.put(TktId, oi);
		} else {
	        // 如果客戶在伺服器端已有此項商品的資料，則客戶『加購』此項商品
			CartBean oib = cart.get(TktId);
			// 加購的數量：oi.getQty()
			// 原有的數量：oib.getQty()
			oib.setQty(oi.getQty() + oib.getQty());
		}
	}
	// 修改商品的數量
	public boolean modifyQty(int TktId, CartBean  oi) {
		if ( cart.get(TktId) != null && oi.getQty() > 0 ) {
	       cart.put(TktId, oi);
	       return true;
		} else {
		   return false;
		}
	}
	public boolean modifyQty(int TktId, int  newQty) {
		if ( cart.get(TktId) != null ) {
		   CartBean  oi = (CartBean)cart.get(TktId);
		   oi.setQty(newQty);
	       cart.put(TktId, oi);
	       return true;
		} else {
		   return false;
		}
	}
	// 刪除某項商品
	public int deleteBook(int TktId) {
		if ( cart.get(TktId) != null ) {
	       cart.remove(TktId);  // Map介面的remove()方法
	       return 1;
		} else {
		   return 0;
		}
	}
	public int getItemNumber(){   // ShoppingCart.itemNumber
		return cart.size();
	}
	
//	public String getItemName(int TktId){   // ShoppingCart.itemNumber
//		return cart.get(TktId).getProductName();
//	}
	
	//計算購物車內所有商品的合計金額(每項商品的單價*數量的總和)
	public double getSubtotal(){
		double subTotal = 0 ;
		Set<Integer> set = cart.keySet();
		for(int n : set){
			double price    = cart.get(n).getTktMoney();
			int    qty      = cart.get(n).getQty();
			subTotal +=  price * qty;
		}
		return subTotal;
	}
	
	public double gettotal(int TktId){
		double total = 0 ;
		Set<Integer> set = cart.keySet();
		for(int n : set){
			double price    = cart.get(TktId).getTktMoney();
			int    qty      = cart.get(TktId).getQty();
			total +=  price * qty;
		}
		return total;
	}

	
//	public void listCart() {
//		Set<Integer> set = cart.keySet();
//		for(Integer k : set){
//			System.out.printf("TktId=%3d,  Qty=%3d,  price=%5.2f,  discount=%6.2f\n" , k , cart.get(k).getQty(), cart.get(k).getPrice(), cart.get(k).getDiscount());
//		}
//		System.out.println("------------------");
//	}
}
