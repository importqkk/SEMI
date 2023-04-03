SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;
--회원
CREATE TABLE  member  (
	 Member_Id 	VARCHAR2(20)	PRIMARY KEY,
	 member_name 	VARCHAR2(21)	NOT NULL,
	 member_nick 	VARCHAR2(30)	NOT NULL,
	 member_Pw 	VARCHAR2(16)	NOT NULL,
	 member_phone 	VARCHAR2(11)	NOT NULL,
	 member_email 	VARCHAR2(50)	NULL,
	 member_post 	varchar2(6)	NOT NULL,
	 member_basic_addr 	VARCHAR2(150)	NOT NULL,
	 member_detail_addr 	VARCHAR2(150)	NOT NULL,
	 member_point 	number DEFAULT 100	NOT NULL,
	 member_join 	DATE 	DEFAULT sysdate	NOT NULL,
	 member_role 	VARCHAR2(12) DEFAULT '일반회원'	NOT NULL,
	 agree_TOS 	varchar2(1)	not NULL,
     agree_privacy 	varchar2(1)	not NULL,
     agree_promotion varchar2(1)	not NULL,
     

     -- 아이디 
     -- 영문 소문자,숫자 포함 5~20글자
    check(regexp_like(member_id,'^[a-z0-9-_]{5,20}$')),
    
    -- 비번
    -- 영어 대소문자, 숫자, 특수문자 한 개씩 포함한 8~16글자
    check(
    regexp_like(member_pw, '[A-Z]+')    
    and
    regexp_like(member_pw, '[a-z]+')
    and
    regexp_like(member_pw, '[0-9]+')
    and
    regexp_like(member_pw, '[!@#$]+')
    and
    regexp_like(member_pw, '^[A-Za-z0-9!@#$]{8,16}$')
    ),
    
    -- 이름 
    -- 성, 이름 포함 한글 2글자 이상 7글자 이하
    check(regexp_like(member_name,'^[가-힣]{2,7}$')),
    
    -- 닉네임 
    -- 한글, 숫자 2~10글자
    check(regexp_like(member_nick, '^[가-힣0-9]{2,10}$')),
    
    -- 전화번호
    check (REGEXP_LIKE(member_phone,'^01[016789][1-9][0-9]{6,7}$')),
    
    -- 이메일
    -- '@'포함
    check(instr(member_email, '@') > 0),
    
    -- 우편번호
    -- 숫자 5~6자리
    check(regexp_like(member_post, '^[0-9]{5,6}$')),
    
    
    -- 포인트
    -- 0점 이상
    check(member_point >= 0),
    
    -- 회원권한
    -- 일반 혹은 관리자
    check(member_role in ('일반회원','관리자')),
 
 
    --이용약관 마케팅 동의
    -- boolean  0 또는 1 
     check (agree_TOS in('Y','N')), --필수동의 Y만
     check (agree_privacy in('Y','N')), --필수동의 Y만
     check (agree_promotion  in('Y','N')) --선택동의
);


--주문
CREATE TABLE  order_  (
	 order_no 	number	PRIMARY KEY	 ,
	 order_receiver 	varchar2(21)	NOT NULL,
     order_post varchar2(6) not null,
	 order_basic_addr 	VARCHAR2(150)	NOT NULL,
	 order_detail_addr 	VARCHAR2(150)	NOT NULL,
	 order_receiver_phone 	varchar2(11)	NOT NULL,
	 order_date 	DATE 	DEFAULT sysdate	NOT NULL,
	 order_request 	varchar2(300),
	 order_userPoint number DEFAULT 0,
	 order_stat varchar2(21) DEFAULT '결제완료' not null,
     	member_Id 	REFERENCES member(member_id) on delete cascade,
    
    --수령인 이름
    -- 성, 이름 포함 한글 2글자 이상 7글자 이하
    check(regexp_like(order_receiver,'^[가-힣]{2,7}$')),
    
    -- 수령인 우편번호
    check(regexp_like(order_post, '^[0-9]{5,6}$')),
    
    -- 수령인 상세주소
    check(regexp_like(order_detail_addr,'^[가-힣\s-0-9]{2,50}$')),
    
    -- 수령인 폰번호
    check (REGEXP_LIKE(order_receiver_phone,'^01[016789][1-9][0-9]{6,7}$')),
    check(order_userPoint >=0 ),
    check(order_stat in('결제완료','배송준비중','배송중','배송완료'))
    
	 
);



--상품
CREATE TABLE  Product  (
	 product_no 	number	PRIMARY KEY	 ,
	 product_name 	varchar2(99)	NOT NULL,
	 product_brand	varchar2(30) 	NOT NULL,
	 product_price 	number	NOT NULL,
	 product_stock 	number 	DEFAULT 0	NOT NULL,
	 product_content 	varchar2(3000)	NOT NULL,
	 product_delivery_price 	number 	DEFAULT 3000	NOT NULL,
	 product_sell_count 	number 	DEFAULT 0	NOT NULL,
	 product_join 	date 	DEFAULT sysdate	NOT NULL,
     
    -- 상품이름
    -- 한글, 영어, 숫자, -,_ 기호 포함 1~33글자
    check(regexp_like(product_name,'^[a-z0-9가-힣-!@#$%^&*]{1,33}$')),
    
    -- 상품 가격 0원 이상
    check(product_price >=0),
    
    -- 상품 재고 0개 이상
    check(product_stock >=0),
    
    -- 상품 배달비 0원 이상
    check (product_delivery_price>=0),
    
    -- 상품 판매 수량 0개 이상
    check(product_sell_count >=0)
);




