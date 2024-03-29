<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/static/js/find-address.min.js"></script>

<script src="${pageContext.request.contextPath}/static/js/member-join.js"></script>
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <script type="text/javascript">
$(function(){
// 체크박스 전체 선택
$(".checkbox_group").on("click", "#check_all", function () {
    $(this).parents(".checkbox_group").find('input').prop("checked", $(this).is(":checked"));
});

// 체크박스 개별 선택
$(".checkbox_group").on("click", ".normal", function() {
    var is_checked = true;

    $(".checkbox_group .normal").each(function(){
        is_checked = is_checked && $(this).is(":checked");
    });

    $("#check_all").prop("checked", is_checked);
});
});

    </script>
<form class="join-form" action="join" method="post" enctype="multipart/form-data" autocomplete="off">
<div class="container-500">
        <div class="row center">
            <h1 style="color:#776BFF;">MYFORMULA</h1>
        </div>
        <div class="row">
            <label>아이디</label>
            <input type="text" name="memberId" placeholder="영문 소문자, 숫자 8~16자"
               required class="form-input w-100 medium light" >
        <div class="valid-message">사용 가능한 아이디입니다</div>
		<div class="invalid-message">아이디는 영문소문자로 시작하며 숫자를 포함한 8~16자로 작성하세요</div>
		<div class="invalid-message2">이미 사용중인 아이디입니다</div>
        </div>
         <div class="row">
        	<label>이름</label>
        	<input type="text" name="memberName" placeholder="성, 이름 포함 한글 2글자 이상 7글자 이하"
            	required class="form-input w-100 medium light" >
        <div class="valid-message">멋진 이름입니다!</div>
		<div class="invalid-message">이름은 성, 이름 포함 한글 2~7자로 작성하세요</div>
        </div>
        <div class="row">
          <label>닉네임</label>
          <input type="text" name="memberNick" placeholder="한글, 숫자 2~10자"
             required class="form-input w-100 medium light" >
        <div class="valid-message">사용 가능한 닉네임입니다</div>
		<div class="invalid-message">닉네임은 한글 또는 숫자 2~10자로 작성하세요</div>
		<div class="invalid-message2">이미 사용중인 닉네임입니다</div> 
      </div>
        <div class="row">
            <label>비밀번호</label>
            <input type="password" name="memberPw" placeholder="영문 대/소문자, 숫자, 특수문자 8~20자"
               required class="form-input w-100 medium light" >
         <div class="valid-message">올바른 비밀번호 형식입니다</div>
		<div class="invalid-message">영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~20자로 작성하세요</div>
		</div>
        <div class="row">
            <label>비밀번호 확인</label>
            <input type="password"  id="passwordRe" name="memberPwRe" placeholder="비밀번호 확인"
               required class="form-input w-100 medium light" >
		<div class="valid-message">비밀번호가 일치합니다</div>
		<div class="invalid-message">비밀번호가 일치하지 않습니다</div>
		<div class="invalid-message2">비밀번호를 먼저 작성하세요</div>
		</div>
              <div class="row">
            <label>이메일</label>
            <input type="text" name="memberEmail" class="form-input w-100 medium light" required placeholder="이메일 입력">
        <div class="valid-message">사용 가능한 이메일 입니다</div>
		<div class="invalid-message">올바른 이메일 형식을 입력해주세요</div>
		<div class="invalid-message2">이미 사용중인 이메일입니다</div> 
          </div>
          <div class="row">
              <label>전화번호</label>
              <input type="tel" name="memberPhone" placeholder="대시(-)를 제외하고 작성" required class="form-input w-100 medium light">
              <div class="valid-message">사용 가능한 전화번호입니다</div>
              <div class="invalid-message">올바른 전화번호가 아닙니다</div>
          </div>
        <div class="row">
        	<label class="form-label w-100 mb-10">주소</label><br>
    		<input type="text" name="memberPost" class="form-input medium light" required placeholder="우편번호" readonly>
    		<button type="button" class="form-btn neutral find-address-btn medium light">검색</button>
        </div>
        <div class="row">
            <input type="text" name="memberBasicAddr" class="form-input w-100 medium light" required placeholder="기본주소" readonly>
        </div>
        <div class="row">
            <input type="text" name="memberDetailAddr" class="form-input w-100 medium light" required placeholder="상세주소" >
            <div class="invalid-message">주소를 작성해주세요</div>
        </div>
        <div class="checkbox_group">
        <div class="row">
  <input type="checkbox" id="check_all">
  <label for="check_all">MYFORMULA 이용약관, 개인정보 수집 및 이용, 프로모션 정보 수신(선택)에 모두 동의합니다.</label>
        <div class="row">
  <input type="checkbox" name="agreeTos" id="check_1" required class="normal"  value="Y">
  <label for="check_1	">(필수) 개인정보 처리방침 동의</label>
        </div>
                
        </div>
        <div class="row mt-40">
        	<textarea class=".form-input w-100" readonly>개인정보처리방침
