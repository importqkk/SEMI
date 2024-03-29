package com.kh.semi.dto;
import java.sql.Date;
import lombok.Data;

@Data
public class MemberDto {
	private String memberId;
	private String memberName;
	private String memberNick;
	private String memberPw;
	private String memberPhone;
	private String memberEmail;
	private String memberPost;
	private String memberBasicAddr;
	private String memberDetailAddr;
	private int memberPoint;
	private Date memberJoin;
	private String memberRole;
	private String agreeTos;	
	private String agreePrivacy;	
	private String agreePromotion;

}