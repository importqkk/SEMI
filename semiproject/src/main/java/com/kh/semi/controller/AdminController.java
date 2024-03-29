package com.kh.semi.controller;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.configuration.FileUploadProperties;
import com.kh.semi.dao.DetailImgDao;
import com.kh.semi.dao.ImgDao;
import com.kh.semi.dao.MainImgDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.ProductDao;
import com.kh.semi.dao.ProductImgDao;
import com.kh.semi.dao.ProductInfoDao;
import com.kh.semi.dao.ProductTagDao;
import com.kh.semi.dao.SellListDao;
import com.kh.semi.dto.DetailImgDto;
import com.kh.semi.dto.ImgDto;
import com.kh.semi.dto.MainImgDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.ProductDto;
import com.kh.semi.dto.ProductImgDto;
import com.kh.semi.dto.ProductTagDto;
import com.kh.semi.dto.SellListDto;
import com.kh.semi.vo.MemberListPaginationVo;
import com.kh.semi.vo.ProductListPaginationVo;
import com.kh.semi.vo.SellListPaginationVo;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private ProductDao productDao;
	@Autowired
	private ProductTagDao productTagDao;
	@Autowired
	private ImgDao imgDao;
	@Autowired
	private ProductImgDao productImgDao;
	@Autowired
	private ProductInfoDao productInfoDao;
	@Autowired
	private DetailImgDao detailImgDao;
	@Autowired
	private MainImgDao mainImgDao;
	@Autowired
	private FileUploadProperties fileUploadProperties;
	private File dir;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private SellListDao sellListDao;
	
	@PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
	}
	
	// 관리자 메인
	@GetMapping
	public String adminMain() {
		return "/WEB-INF/views/admin/main.jsp";
	}
	
	// 상품 등록
	@GetMapping("/productManage/register")
	public String register() {
		return "/WEB-INF/views/admin/productManage/register.jsp";
	}
	@PostMapping("/productManage/register")
	public String register(@ModelAttribute ProductDto productDto, 
			@ModelAttribute ProductTagDto productTagDto,
			@RequestParam(required=false) int tagNo,
			MultipartFile img1, MultipartFile img2) 
			throws IllegalStateException, IOException {
		// 상품 정보 등록
		int productNo = productDao.sequence();
		productDto.setProductNo(productNo);
		productDao.insert(productDto);
		// 태그 연결
		if(tagNo > 0 && tagNo <= 8) {
			productTagDto.setProductNo(productNo);
			productTagDto.setTagNo(tagNo);
			productTagDao.insert(productTagDto);
		}
		// 상품 대표이미지 저장 및 등록
		if(!img1.isEmpty()) {
			// 대표사진 번호 뽑기
			int imgNo1 = imgDao.sequence();
			// 대표사진 파일 이름 설정
			File target1 = new File(dir, String.valueOf(imgNo1));
			img1.transferTo(target1);
			// 대표사진 db에 저장
			imgDao.insert(ImgDto.builder()
						.imgNo(imgNo1)
						.imgName(img1.getOriginalFilename())
						.imgType(img1.getContentType())
						.imgSize(img1.getSize())
					.build());
			// 상품 번호와 대표사진 번호 연결
			productImgDao.insert(ProductImgDto.builder()
						.productNo(productDto.getProductNo())
						.imgNo(imgNo1)
					.build());

		}
		// 상품 상세이미지 저장 및 등록
		if(!img2.isEmpty()) {
			// 상세사진 번호 뽑기
			int imgNo2 = imgDao.sequence();
			// 상세사진 파일 이름 설정
			File target2 = new File(dir, String.valueOf(imgNo2));
			img2.transferTo(target2);
			// 상세사진 db에 저장
			imgDao.insert(ImgDto.builder()
					.imgNo(imgNo2)
					.imgName(img2.getOriginalFilename())
					.imgType(img2.getContentType())
					.imgSize(img2.getSize())
				.build());
			// 상품 번호와 상세사진 번호 연결
			detailImgDao.insert(DetailImgDto.builder()
						.productNo(productDto.getProductNo())
						.imgNo(imgNo2)
					.build());
		}
		return "redirect:registerFinish";
	}
	@GetMapping("/productManage/registerFinish")
	public String registerFinish() {
		return "redirect:list";
	}
	
	// 상품 목록
	@GetMapping("/productManage/list")
	public String list(Model model,
			@ModelAttribute("vo") ProductListPaginationVo vo) {
		int totalCount = productDao.selectCount(vo);
		vo.setCount(totalCount);
		List<ProductDto> list = productDao.list(vo);
		model.addAttribute("list", list);
		return "/WEB-INF/views/admin/productManage/list.jsp";
	}
	
	// 상품 삭제
	@GetMapping("/productManage/delete")
	public String delete(@RequestParam(value="productNo") int productNo) {
		if(productInfoDao.selectOneForImg(productNo).getProductImgNo() != null) {
			imgDao.delete(productInfoDao.selectOneForImg(productNo).getProductImgNo());
		}
		if(productInfoDao.selectOneForImg(productNo).getDetailImgNo() != null) {
			imgDao.delete(productInfoDao.selectOneForImg(productNo).getDetailImgNo());
		}
		productDao.delete(productNo);
		return "redirect:list";
	}
	// 선택 상품 삭제
	@PostMapping("/productManage/deleteAll")
	public String deleteAll(@RequestParam(value="productNo") List<Integer> list) {
		for(int productNo : list) {
			if(productInfoDao.selectOneForImg(productNo).getProductImgNo() != null) {
				imgDao.delete(productInfoDao.selectOneForImg(productNo).getProductImgNo());
			}
			if(productInfoDao.selectOneForImg(productNo).getDetailImgNo() != null) {
				imgDao.delete(productInfoDao.selectOneForImg(productNo).getDetailImgNo());
			}
			productDao.delete(productNo);
		}
		return "redirect:list";
	}
	
	// 상품 정보 수정
	@GetMapping("/productManage/edit")
	public String edit(Model model, 
			@RequestParam int productNo) {
		// [1] 이전 상품 정보 불러오기
		model.addAttribute("productDto", productDao.selectOneInfo(productNo));
		// [2] 이전 태그 정보 불러오기
		model.addAttribute("productTagDto", productTagDao.selectOne(productNo));
		// [3-1] 이전 대표 이미지 정보 불러오기
		int imgNo1 = productInfoDao.selectOneForImg(productNo).getProductImgNo();
		model.addAttribute("img1Dto", imgDao.selectOne(imgNo1));
		// [3-2] 이전 상세 이미지 정보 불러오기
		int imgNo2 = productInfoDao.selectOneForImg(productNo).getDetailImgNo();
		model.addAttribute("img2Dto", imgDao.selectOne(imgNo2));
		return "/WEB-INF/views/admin/productManage/edit.jsp";
	}
	@PostMapping("/productManage/edit")
	public String edit(@ModelAttribute ProductDto productDto,
			@ModelAttribute ProductTagDto productTagDto,
			@RequestParam(required=false) int tagNo,
			RedirectAttributes attr,
			MultipartFile img1, MultipartFile img2) throws IllegalStateException, IOException {
		// [4] 상품 정보 수정
		productDao.editInfo(productDto);
		// [5] 태그 정보 수정
		if(tagNo > 0 && tagNo <= 8) {
			productTagDto.setProductNo(productDto.getProductNo());
			productTagDto.setTagNo(tagNo);
			productTagDao.edit(productTagDto);
		}
		// [6-1] 대표 이미지를 새로 업로드했으면
		if(!img1.isEmpty()) {
			// [6-1-1] 이전 대표 이미지 삭제
			int imgNo1 = productInfoDao.selectOneForImg(productDto.getProductNo()).getProductImgNo();
			imgDao.delete(imgNo1);
			// [6-1-2] 신규 대표 이미지 업로드
			// 대표사진 번호 뽑기
			imgNo1 = imgDao.sequence();
			// 대표사진 파일 이름 설정
			File target1 = new File(dir, String.valueOf(imgNo1));
			img1.transferTo(target1);
			// 대표사진 db에 저장
			imgDao.insert(ImgDto.builder()
						.imgNo(imgNo1)
						.imgName(img1.getOriginalFilename())
						.imgType(img1.getContentType())
						.imgSize(img1.getSize())
					.build());
			// 상품 번호와 대표사진 번호 연결
			productImgDao.insert(ProductImgDto.builder()
						.productNo(productDto.getProductNo())
						.imgNo(imgNo1)
					.build());

		}
		// [6-2] 상세 이미지를 새로 업로드했으면
		if(!img2.isEmpty()) {
			// [6-2-1] 이전 상세 이미지 삭제
			int imgNo2 = productInfoDao.selectOneForImg(productDto.getProductNo()).getDetailImgNo();
			imgDao.delete(imgNo2);
			// [6-2-2] 신규 상세 이미지 업로드
			// 상세사진 번호 뽑기
			imgNo2 = imgDao.sequence();
			// 상세사진 파일 이름 설정
			File target2 = new File(dir, String.valueOf(imgNo2));
			img2.transferTo(target2);
			// 상세사진 db에 저장
			imgDao.insert(ImgDto.builder()
					.imgNo(imgNo2)
					.imgName(img2.getOriginalFilename())
					.imgType(img2.getContentType())
					.imgSize(img2.getSize())
				.build());
			// 상품 번호와 상세사진 번호 연결
			detailImgDao.insert(DetailImgDto.builder()
						.productNo(productDto.getProductNo())
						.imgNo(imgNo2)
					.build());
		}
		attr.addAttribute("productNo", productDto.getProductNo());
		return "redirect:editFinish";
	}
	@GetMapping("/productManage/editFinish")
	public String editFinish() {
		return "redirect:list";
	}
	
	// 판매 목록
	@GetMapping("/sell/list")
	public String sellList(Model model,
			@ModelAttribute("vo") SellListPaginationVo vo) {
		int totalCount = sellListDao.selectCount(vo);
		vo.setCount(totalCount);
		List<SellListDto> list = sellListDao.list(vo);
		model.addAttribute("list", list);
		return "/WEB-INF/views/admin/sell/list.jsp";
	}
	
	// 메인 이미지 리스트
	@GetMapping("/mainImg/list")
	public String list(Model model) {
		model.addAttribute("list", mainImgDao.mainImgList());
		return "/WEB-INF/views/admin/mainImg/list.jsp";
	}
	
	// 메인 이미지 등록
	@GetMapping("/mainImg/upload")
	public String upload() {
		return "/WEB-INF/views/admin/mainImg/upload.jsp";
	}
	@PostMapping("/mainImg/upload")
	public String upload(MainImgDto mainImgDto, MultipartFile img) throws IllegalStateException, IOException {
		// 메인 이미지 정보 등록
		int mainNo = mainImgDao.sequence();
		mainImgDto.setMainNo(mainNo);
		// 대표사진 번호 뽑기
		int imgNo = imgDao.sequence();
		// 대표사진 파일 이름 설정
		File target = new File(dir, String.valueOf(imgNo));
		img.transferTo(target);
		// 대표사진 db에 저장
		imgDao.insert(ImgDto.builder()
					.imgNo(imgNo)
					.imgName(img.getOriginalFilename())
					.imgType(img.getContentType())
					.imgSize(img.getSize())
				.build());
		// 상품 번호와 대표사진 번호 연결
		mainImgDao.mainImgInsert(MainImgDto.builder()
					.mainNo(mainNo)
					.imgNo(imgNo)
					.mainTitle(mainImgDto.getMainTitle())
				.build());
		// 정보 등록
		return "redirect:uploadFinish";
	}
	@GetMapping("/mainImg/uploadFinish")
	public String uploadFinish() {
		return "redirect:list";
	}
	
	// 메인 이미지 삭제
	@GetMapping("/mainImg/delete")
	public String mainImgDelete(@RequestParam int mainNo) {
		imgDao.delete(mainImgDao.mainImgSelectOne(mainNo).getImgNo());
		mainImgDao.delete(mainNo);
		return "redirect:list";
	}
	// 선택 이미지 삭제
	@PostMapping("/mainImg/mainImgDeleteAll")
	public String mainImgDeleteAll(@RequestParam(value="mainNo") List<Integer> list) {
		for(int mainNo : list) {
			imgDao.delete(mainImgDao.mainImgSelectOne(mainNo).getImgNo());
			mainImgDao.delete(mainNo);
		}
		return "redirect:list";
	}

	
	@GetMapping("/member/detail")
	public String memberDetail(Model model, 
						@RequestParam String memberId) {
		model.addAttribute("memberDto", memberDao.selectOne(memberId));
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	@GetMapping("/member/delete")
	public String memberDelete(
			@RequestParam String memberId,
			@RequestParam(required = false, defaultValue = "1") int page,
			RedirectAttributes attr) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		memberDao.delete(memberId);
//		memberDao.insertWaiting(memberDto);
		
		attr.addAttribute("page", page);
		return "redirect:list";
	}
	
//	회원 정보 변경
	@GetMapping("/member/edit")
	public String memberEdit(@RequestParam String memberId, Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/admin/member/edit.jsp";
	}
	
	@PostMapping("/member/edit")
	public String memberEdit(
			@ModelAttribute MemberDto memberDto,
			RedirectAttributes attr) {
		//정보변경
		memberDao.changeInformationByAdmin(memberDto);
		attr.addAttribute("memberId", memberDto.getMemberId());
		return "redirect:detail";
	}

	@GetMapping("/member/list")
	public String list(Model model,
			@ModelAttribute("vo") MemberListPaginationVo vo) {
		int totalCount = memberDao.selectCount(vo);
		vo.setCount(totalCount);
		List<MemberDto> list = memberDao.list(vo);
		model.addAttribute("list", list);
		return "/WEB-INF/views/admin/member/list.jsp";
	}

	
}