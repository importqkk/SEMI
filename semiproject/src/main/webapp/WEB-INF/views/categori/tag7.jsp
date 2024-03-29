<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<head>
<style>
		.fas{
			font-size: 40px;
		}

		.font-lightgrey{
			color: #afafaf;
		}
		
		.font-grey{
			color: grey;
		}
		
		.w-2{
			width:2%;
		}
		.w-7{
			width:7%;
		}
		.w-8{
			width:8%;
		}
		.w-9{
			width:9%;
		}
        .flex-row {
            flex-direction: column;
        }
        
        .oneLine { /* 한줄에 표현 */
            display: inline;
        }

        .purple-box{
        	background-color: #d0ccff;
        	border-radius: 0.1em;
        }
        .vertical-center{
        	align-items: center;
        }
        
        .img-list{
        	width: 200px;
        	height: 200px;
        }
        .star-13{
        	font-size: 13px;
        }
        
        .img-box{
        	padding-top:10px;
	        width: 235px;
	        height: 400px;
	        background-color: #f8f8f8;  /* 배경색 */
	        border-radius: 20px; /* 끝부분 조정*/
	        align-items: center;
	        margin-bottom: 20px;
        }
       

		.flex-wr{
			display: flex;		
			flex-wrap: wrap;
		}
		
		.flex-wr.center{
			justify-content: center;
		}
		.flex-wr.left{
			justify-content: right;
		}
		
		.a-font-purple{
			color: #776bff;
			font-size:13px;
			font-weight:bolder;
			cursor:pointer;
			
		}
		.a-font-lightgrey{
			color: #afafaf;
			font-size:13px;
			font-weight:bolder;
			cursor:pointer;
		}
		
		
		a.fas{
			text-decoration: none;
			color: #776bff;
		}
		
		.inLine {
			display: inline;
		}
		
		.star-white{ /* 하얀색 별 */
			color: white;
			-webkit-text-stroke: 1.2px #776BFF; /* 텍스트 테두리 색 지정 */
			font-weight: bolder;
		}
		.star-purple{
			color: #776BFF;
		}
		.productName {
			min-height: 80px;
			max-height: 80px;
		}
		
		.item-img{
			min-height: 200px;
			min-width: 200px;
		}
</style>
<script type="text/javascript">
	// "none"
	$(function(){
		$(".a-font-lightgrey").click(function(){ // 회색글씨가 눌리면 
			$(".a-font-purple").removeClass("a-font-purple").addClass("a-font-lightgrey"); // 보라글씨의 a-font-purple클래스를 지우고 a-font-lightgrey 클래스를 추가
			$(this).removeClass("a-font-lightgrey") // 눌린 글씨의 a-font-ligtgrey 클래스를 제거
			$(this).addClass("a-font-purple") // 눌린 글씨에 a-font-purple
			if($(this).text()=="인기순")	
			{
				
				$(".best").show();
				$(".new").hide();
				$(".cheap").hide();
				$(".expensive").hide();
				
			}
			else if($(this).text()=="최신순"){
				
				$(".best").hide();
				$(".new").show();
				$(".cheap").hide();
				$(".expensive").hide();
			}
			else if($(this).text()=="낮은가격순")
			{
				
				$(".best").hide();
				$(".new").hide();
				$(".cheap").show();
				$(".expensive").hide();
			}
			else{
				
				$(".best").hide();
				$(".new").hide();
				$(".cheap").hide();
				$(".expensive").show();
			}
		});		
		
		$(".img-box").click(function(){
			var index = $(this).data('index'); // best로 정렬한 순서에서 클릭된 위치의 index 반환
			var index1 = $(this).data('index1'); // new로 정렬한 순서에서 클릭된 위치의 index 반환
			var index2 = $(this).data('index2'); // cheap로 정렬한 순서에서 클릭된 위치의 index 반환
			var index3 = $(this).data('index3'); // expensive로 정렬한 순서에서 클릭된 위치의 index 반환
			if(index!=null){ // best가 
				indexr = index;
				var productNo = $(".productNoBest").eq(indexr).text();
			}
			if(index1!=null){ // new
				indexr = index1;
				var productNo = $(".productNoNew").eq(indexr).text();
			}
			if(index2!=null){ // cheap
				indexr = index2;
				var productNo = $(".productNoCheap").eq(indexr).text();
			}
			if(index3!=null){ // expensive
				indexr = index3;
				var productNo = $(".productNoExpensive").eq(indexr).text();
			}; 			 
  			$(location).attr("href","${pageContext.request.contextPath}/product/detail?productNo="+productNo);
		});
		
		
		
		
		// 상품 이름 처리
		$(".productName").each(function() {
			var maxChar = 30;
			var productName = $(this).text();
			if (productName.length > maxChar) {
				var shortName = productName.substr(0, maxChar);
				$(this).text(shortName + "...");
			}
		});
		
		
		
		
		// 리뷰 별 처리
		$(".star-box").each(function(){
			var productReview = $(this).children(".productReview").text();
			productReview = Math.round(productReview)
			// 평균 별점을 계산하고 각 별 아이콘에 대해 적절한 색상을 설정합니다.
			
			if (productReview==0){
			}
			else{
				$(this).find("h4").each(function(index) {
					 
					  if (index+1 < productReview) {
					      $(this).removeClass("star-white").addClass("star-purple");
					    } else if (index+1 == productReview) {
					      $(this).removeClass("star-white").addClass("star-purple");
					    } else {
					     
					    }
				});				
			}
		})
		
		// 상품 가격표시 
		$(".productPrice").each(function(){
			var productPrice = $(this).text();
			
			$(this).text(parseInt(productPrice).toLocaleString()+"원");
			
		});
	})
	
