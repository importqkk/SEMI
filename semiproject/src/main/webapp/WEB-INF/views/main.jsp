<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- swiper cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<!-- swiper script -->
<script src="${pageContext.request.contextPath}/static/js/swiper.js"></script>
<style>
	.swiper {
		width: 100%;
    }
    .swiper img {
        width: 100%;
        height: 100%;
     	min-height: 520px;   
    }
    .swiper-pagination-bullet-active {
        background-color: #776BFF !important;
    }
    .swiper-pagination-bullet {
        opacity: 1;
        background-color: #e4e1ff
    }
    .fas{
		font-size: 40px;
        cursor: pointer;
        margin-bottom: 15px;
        color: #776BFF;
	}
    .fa-beat {
        scale: 1;
        animation-duration: 2s;
    }
    .flex.flex-auto-width > * {
        flex-grow: 1;
    }
    h5, h3 {
        margin: 0;
    }
    h1, h2, h4 {
        margin: 0;
        display: inline;
    }
    .star {
        color: #776BFF;
        font-size: 0.7em;
    }
    .item-box {       
        padding-top:10px;
        width: 235px;
        height: 400px;
        background-color: #f8f8f8;  /* 배경색 */
        border-radius: 20px; /* 끝부분 조정*/
        align-items: center;
    }
    .item-box:not(:last-child) {
    	margin-right: 10px;
    }
    .item-box:hover {
        background-color: #f8f8ff;
    }
    .item-img {
        width: 100%;
        height: 100%;
        min-height: 200px;
        max-height: 200px;
        border-radius: 20px;
    }
    .new-box > *,
    .best-box > *, 
    .product-box > * {
        flex-grow: 1;
    }
    .more-link {
    	cursor: pointer;
    	text-decoration: none;
    }
    .more-link:hover {
    	color: #22201e;
    }
    .category-title {
    	color: #776bff;
    }
    .flex-wr {
		display: flex;		
		flex-wrap: wrap;
	}
	.item-title {
		min-height: 80px;
	}
    .product-name {
        overflow: hidden;
        white-space: normal;
        text-overflow: ellipsis;
    }
</style>
<script type="text/javascript">
	$(function() {
		// 카테고리 hover 효과
		$(".fas").hover(function() {
            $(this).addClass("fa-beat");
        },
        function() {
            $(this).removeClass("fa-beat");
        });
		$(".category-title").hover(function() {
			$(this).prev(".fas").addClass("fa-beat");
		},
		function() {
			$(this).prev(".fas").removeClass("fa-beat");
		})
	})