1. 개인정보처리방침의 의의
마이포뮬러는 본 개인정보처리방침은 개인정보보호법을 기준으로 작성하되, 마이포뮬러 내에서의 이용자 개인정보 처리 현황을 최대한 알기 쉽고 상세하게 설명하기 위해 노력하였습니다.

이는 쉬운 용어를 사용한 개인정보처리방침 작성 원칙인 ‘Plain Language Privacy Policy(쉬운 용어를 사용한 개인정보처리방침)’를 도입한 것입니다.

개인정보처리방침은 다음과 같은 중요한 의미를 가지고 있습니다.
마이포뮬러가 어떤 정보를 수집하고, 수집한 정보를 어떻게 사용하며, 필요에 따라 누구와 이를 공유(‘위탁 또는 제공’)하며, 이용목적을 달성한 정보를 언제·어떻게 파기하는지 등 ‘개인정보의 한살이’와 관련한 정보를 투명하게 제공합니다.
정보주체로서 이용자는 자신의 개인정보에 대해 어떤 권리를 가지고 있으며, 이를 어떤 방법과 절차로 행사할 수 있는지를 알려드립니다.
개인정보 침해사고가 발생하는 경우, 추가적인 피해를 예방하고 이미 발생한 피해를 복구하기 위해 누구에게 연락하여 어떤 도움을 받을 수 있는지 알려드립니다.
그 무엇보다도, 개인정보와 관련하여 마이포뮬러와 이용자간의 권리 및 의무 관계를 규정하여 이용자의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.

2. 수집하는 개인정보
이용자는 회원가입을 하지 않을 시 전체 서비스 이용이 불가능합니다.
마이포뮬러는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
마이포뮬러 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.
이용자 동의 후 개인정보를 추가 수집하는 경우‘개인정보 이용내역(내 정보)’ 확인하기
서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 위치정보가 생성되어 수집될 수 있습니다.

구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나, 2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 
서비스 이용 과정에서 위치정보가 수집될 수 있으며, 마이포뮬러에서 제공하는 위치기반 서비스에 대해서는 '마이포뮬러 위치정보 이용약관'에서 자세하게 규정하고 있습니다. 이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 개인정보에 해당하지 않을 수도 있습니다.

마이포뮬러는 아래의 방법을 통해 개인정보를 수집합니다.

회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우, 해당 개인정보를 수집합니다.
고객센터를 통한 상담 과정에서 웹페이지, 메일, 팩스, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.
마이포뮬러와 제휴한 외부 기업이나 단체로부터 개인정보를 제공받을 수 있으며, 이러한 경우에는 개인정보보호법에 따라 제휴사에서 이용자에게 개인정보 제공 동의 등을 받은 후에 마이포뮬러에 제공합니다.
기기정보와 같은 생성정보는 PC웹, 모바일 웹/앱 이용 과정에서 자동으로 생성되어 수집될 수 있습니다.
3. 수집한 개인정보의 이용
마이포뮬러 및 마이포뮬러 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발·제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.

회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.
콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.
법령 및 마이포뮬러 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.
유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 서비스의 이용을 위하여 개인정보를 이용합니다.
이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.
서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.
보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.

4. 개인정보의 제공 및 위탁
마이포뮬러는 원칙적으로 이용자 동의 없이 개인정보를 외부에 제공하지 않습니다.
마이포뮬러는 이용자의 사전 동의 없이 개인정보를 외부에 제공하지 않습니다.
단, 이용자가 외부 제휴사의 서비스를 이용하기 위하여 개인정보 제공에 직접 동의를 한 경우, 그리고 관련 법령에 의거해 마이포뮬러에 개인정보 제출 의무가 발생한 경우, 이용자의 생명이나 안전에 급박한 위험이 확인되어 이를 해소하기 위한 경우에 한하여 개인정보를 제공하고 있습니다.

5. 개인정보의 파기
회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.
단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.


회원탈퇴, 서비스 종료, 이용자에게 동의받은 개인정보 보유기간의 도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기하고 있습니다.
법령에서 보존의무를 부과한 정보에 대해서도 해당 기간 경과 후 지체없이 재생이 불가능한 방법으로 파기합니다.</textarea>
        </div>

        <div class="row">
  <input type="checkbox" name="agreePrivacy" id="check_2" required class="normal"  value="Y">
  <label for="check_2">(필수) 서비스 이용약관 동의</label>
        </div>

        <div class="row mt-40">
            <textarea class=".form-input w-100" readonly>제 1 조 (목적 및 정의)
