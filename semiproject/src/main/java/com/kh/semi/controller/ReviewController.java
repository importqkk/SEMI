package com.kh.semi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semi.dao.ProductDao;
import com.kh.semi.dao.ReviewDao;
import com.kh.semi.dto.ProductDto;
import com.kh.semi.dto.ReviewDto;
import com.kh.semi.vo.paginationVO;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private ProductDao productDao;
	
	@GetMapping("/list")
	public String list(@ModelAttribute("vo") paginationVO vo,
	                   Model model,
	                   HttpSession session) {
	    String memberId = (String) session.getAttribute("memberId");
	    
	    int totalCount = reviewDao.selectCount(vo, memberId);
	    vo.setCount(totalCount);

	    List<ReviewDto> list = reviewDao.selectList(vo, memberId);
	    model.addAttribute("list", list);

	    return "/WEB-INF/views/review/list.jsp";
	}


}