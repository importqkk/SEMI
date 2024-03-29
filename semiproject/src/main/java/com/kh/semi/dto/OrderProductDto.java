package com.kh.semi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class OrderProductDto {
	//상품 DB에서 꺼내올값
	private int productCount,productPrice,productNo,orderNo;
	
	//만들어낼 값
	private int totalPrice;

	
	//총 금액 계산
	public void calculating() {
		this.totalPrice = this.productPrice*this.productCount;
	}
	
	
	
	
}