주식회사 마이포뮬러(이하 ‘회사’)가 제공하는 서비스를 이용해 주셔서 감사합니다. 회사는 여러분이 회사가 제공하는 다양한 인터넷과 모바일 서비스(마이포뮬러 서비스, 마이포뮬러 서비스 등을 의미하며 이하 해당 서비스들을 모두 합하여 “통합서비스” 또는 “서비스”라 함)에 더 가깝고 편리하게 다가갈 수 있도록 ‘마이포뮬러 통합서비스약관’(이하 ‘본 약관’)을 마련하였습니다. 여러분은 본 약관에 동의함으로써 통합서비스에 가입하여 통합서비스를 이용할 수 있습니다. 단, 여러분은 회사가 아닌 계열사를 포함한 제3자가 제공하는 서비스 (예: ㈜마이포뮬러모빌리티가 제공하는 마이포뮬러 T 택시 서비스)에 가입되지는 않으며, 회사가 제공하는 유료서비스의 경우 여러분이 별도의 유료이용약관에 대한 동의한 때에 회사와 여러분 간의 유료서비스 이용계약이 성립합니다. 본 약관은 여러분이 통합서비스를 이용하는 데 필요한 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정하고 있으므로 조금만 시간을 내서 주의 깊게 읽어주시기 바랍니다.

마이포뮬러 서비스: 회사가 제공하는 1) “마이포뮬러” 브랜드를 사용하는 서비스(예:마이포뮬러톡) 또는 2) 마이포뮬러계정으로 이용하는 서비스(마이포뮬러 서비스는 제외, 예: 브런치) (단, 서비스 명칭에 ‘마이포뮬러’가 사용되더라도 회사가 아닌 마이포뮬러 계열사에서 제공하는 서비스 (예: 마이포뮬러 T택시 서비스)는 본 약관의 마이포뮬러 서비스에 포함되지 않습니다)
마이포뮬러 서비스: 회사가 제공하는 마이포뮬러 브랜드를 사용하는 서비스(예: 마이포뮬러 포털 서비스)
개별 서비스: 통합서비스를 구성하는 마이포뮬러 서비스, 마이포뮬러 서비스 등 브랜드 단위의 서비스를 각 의미함
세부 하위 서비스: 개별 서비스를 구성하는 개별 서비스 내의 세부 하위 서비스를 의미하며, 예를 들어 각 개별 서비스 내의 유료서비스, 마이포뮬러 서비스 내의 마이포뮬러톡 서비스, 마이포뮬러 서비스 내의 카페, 메일 등 서비스 등을 의미함
제 2 조 (약관의 효력 및 변경)
①본 약관의 내용은 통합서비스의 화면에 게시하거나 기타의 방법으로 공지하고, 본 약관에 동의한 여러분 모두에게 그 효력이 발생합니다.
②회사는 필요한 경우 관련 법령을 위배하지 않는 범위 내에서 본 약관을 변경할 수 있습니다. 본 약관이 변경되는 경우 회사는 변경사항을 시행일자 15일 전부터 여러분에게 서비스 공지사항에서 공지 또는 통지하는 것을 원칙으로 하며, 피치 못하게 여러분에게 불리한 내용으로 변경할 경우에는 그 시행일자 30일 전부터 마이포뮬러계정에 등록된 이메일 주소로 이메일(이메일주소가 없는 경우 서비스 내 전자쪽지 발송, 서비스 내 알림 메시지를 띄우는 등의 별도의 전자적 수단) 발송 또는 여러분이 등록한 휴대폰번호로 마이포뮬러톡 메시지 또는 문자메시지 발송하는 방법 등으로 개별적으로 알려 드리겠습니다.
③회사가 전 항에 따라 공지 또는 통지를 하면서 공지 또는 통지일로부터 개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도 여러분의 의사표시가 없는 경우에는 변경된 약관을 승인한 것으로 봅니다.
④여러분은 변경된 약관에 대하여 거부의사를 표시함으로써 이용계약의 해지를 선택할 수 있습니다.
⑤본 약관은 여러분이 본 약관에 동의한 날로부터 본 약관 제13조에 따른 이용계약의 해지 시까지 적용하는 것을 원칙으로 합니다. 단, 본 약관의 일부 조항은 이용계약의 해지 후에도 유효하게 적용될 수 있습니다
제 3 조 (약관 외 준칙)
본 약관에 규정되지 않은 사항에 대해서는 관련 법령 또는 통합서비스를 구성하는 개별 서비스의 운영정책 및 규칙, 개별 서비스 내 세부 하위서비스의 이용약관, 마이포뮬러 운영정책 및 규칙 등(이하 총칭하여 ‘세부지침’)의 규정에 따릅니다. 또한 본 약관과 세부지침의 내용이 충돌할 경우 세부지침에 따릅니다.</textarea> 
        </div>

        <div class="row">
  <input type="checkbox" name="agreePromotion" id="check_3" class="normal"  value="Y">
  <label for="check_3">(선택) 마케팅 수신 동의</label>
        </div>

        <div class="row mt-40">
     마이포뮬러에서 제공하는 이벤트/혜택 등 다양한 정보를 휴대전화(마이포뮬러앱 알림 또는 문자), 이메일로 받아보실 수 있습니다. 일부 서비스(별도 회원 체계로 운영하거나 마이포뮬러 가입 이후 추가 가입하여 이용하는 서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를 받습니다.
        </div>


        <div class="row">
            <button type="submit" class="form-btn positive w-100 medium next-btn">회원 가입</button>
        </div>
    </div>
    </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>