<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
		
<style>
    h1, h2, h3, h4, span {
        margin: 0;
    }
    .product-img {
        background-color: #f8f8f8;
        border-radius: 25px;
        padding: 10px;
    }
    .check-btn, .fa-xmark {
        cursor: pointer;
    }
</style>
<script type="text/javascript">
    $(function() {
        // 전체 체크박스 체크하면 개별 체크박스 체크 처리
        $(".check-all").change(function() {
            var isChecked = $(this).prop("checked");
            $(".check-all, .check-item").prop("checked", isChecked);
        })
        // 개별 체크박스 전부 체크하면 전체 체크박스 체크 처리
        $(".check-item").change(function() {
            var checkboxCount = $(".check-item").length;
            var checkedCount = $(".check-item:checked").length;
            var isAllchecked = checkboxCount == checkedCount;
            $(".check-all").prop("checked", isAllchecked);
        })
        // 아무 상품도 선택하지 않고 선택상품 결제 버튼 누르면 경고창 뜨게 하기
        $(".selected-btn").click(function() {
            var checkItem = $(".check-item:checked").length;
            if(checkItem < 1) alert("구매하실 상품을 한 개 이상 선택해주세요.");
        })
    });
</script>

    <div class="container-1000 mt-40">

        <div class="row-large flex">
            <h1 class="me-15">장바구니</h1>
            <h1 class="c-p100">3</h1>
        </div>

        <div class="row-medium">
            <div class="flex me-15">
                <label class="flex">
                    <input type="checkbox" class="me-10 check-all">
                    <h3>전체선택</h3>
                </label>
            </div>
        </div>

        <div class="row-large flex cart-item">
            <div class="flex me-15">
                <input type="checkbox" class="check-item">
            </div>
            <div class="flex me-15">
                <img class="product-img" src="/static/image/productDummy.png" width="130" height="130">
            </div>
            <div class="w-100">
                <div class="row-medium flex">
                    <h4 class="me-5 c-b80">[자로우포뮬러스]</h4>
                    <span class="c-b80">자로우 도필러스 이피에스 60캡슐</span>
                </div>
                <div class="row">
                    <h4><span>30,000</span>원</h4>
                </div>
                <div>
                    <div class="flex qty-stepper-small center">
                        <span class="minus disabled">-</span>
                        <span class="number">1</span>
                        <span class="plus">+</span>
                    </div>
                </div>
            </div>
            <div class="flex row" style="align-self: baseline;">
                <i class="fa-solid fa-xmark font-h2 delete-btn"></i>
            </div>
        </div>

        <div class="row-large">
            <a class="form-btn medium neutral w-100" href="메인으로가는링크">더 쇼핑하기</a>
        </div>

        <div class="row-large">
            <table class="table table-cart">
                <tbody class="center">
                    <tr>
                        <th class="w-30">총 제품 금액</th>
                        <th></th>
                        <th class="w-20">기본 배송비</th>
                        <th></th>
                        <th class="w-35">예상 결제 금액</th>
                    </tr>
                    <tr>
                        <td><h2 class="product-price">60,000</h2></td>
                        <td><h2 class="plus c-b80">+</h2></td>
                        <td><h2 class="delevery-prive">3,000</h2></td>
                        <td><h2 class="equal c-b80">=</h2></td>
                        <td><h2 class="total-price">63,000</h2></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="row">
            <div class="row">
                <a class="form-btn medium neutral w-100 selected-btn" href="#">선택상품 결제하기</a>
            </div>
            <div class="row">
                <a class="form-btn medium positive w-100 all-btn" href="#">전체상품 결제하기</a>
            </div>
        </div>

    </div>
		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>