</script>
		<!----------------------메인컨텐츠 start---------------------->
		    <div class="container-1000">
		        <!-- 이미지 슬라이드 start -->
		        <div class="row pb-30">
		            <div class="swiper">
		                <div class="swiper-wrapper center">
		                	<c:choose>
		                		<c:when test="${mainImgList == null}">
		                			<div class="swiper-slide">
		                    			<img alt="메인 슬라이드 이미지" class="slide-img" src="${pageContext.request.contextPath}/static/image/dummy01.jpg">
		                    			<img alt="메인 슬라이드 이미지" class="slide-img" src="${pageContext.request.contextPath}/static/image/dummy02.jpg">
		                    			<img alt="메인 슬라이드 이미지" class="slide-img" src="${pageContext.request.contextPath}/static/image/dummy03.jpg">
			                    	</div>
		                		</c:when>
		                		<c:otherwise>
		                			<c:forEach var="mainImgConnectDto" items="${mainImgList}">
				                    	<div class="swiper-slide">
			                    			<img alt="메인 슬라이드 이미지" class="slide-img" src="${pageContext.request.contextPath}/img/download?imgNo=${mainImgConnectDto.imgNo}">
				                    	</div>
			                    	</c:forEach>
		                		</c:otherwise>
		                	</c:choose>
		                </div>
		                <div class="swiper-pagination center"></div>
		            </div>
		        </div>
		        <!-- 이미지 슬라이드 end -->
		        <!-- 카테고리 버튼 start -->
		        <div class="flex center pt-40 flex-auto-width mb-70">
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/all">
		                    <i class="fas fa-solid fa-border-all"></i>
		                    <h5 class="category-title">전체</h5>
		                </a>
		            </div>
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/tag1">
		                    <i class="fas fa-light fa-face-smile"></i>
		                    <h5 class="category-title">피부</h5>
		                </a>
		            </div>
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/tag2">
		                    <i class="fas fa-light fa-weight-scale"></i>
		                    <h5 class="category-title">다이이트</h5>
		                </a>
		            </div>
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/tag3">
		                    <i class="fas fa-light fa-venus"></i>
		                    <h5 class="category-title">여성</h5>	
		                </a>
		            </div>
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/tag4">
		                    <i class="fas fa-sharp fa-light fa-bolt-lightning"></i>
		                    <h5 class="category-title">활력</h5>
		                </a>
		            </div>
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/tag5">
		                    <i class="fas fa-thin fa-mars"></i>
		                    <h5 class="category-title">남성</h5>
		                </a>
		            </div>
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/tag6">
		                    <i class="fas fa-light fa-eye"></i>
		                    <h5 class="category-title">눈</h5>
		                </a>
		            </div>
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/tag7">
		                    <i class="fas fa-light fa-tooth"></i>
		                    <h5 class="category-title">치아</h5>
		                </a>
		            </div>
		            <div>
		                <a class="link" href="${pageContext.request.contextPath}/categori/tag8">
		                    <i class="fas fa-light fa-bone"></i>
		                    <h5 class="category-title">관절/뼈</h5>
		                </a>
		            </div>
		        </div>
		        <!-- 카테고리 버튼 end -->
		        <!-- 최신상품 목록 start -->
		        <div class="row pb-70">
		            <div class="row">
		                <h1 class="c-b80 me-5">NEW</h1><h2 class="c-b80 me-5">in</h2><h1 class="me-10 c-p100">MYFORMULA</h1>
		                <span class="c-b80">이달의 신상품을 만나보세요!</span>
		            </div>
 		            <div class="row flex new-box flex-wr">
		            	<c:forEach var="productInfoDto" items="${newProduct}" end="3">
			                <a class="link item-box" href="${pageContext.request.contextPath}/product/detail?productNo=${productInfoDto.productNo}">
			                    <div>
			                    	<c:choose>
					            		<c:when test="${productInfoDto.productImgNo != 0}">
					            			<img class="item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/img/download?imgNo=${productInfoDto.productImgNo}">
				 	            		</c:when>
					            		<c:otherwise>
					            			<img class="item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/static/image/productDummy.png">
					            		</c:otherwise>
					            	</c:choose>
			                    </div>
			                    <div class="row mb-10 text-wrap item-title product-name">
			                        <h4 class="c-b40" title="${productInfoDto.productBrand}">[${productInfoDto.productBrand}] </h4>
			                        <h4 title="${productInfoDto.productName}">${productInfoDto.productName}</h4>
			                    </div>
			                    <div class="mb-5">
			                        <h3>
		                            	<fmt:formatNumber pattern="#,##0" value="${productInfoDto.productPrice}"></fmt:formatNumber>
		                            	원
		                            </h3>
			                    </div>
			                    <div class="flex">
			                    	<c:choose>
			                    		<c:when test="${productInfoDto.reivewAVG >= '4.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '3.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '2.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '1.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '0.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG < '0.5'}">
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    	</c:choose>
			                        <span class="ms-5 c-b40">${productInfoDto.reivewCNT}개의 리뷰</span>
			                    </div>
			                </a>
			            </c:forEach>
		            </div>
		        </div>
		        <!-- 추천상품 목록 end -->
		        <!-- 인기상품 목록 start -->
		        <div class="row pb-70">
		            <div class="row">
		                <h1 class="c-b80 me-5">BEST</h1><h2 class="c-b80 me-5">in</h2><h1 class="me-10 c-p100">MYFORMULA</h1>
		                <span class="c-b80">이번 달 MYFORMULA에서 가장 인기 있는 상품이에요.</span>
		            </div>
		            <div class="row">
		                <div class="row flex best-box flex-wr">
		                	<c:forEach var="productInfoDto" items="${bestProduct}" end="3">
			                    <a class="link item-box" href="${pageContext.request.contextPath}/product/detail?productNo=${productInfoDto.productNo}">
			                        <div>
			                            <c:choose>
						            		<c:when test="${productInfoDto.productImgNo != 0}">
						            			<img class="item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/img/download?imgNo=${productInfoDto.productImgNo}">
					 	            		</c:when>
						            		<c:otherwise>
						            			<img class="item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/static/image/productDummy.png">
						            		</c:otherwise>
						            	</c:choose>
			                        </div>
			                        <div class="row mb-10 item-title product-name">
			                        	<h4 class="c-b40" title="${productInfoDto.productBrand}">[${productInfoDto.productBrand}] </h4>
			                        	<h4 title="${productInfoDto.productName}">${productInfoDto.productName}</h4>
			                        </div>
			                        <div class="mb-5">
			                            <h3>
			                            	<fmt:formatNumber pattern="#,##0" value="${productInfoDto.productPrice}"></fmt:formatNumber>
			                            	원
			                            </h3>
			                        </div>
			                        <div class="flex">
			                    	<c:choose>
			                    		<c:when test="${productInfoDto.reivewAVG >= '4.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '3.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '2.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '1.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '0.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG < '0.5'}">
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    	</c:choose>
			                        <span class="ms-5 c-b40">${productInfoDto.reivewCNT}개의 리뷰</span>
			                    </div>
			                    </a>
			                </c:forEach>
		                </div>
		            </div>
		        </div>
		        <!-- 인기상품 목록 end -->
		        <!-- 전체 상품 리스트 start -->
		        <div class="row pb-30">
		        	<div class="row flex">
		        		<div class="w-50">
		        			<h1 class="c-b80 me-5">전체상품</h1>
		        		</div>
		                <div class="right pe-10 w-50">
	                	<a class="more-link c-b40" href="${pageContext.request.contextPath}/categori/all">더보기 ></a>
	                </div>
		            </div>
		        	
			        <div class="row flex product-box flex-wr">
		            	<c:forEach var="productInfoDto" items="${productList}" end="3">
			                <a class="link item-box" href="${pageContext.request.contextPath}/product/detail?productNo=${productInfoDto.productNo}">
			                    <div>
			                    	<c:choose>
					            		<c:when test="${productInfoDto.productImgNo != 0}">
					            			<img class="item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/img/download?imgNo=${productInfoDto.productImgNo}">
				 	            		</c:when>
					            		<c:otherwise>
					            			<img class="item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/static/image/productDummy.png">
					            		</c:otherwise>
					            	</c:choose>
			                    </div>
			                    <div class="row mb-10 item-title product-name">
			                       	<h4 class="c-b40" title="${productInfoDto.productBrand}">[${productInfoDto.productBrand}] </h4>
		                        	<h4 title="${productInfoDto.productName}">${productInfoDto.productName}</h4>
			                    </div>
			                    <div class="mb-5">
			                        <h3>
		                            	<fmt:formatNumber pattern="#,##0" value="${productInfoDto.productPrice}"></fmt:formatNumber>
		                            	원
		                            </h3>
			                    </div>
			                    <div class="flex">
			                    	<c:choose>
			                    		<c:when test="${productInfoDto.reivewAVG >= '4.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '3.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '2.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '1.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG >= '0.5'}">
			                    			<span class="star"><i class="fa-solid fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    		<c:when test="${productInfoDto.reivewAVG < '0.5'}">
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    			<span class="star"><i class="fa-regular fa-star"></i></span>
			                    		</c:when>
			                    	</c:choose>
			                        <span class="ms-5 c-b40">${productInfoDto.reivewCNT}개의 리뷰</span>
			                    </div>
			                </a>
			            </c:forEach>
		            </div>
		        </div>
		        <!-- 전체 상품 리스트 end -->
		    </div>
		    <!----------------------메인컨텐츠 end---------------------->
		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>