</script>

	<div class="container-1200">
		<div class="flex center">
			<a class="w-5 me-50 fas fa-solid fa-border-all" href="${pageContext.request.contextPath}/categori/all"></a>		
			<a class="w-5 me-50 fas fa-light fa-face-smile" href="${pageContext.request.contextPath}/categori/tag1"></a>
			<a class="w-5 me-50 fas fa-light fa-weight-scale" href="${pageContext.request.contextPath}/categori/tag2"></a>
			<a class="w-5 me-50 fas fa-light fa-venus" href="${pageContext.request.contextPath}/categori/tag3"></a>	
			<a class="w-5 me-50 fas fa-sharp fa-light fa-bolt-lightning" href="${pageContext.request.contextPath}/categori/tag4"></a>
			<a class="w-5 me-50 fas fa-thin fa-mars" href="${pageContext.request.contextPath}/categori/tag5"></a>
			<a class="w-5 me-50 fas fa-light fa-eye" href="${pageContext.request.contextPath}/categori/tag6"></a>	
			<a class="w-5 me-50 fas fa-light fa-tooth purple-box"></a>
			<a class="w-5 me-50 fas fa-light fa-bone" href="${pageContext.request.contextPath}/categori/tag8"></a>
		</div>
		<div class="flex center">
			<h5 class="w-5 me-50">전체</h5>
			<h5 class="w-5 me-50">피부</h5>
			<h5 class="w-5 me-50">다이어트</h5>
			<h5 class="w-5 me-50">여성</h5>
			<h5 class="w-5 me-50">활력</h5>
			<h5 class="w-5 me-50">남성</h5>
			<h5 class="w-5 me-50">눈</h5>
			<h5 class="w-5 me-50">치아</h5>
			<h5 class="w-5 me-50">관절/뼈</h5>
		</div>
		<div class="flex left grey-box mt-20 mb-10">	
			<div class="flex w-70 ps-100">
				<a class="w-6 a-font-lightgrey oneLine">인기순</a>
				<a class="w-2 font-lightgrey oneLine">&nbsp;|</a>
				<a class="w-5 a-font-lightgrey oneLine">최신순</a>
				<a class="w-2 font-lightgrey oneLine">&nbsp;|</a>
				<a class="w-9 a-font-lightgrey oneLine">낮은가격순</a>
				<a class="w-2 font-lightgrey oneLine">|</a>
				<a class="w-9 a-font-lightgrey oneLine">높은가격순</a>
			</div>
			<div class="flex w-30 pe-100 right">
				<h5 class="w-30 me-10 font-lightgrey">${count}개의 제품</h5>
			</div>
		</div>	
<!---------------------여기부터는 이미지 들의 리스트 ------------------->
		<!--인기상품 -->
		<div class="flex-wr center mb-20 best">
			<c:forEach var="productInfoDto" items="${bestList}"
				varStatus="status">
				<div class="img-box me-20 center" data-index="${status.index}"
					data-info="best">
					<c:choose>
		            		<c:when test="${productInfoDto.productImgNo != 0}">
			            		<img class="center item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/img/download?imgNo=${productInfoDto.productImgNo}">
			            	</c:when>
		            		<c:otherwise>
		            			<img class="center item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/static/image/productDummy.png" >
		            		</c:otherwise>
	            	</c:choose>
					<br>
					<h5 class="productNoBest" style="display: none;">${productInfoDto.productNo}</h5>

					<div class="row left">
						<h5 class="left ms-20 me-20 font-grey productName mb-10"
							title="${productInfoDto.productName}">[${productInfoDto.productBrand}]
							${productInfoDto.productName}</h5>
					</div>
					<div class="left mb-5">
						<h3 class="ms-20 productPrice">${productInfoDto.productPrice}원</h3>
					</div>
					<div class="left">
						<div class="flex left ms-20 oneLine star-box">
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="productReview" style="display:none;">${productInfoDto.reivewAVG}</h4>
						</div>
