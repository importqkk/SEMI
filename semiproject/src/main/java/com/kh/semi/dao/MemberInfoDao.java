package com.kh.semi.dao;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.MemberInfoDto;

@Repository
public class MemberInfoDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<MemberInfoDto> mapper=(rs,idx)->{
		MemberInfoDto Dto = new MemberInfoDto();
			Dto.setMemberName(rs.getString("member_name"));
			Dto.setMemberPhone(rs.getString("member_phone"));
			Dto.setMemberPost(rs.getString("member_post"));
			Dto.setMemberBasicAddr(rs.getString("member_basic_addr"));
			Dto.setMemberDetailAddr(rs.getString("member_detail_addr"));
			Dto.setOrderRequest(rs.getString("ORDER_REQUEST"));
			Dto.setMemberId(rs.getString("member_id"));
			Dto.setInsertDate(rs.getDate("INSERT_DATE"));
	        return Dto;
				
	};
	

	
	//회원 주소지 관리내에 있는 모든주소를 뽑아옴
	public List<MemberInfoDto> addrInfo(String memberId) {
		String sql = "select * from member_addr where member_Id=?";
		Object[] param = {memberId};
		return jdbcTemplate.query(sql, mapper, param);
	}
	
	//신규 주소 등록
	public void addinsert(MemberInfoDto memberInfoDto) {
		String sql="insert into MEMBER_ADDR(MEMBER_NAME, MEMBER_PHONE, MEMBER_POST, MEMBER_BASIC_ADDR, MEMBER_DETAIL_ADDR,ORDER_REQUEST ,MEMBER_ID,INSERT_DATE) values (?,?,?,?,?,?,?,sysdate)";
		Object[] param= {memberInfoDto.getMemberName(),memberInfoDto.getMemberPhone(),memberInfoDto.getMemberPost(),
				memberInfoDto.getMemberBasicAddr(),memberInfoDto.getMemberDetailAddr(),memberInfoDto.getOrderRequest(),memberInfoDto.getMemberId()};
		jdbcTemplate.update(sql,param);
	}
	
	//삭제구문
   public boolean addDelete(String memberId,String name,String phone,String post,String basic,String request) {
   
      String sql="DELETE FROM member_addr WHERE member_id= ? and MEMBER_NAME= ? and MEMBER_PHONE= ? and MEMBER_POST= ? and MEMBER_Basic_ADDR = ? and ORDER_REQUEST= ?";
      Object[] param = {memberId,name,phone,post,basic,request};
      return jdbcTemplate.update(sql, param) > 0;
   }
	
	
		
	
	
}
