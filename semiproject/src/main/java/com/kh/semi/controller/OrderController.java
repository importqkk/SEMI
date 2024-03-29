package com.kh.semi.controller;


import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.CartDao;
import com.kh.semi.dao.CartProductInfoDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberInfoDao;
import com.kh.semi.dao.OrderDao;
import com.kh.semi.dao.OrderListDao;
import com.kh.semi.dao.OrderProductDao;
import com.kh.semi.dao.ProductDao;
import com.kh.semi.dao.ProductInfoDao;
import com.kh.semi.dto.CartProductInfoDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.MemberInfoDto;
import com.kh.semi.dto.OrderDto;
import com.kh.semi.dto.OrderProductDto;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private MemberInfoDao memberInfoDao;
	@Autowired
	private MemberDao memberDao;

	@Autowired
	private CartDao cartDao;
	@Autowired
	private CartProductInfoDao cartProductInfoDao;
	
	@Autowired
	private ProductDao productDao;
	@Autowired
	private ProductInfoDao productInfoDao;
	
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderProductDao orderProductDao;
	@Autowired
	private OrderListDao orderListDao;


	
	//주문페이지
		@GetMapping("/buy")
		public String buy(HttpSession session, Model model,@RequestParam(required=false) Integer productNo,@RequestParam(required=false) Integer productCount) {
			String memberId=(String)session.getAttribute("memberId");
			int point= memberDao.point(memberId);
			//포인트
			model.addAttribute("point",point);
			
			//카트에서 오면 
			if(productNo==null || productCount==null) {
				int totalproduct=0;
				int totalprice=0;
				List<CartProductInfoDto> list = cartProductInfoDao.cartItemInfo(memberId);
				
				//가격뽑기
				for(int i=0; i<list.size();i++)
				{
					
					int count = list.get(i).getProductCount();
					int price = list.get(i).getProductPrice();
					totalproduct+= (count*price);
				}
				totalprice=totalproduct+3000;
				
				model.addAttribute("cartinfo",cartProductInfoDao.cartItemInfo(memberId));
				model.addAttribute("totalproduct",totalproduct);
				model.addAttribute("totalprice",totalprice);
				return "/WEB-INF/views/order/buy.jsp";

			//상세에서 오면
			}else {
				int no=productNo.intValue();
				int Count=productCount.intValue();
				if(Count>10) {
					Count = 10; 
				}
				int price=productInfoDao.orderPrice(no);
				//상품 가격만
				int totalproduct=(price*Count);
				//배달비 빼고 
				int totalprice=totalproduct+3000;
				
				model.addAttribute("productInfo",productInfoDao.selectOne(no));
				model.addAttribute("totalproduct",totalproduct);
				model.addAttribute("totalprice",totalprice);
				model.addAttribute("Count",Count);
				;
				
				
				
				return "/WEB-INF/views/order/buy.jsp";
			
			}
			
			
			

	
			
		}
	
	@PostMapping("/buy")
	public String buy(@ModelAttribute OrderDto orderDto,@ModelAttribute OrderProductDto Dto, HttpSession session,Model model){
		//회원 아이디넣고
		String memberId=(String)session.getAttribute("memberId");
		//주문번호와 주문목록 생성
		orderDto.setMemberId(memberId);
		orderDao.insertOrder(orderDto);
		
		
		//상품 주문 실행
		
		//방금 주문한 번호를 불러오고
		int no=orderDao.orderNo(memberId);

		//장바구니에서 주문시 카트 리스트내에있는 정보들을 가져와서 insert
		if(Dto.getProductNo()==0) {
			List<CartProductInfoDto> list = cartProductInfoDao.cartItemInfo(memberId);
			for (CartProductInfoDto Info : list) {
				
				Dto.setOrderNo(no);
				Dto.setProductNo(Info.getProductNo());
				Dto.setProductCount(Info.getProductCount());
				Dto.setProductPrice(Info.getProductPrice());
				orderProductDao.InsertOrderProduct(Dto);
				
				productDao.increaseSellCount(Dto.getProductCount(), Dto.getProductNo()); //상품판매수량 +
				productDao.decreaseStock(Dto.getProductCount(), Dto.getProductNo()); //상품재고 -

				
				
			}
			model.addAttribute("orderInfo",orderDto);
			model.addAttribute("orderProduct",Dto);
			//카트삭제
			cartDao.cartDeleteAll(memberId);
			return "redirect:buyFinish";
		}//상세페이지에서 주문시 model을 받아서 insert
		else  {
			Dto.setOrderNo(no);
			orderProductDao.InsertOrderProduct(Dto);
			
			productDao.increaseSellCount(Dto.getProductCount(), Dto.getProductNo()); //상품판매수량 +
			productDao.decreaseStock(Dto.getProductCount(), Dto.getProductNo()); //상품재고 -
			return "redirect:buyFinish";

		}
		

		
		
	}
	
		

	//등록완료!
	 @GetMapping("/buyFinish")
	 public String joinFinish() { 
		 
		 return "/WEB-INF/views/order/buyFinish.jsp";
		 
	 }
	
	 
	 //팝업창 성공???
	 
	 
	 //기본주소지- 멤버회원 테이블내에있는 주소지임
	 //주소정보 - 회원이 저장한 모든주소
	
	 //배송지 보여주는 팝업
	 @GetMapping("/popup")
	 public String popup(HttpSession session,Model model) {
		 String memberId=(String)session.getAttribute("memberId");
		 
		 //기본주소지를 보여줌

//		 
//		 //회원 저장한 모든주소를 보여줌

		 model.addAttribute("allInfo",memberInfoDao.addrInfo(memberId)); 
		 return "/WEB-INF/views/order/pop.jsp";
	 }
	 
	 
	 //신규 배송지 넣는 팝업 
	 @GetMapping("/popInsert")
	 public String popInsert() {
		 
		 return "/WEB-INF/views/order/popInsert.jsp";
	 }
	 
	 @PostMapping("/popInsert")
	 public String popInsert(HttpSession session,Model model,@ModelAttribute MemberInfoDto memberInfoDto) {
		 String memberId=(String)session.getAttribute("memberId");
		 //아이디 배치후 주소추가 실행
		 memberInfoDto.setMemberId(memberId);
		 memberInfoDao.addinsert(memberInfoDto);
		 return "redirect:popup";
	 }
	 

	 
	//삭제구문
	@PostMapping("/popDelete")
	public String popDelete(HttpSession session,@RequestParam String name,@RequestParam String phone,
	      @RequestParam String post,@RequestParam String basic,@RequestParam String request) {
	   MemberInfoDto dto=new MemberInfoDto();
	   String memberId=(String)session.getAttribute("memberId");
	   dto.setMemberId(memberId);
	   List<MemberInfoDto> list= memberInfoDao.addrInfo(memberId);
	   
	   //받아온 값을 통해 equals로 비교하고 해당값이 맞으면 dao에 추가해 삭제하는 문장
	   for (int i=0; i<list.size();i++) {
	      
	      
	      if(name.equals(list.get(i).getMemberName()) &&
	                phone.equals(list.get(i).getMemberPhone()) &&
	                post.equals(list.get(i).getMemberPost()) &&
	                basic.equals(list.get(i).getMemberBasicAddr()) &&
	                request.equals(list.get(i).getOrderRequest())
	                ){
	        
	         memberInfoDao.addDelete(memberId,name,phone,post,basic,request);
	         break;
	     }
	      
	   }
	   return "redirect:popup";
	}
	 
	//회원의 구매목록 조회
		 @GetMapping("/myList")
		 public String myList(HttpSession session,Model model) {
			 String memberId=(String)session.getAttribute("memberId");

			 
			 //결제완
			 orderListDao.payment(memberId);
			 model.addAttribute("payment",orderListDao.payment(memberId));
			 
			 
			 //대기
			 orderListDao.prepare(memberId);
			 model.addAttribute("prepare",orderListDao.prepare(memberId));
			 
			 
			 //배송중
			 orderListDao.delivery(memberId);
			 model.addAttribute("delivery",orderListDao.delivery(memberId));
			 
			 
			 //완료
			 orderListDao.complete(memberId);
			 model.addAttribute("complete",orderListDao.complete(memberId));
			 
			 
			 
			 return "/WEB-INF/views/order/myList.jsp";
		 }
}