<!-- 						<h6 class="font-grey oneLine">150</h6> -->
					</div>

				</div>
			</c:forEach>
		</div>
		<!--최신상품 -->
		<div class="flex-wr center mb-20 new" style="display: none;">
			<c:forEach var="productInfoDto" items="${newList}"
				varStatus="status1">
				<div class="img-box me-20 center" data-index1="${status1.index}"
					data-info="new">
					<c:choose>
		            		<c:when test="${productInfoDto.productImgNo != 0}">
			            		<img class="center item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/img/download?imgNo=${productInfoDto.productImgNo}">
			            	</c:when>
		            		<c:otherwise>
		            			<img class="center item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/static/image/productDummy.png" >
		            		</c:otherwise>
	            	</c:choose>
					<br>
					<h5 class="productNoNew" style="display: none;">${productInfoDto.productNo}</h5>

					<div class="row left">
						<h5 class="left ms-20 me-20 font-grey productName mb-10"
							title="${productInfoDto.productName}">[${productInfoDto.productBrand}]
							${productInfoDto.productName}</h5>
					</div>
					<div class="left mb-5">
						<h3 class="ms-20 productPrice">${productInfoDto.productPrice}원</h3>
					</div>
					<div class="left">
						<div class="flex left ms-20 oneLine star-box">
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="productReview" style="display:none;">${productInfoDto.reivewAVG}</h4>
						</div>
<!-- 						<h6 class="font-grey oneLine">150</h6> -->
					</div>

				</div>
			</c:forEach>
		</div>
		<!--낮은 가격순 -->
		<div class="flex-wr center mb-20 cheap" style="display: none;">
			<c:forEach var="productInfoDto" items="${cheapList}"
				varStatus="status2">
				<div class="img-box me-20 center" data-index2="${status2.index}"
					data-info="cheap">
					<c:choose>
		            		<c:when test="${productInfoDto.productImgNo != 0}">
			            		<img class="center item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/img/download?imgNo=${productInfoDto.productImgNo}">
			            	</c:when>
		            		<c:otherwise>
		            			<img class="center item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/static/image/productDummy.png" >
		            		</c:otherwise>
	            	</c:choose>
					<br>
					<h5 class="productNoCheap" style="display: none;">${productInfoDto.productNo}</h5>

					<div class="row ms-10 me-10 left">
						<h5 class="left ms-20 me-20 font-grey productName mb-10"
							title="${productInfoDto.productName}">[${productInfoDto.productBrand}]
							${productInfoDto.productName}</h5>
					</div>
					<div class="left mb-5">
						<h3 class="ms-20 productPrice">${productInfoDto.productPrice}원</h3>
					</div>
					<div class="left">
						<div class="flex left ms-20 oneLine star-box">
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="productReview" style="display:none;">${productInfoDto.reivewAVG}</h4>
						</div>
<!-- 						<h6 class="font-grey oneLine">150</h6> -->
					</div>

				</div>
			</c:forEach>
		</div>
		<!--높은 가격순 -->
		<div class="flex-wr center mb-20 expensive" style="display: none;">
			<c:forEach var="productInfoDto" items="${expensiveList}"
				varStatus="status2">
				<div class="img-box me-20 center" data-index3="${status2.index}"
					data-info="expensive">
					<c:choose>
		            		<c:when test="${productInfoDto.productImgNo != 0}">
			            		<img class="center item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/img/download?imgNo=${productInfoDto.productImgNo}">
			            	</c:when>
		            		<c:otherwise>
		            			<img class="center item-img" alt="상품 대표 이미지" src="${pageContext.request.contextPath}/static/image/productDummy.png" >
		            		</c:otherwise>
	            	</c:choose>
					<br>
					<h5 class="productNoExpensive" style="display: none;">${productInfoDto.productNo}</h5>

					<div class="row ms-10 me-10 left">
						<h5 class="left ms-20 me-20 font-grey productName"
							title="${productInfoDto.productName}">[${productInfoDto.productBrand}]
							${productInfoDto.productName}</h5>
					</div>
					<div class="left mb-5">
						<h3 class="ms-20 productPrice">${productInfoDto.productPrice}원</h3>
					</div>
					<div class="left">
						<div class="flex left ms-20 oneLine star-box">
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="fas fa-star star-white star-13 "></h4>
							<h4 class="productReview" style="display:none;">${productInfoDto.reivewAVG}</h4>
						</div>
<!-- 						<h6 class="font-grey oneLine">150</h6> -->
					</div>

				</div>
			</c:forEach>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