--리뷰
CREATE TABLE  Review  (
	 review_no 	number	PRIMARY KEY	 ,
	 review_content 	VARCHAR2(3000)	NOT NULL,
	 review_star 	number 	DEFAULT 0	NOT NULL,
	 review_time 	date 	DEFAULT sysdate	NOT NULL,
	 review_like 	number 	DEFAULT 0	NOT NULL,
     	product_no 	REFERENCES  product(product_no) on delete CASCADE,
     	member_Id REFERENCES member(member_id) on delete CASCADE,
     
     -- 리뷰 별점
     --0 ~ 5점
     check(review_star BETWEEN 0 and 5),
     
     -- 리뷰 좋아요
     check (review_like >=0) 
     
);

--문의게시판
CREATE TABLE  QA  (
	 QA_no 	number	PRIMARY KEY,
	 QA_title 	varchar2(90) NOT NULL,
	 QA_content 	VARCHAR2(3000)	NOT NULL,
	 QA_answer 	VARCHAR2(3000),
	 QA_head 	VARCHAR2(12)	NOT NULL	,
	 QA_secret 	VARCHAR2(1) DEFAULT 0	NOT NULL,
     QA_group number,
	 QA_parent 	references QA(QA_no) on delete cascade,
	 QA_depth 	number 	DEFAULT 0	,
     QA_date date DEFAULT sysdate not null,
      QA_READ number default 0 not null,
     member_Id 	REFERENCES member(member_id) on delete set null,
     
     -- qa 말머리
     check (qa_head in('상품문의','결제문의','기타문의')),
     
     -- qa 비밀글
     --boolean 0 또는 1 
     check (qa_secret in ('Y','N')),
     
     -- qa 계층형 구조 
     check (QA_group>0),
     check (QA_parent>0),
     --  깊이는 없거나 1개가 최대
     check (QA_depth in (0,1))
);


BEGIN
  FOR i IN 1..60 LOOP
    INSERT INTO QA(
      QA_NO,
      QA_TITLE,
      QA_CONTENT,
      QA_ANSWER,
      QA_HEAD,
      QA_SECRET,
      QA_GROUP,
      QA_PARENT,
      QA_DEPTH,
      QA_DATE,
      QA_READ,
      MEMBER_ID
    ) VALUES (
      i, -- 글번호
      i || '번째제목',
      i || '번째질문내용', --내용
      i || '번째답변', -- 답변
      CASE ROUND(dbms_random.value(0, 2))
        WHEN 0 THEN '상품문의'
        WHEN 1 THEN '결제문의'
        ELSE '기타문의'
      END, -- 카테고리
      CASE ROUND(dbms_random.value(0, 1))
      WHEN 0 THEN 'Y'
      ELSE 'N'
      END,-- 비밀글
      ROUND(dbms_random.value(1,3)), -- 그룹
      ROUND(dbms_random.value(1,4)), --차수
      ROUND(dbms_random.value(0,1)), --깊이
      sysdate, -- 작성시간
      ROUND(dbms_random.value(0,100)), --조회수
      'testuser' || i
    );
  END LOOP;
END;




SELECT qa_seq.CURRVAL
FROM dual;

SELECT qa_seq.NEXTVAL - 1
FROM dual;

ALTER SEQUENCE qa_seq
INCREMENT BY 9;



select*from qa;

drop table qa;



--이미지파일
CREATE TABLE  img  (
	 img_no 	number	PRIMARY KEY,
	 img_name 	varchar2(100)	NOT NULL,
	 img_type 	varchar2(60)	NOT NULL,
	 img_size 	long	NOT NULL
    

         
);

--장바구니
CREATE TABLE  cart  (
     	product_no  references product(product_no) on delete cascade,
     	member_Id  REFERENCES member(member_id) on delete cascade,
	PRODUCT_COUNT number not null,
	primary key(member_id, product_no)

);

--태그/카테고리
CREATE TABLE  tag  (
	 tag_no 	number	PRIMARY KEY,
	 tag_name 	varchar2(30)	NOT NULL
);

-- 상품-주문
CREATE TABLE  order_product  (
	 product_count 	number	NOT NULL,
	 product_price 	number	NOT NULL,
     product_no 	REFERENCES product(product_no) on delete cascade,
	 order_no 	REFERENCES order_(order_no) on delete cascade,
	 primary key(product_no, order_no)
);



-- 상품-태그
CREATE TABLE  product_tag  (
	 product_no 	REFERENCES product(product_no) on delete cascade ,
	 tag_no 	REFERENCES tag(tag_no) on delete cascade,
     primary key(product_no, tag_no)
);

-- 리뷰-좋아요
CREATE TABLE  review_like  (
	 review_no 	REFERENCES	review(review_no)	on delete cascade ,
	 member_Id 	REFERENCES member(member_id) on delete cascade,
	 primary key(review_no, member_id)
);

-- 상품-이미지
CREATE TABLE  product_img  (
	 product_no 	REFERENCES product(product_no)	on delete cascade ,
	 img_no 	REFERENCES	img(img_no) on delete cascade,
	 primary key(img_no, product_no) 
);

-- 상품-상세이미지
CREATE TABLE  detail_img  (
	 product_no 	REFERENCES product(product_no) on delete cascade	 ,
	 img_no 	REFERENCES	img(img_no) on delete cascade,
     primary key(img_no,product_no)
);

-- 리뷰-이미지
CREATE TABLE  review_img  (
	 img_no 	REFERENCES	img(img_no) on delete cascade,
	 review_no 	REFERENCES	review(review_no) on delete cascade,	 
	 primary key(img_no, review_no) 
);



commit;