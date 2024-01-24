commit;
drop table account;
drop table item;
drop table notice;
drop table orderhistory;
drop table orderitem;
drop table cart;
drop table pet;
drop table review;
drop table service;
drop table reply;
drop table account_auth;
drop table persistent_logins;
------------------------------------------------------------------------ACCOUNT
CREATE TABLE account (
	username    varchar2(200)	NOT NULL,-- 유저 닉네임
	password    varchar2(200)	NOT NULL,-- 유저 패스워드
	name        varchar2(200)	NOT NULL,-- 유저 이름
	tel	        varchar2(200)	NOT NULL,-- 유저 전번
	address     varchar2(200)	NOT NULL,-- 유저 주소
   	 address1     varchar2(200)	NOT NULL,-- 유저 주소
   	 address2     varchar2(200)	NOT NULL,-- 유저 주소
   	 address3     varchar2(200)	NOT NULL,-- 유저 주소
    	address4     varchar2(200)	NULL,-- 유저 주소
	status       varchar2(200)	DEFAULT 'active',
	regDate     date	        DEFAULT SYSDATE,
    CONSTRAINT account_pk PRIMARY KEY (username)
);


CREATE TABLE account_auth ( 
username NOT NULL,
auth VARCHAR2(50) NOT NULL,
CONSTRAINT account_auth_fk FOREIGN KEY(username) REFERENCES account(username)
);

CREATE TABLE persistent_logins ( 
username VARCHAR2(64) NOT NULL, 
series VARCHAR2(64) NOT NULL, 
token VARCHAR2(64) NOT NULL,
last_used DATE NOT NULL, 
PRIMARY KEY (series)
);
DELETE FROM account;
SELECT * from  account;
DROP TABLE account ;
DROP TABLE account_auth ;
DROP TABLE persistent_logins ;
---------------------------------------------------------------------------ITEM
CREATE TABLE item (
    itemNo      		number          		NOT NULL,
    itemName    	varchar2(200)   	NOT NULL,
    itemPrice    		number          		NOT NULL,
    itemStock   		number          		NOT NULL,
    itemType    		varchar2(200)   	NOT NULL,
    itemSize    		varchar2(200),
    itemRegDate 	date            		DEFAULT SYSDATE,
    itemMainPic 	varchar2(200)   	NOT NULL,
    itemSubPic 	 	varchar2(200)   	NOT NULL,
    itemDesc    		varchar2(3000),
    itemStatus		varchar2(20)		NOT NULL,
CONSTRAINT item_pk PRIMARY KEY (itemNo)
);

CREATE SEQUENCE itemNo_seq
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

DROP TABLE item;
DROP SEQUENCE itemNo_seq;
----------------------------------------------------------------------------PET
CREATE TABLE pet (
    petNo       number          NOT NULL,
    username    varchar2(200)   ,
    petName     varchar2(200)   NOT NULL,
    petAge      number          NOT NULL,
    petType     varchar2(200)   NOT NULL,
    petGender   varchar2(10)    NOT NULL,
    petDesc     varchar2(3000)  NOT NULL,
    petRegDate  date            DEFAULT SYSDATE,
    petModDate  date,
    adoptDate   date,
    petStatus   varchar2(200)   DEFAULT 'OPEN',
    petMainPic  varchar2(200)   NOT NULL,
    petSubPic   varchar2(200)   NOT NULL,
    CONSTRAINT pet_pk PRIMARY KEY (petNo),
    CONSTRAINT pet_fk FOREIGN KEY (username) REFERENCES account (username),
    CONSTRAINT petGender_ck CHECK (petGender IN('M', 'F'))
);

CREATE SEQUENCE petNo_seq
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

SELECT * FROM PET;
DELETE FROM PET WHERE PETNO='208';

DROP SEQUENCE petNo_seq;
---------------------------------------------------------------------------CART
CREATE TABLE cart (
    cartNo      		number          		NOT NULL,
    username    	varchar2(200)   	NOT NULL,
    itemNo      		number          		NOT NULL,
    itemName    	varchar2(200)  	NOT NULL,
    itemQuantity    	number          		NOT NULL,
    itemPrice       	number          		NOT NULL,
    itemSize    		varchar2(10),
    itemMainPic 	varchar2(200)   	NOT NULL,
    checkStatus 	varchar2(10)    	NOT NULL,
    CONSTRAINT cart_pk PRIMARY KEY (cartNo),
    CONSTRAINT cart_username_fk FOREIGN KEY (username) REFERENCES account (username),
    CONSTRAINT cart_itemNo_fk FOREIGN KEY (itemNo) REFERENCES item (itemNo),
    CONSTRAINT checkStatus_ck CHECK (checkStatus IN ('checked', 'unchecked'))
);
CREATE SEQUENCE cartNo_seq
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
    
DROP TABLE cart;
DROP SEQUENCE cartNo_seq;
----------------------------------------------------------------------ORDERITEM
CREATE TABLE orderItem (
    	orderHistoryNo	number	    	NOT NULL,
	itemNo	   		number	   	 NOT NULL,
	itemName		varchar2(200)		NOT NULL,
	itemQuantity		number      		NOT NULL,
	itemPrice		 number      		NOT NULL,
	itemMainPic		varchar2(200)		NOT NULL,
CONSTRAINT orderItem_orderHistory_fk FOREIGN KEY (orderHistoryNo) REFERENCES orderHistory(orderHistoryNo),    
CONSTRAINT orderItem_item_fk FOREIGN KEY (itemNo) REFERENCES item (itemNo)
);

DROP TABLE orderItem;
-------------------------------------------------------------------ORDERHISTORY
CREATE TABLE orderHistory (
	orderHistoryNo	number		NOT NULL,
	username		varchar2(200)		NOT NULL,
	totalPrice		number	   	NOT NULL,
    	address		varchar2(200)		NOT NULL,
	orderDate		date	   	     	DEFAULT SYSDATE,
    CONSTRAINT orderHistory_pk PRIMARY KEY (orderHistoryNo),
    CONSTRAINT orderHistory_fk FOREIGN KEY (username) REFERENCES account (username)
);
CREATE SEQUENCE orderHistoryNo_seq
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
    
DROP TABLE orderHistory;
DROP SEQUENCE orderHistoryNo_seq;
-------------------------------------------------------------------------REVIEW



CREATE TABLE review (
    	reviewNo	    number	        NOT NULL,
itemNo      	number,
	itemName    	varchar2(200),
	username    	varchar2(200)	NOT NULL,
	petNo       	number,
	reviewTitle 	varchar2(2000)	NOT NULL,
	reviewDesc	    varchar2(2000)	NOT NULL,
	reviewRegDate	date	        DEFAULT SYSDATE,
	reviewModDate	date,
	reviewPic	    varchar2(200),
    CONSTRAINT review_pk PRIMARY KEY (reviewNo),
    CONSTRAINT review_username_fk FOREIGN KEY (username) REFERENCES account (username)

);
CREATE SEQUENCE reviewNo_seq
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

DROP TABLE review;
DROP SEQUENCE reviewNo_seq;
------------------------------------------------------------------------SERVICE
CREATE TABLE service (
  	serviceNo	number	        NOT NULL,
	username	varchar2(200)	NOT NULL,
  	itemNo	    	number,
	petNo   	number,
	serviceDesc	varchar2(3000)	NOT NULL,
	response	varchar2(3000),
	serviceRegDate	date	        DEFAULT sysdate,
	responseRegDate	date,
	serviceType varchar2(20),
	orderNo number,
    CONSTRAINT service_pk PRIMARY KEY (serviceNo),
    CONSTRAINT service_username_fk FOREIGN KEY (username) REFERENCES account (username)
);
CREATE SEQUENCE serviceNo_seq
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

DROP TABLE service;
DROP SEQUENCE serviceNo_seq;
-------------------------------------------------------------------------NOTICE
CREATE TABLE notice (
    noticeNo	    number	        NOT NULL,
	noticeTitle	    varchar(200)	NOT NULL,
	noticeDesc	    varchar(2000)	NOT NULL,
	noticeRegDate	date	        DEFAULT sysdate,
	noticeModDate	date,
	noticeViewCount 	number 	default 0,
    CONSTRAINT notice_pk PRIMARY KEY (noticeNo)
);
CREATE SEQUENCE noticeNo_seq
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

DROP TABLE notice;
DROP SEQUENCE noticeNo_seq;
------------------------------------------------------------------------COMMENT
CREATE TABLE reply (
    replyNo   	number	        NOT NULL,
	petNo	        number,
	reviewNo    	number,
    itemNo    	number,
	username	    varchar2(200)	NOT NULL,
	reply	        varchar2(2000)	NOT NULL,
	replyRegDate	date	        DEFAULT sysdate,
	replyModDate	date,
    CONSTRAINT reply_pk PRIMARY KEY (replyNo),
    CONSTRAINT reply_username_fk FOREIGN KEY (username) REFERENCES account (username), CONSTRAINT reply_itemNo_fk FOREIGN KEY (itemNo) REFERENCES item(itemNo)
    
);
CREATE SEQUENCE replyNo_seq
    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

DROP TABLE reply;
DROP SEQUENCE replyNo_seq;
--------------------------------------------------------------------------- UPDATE TRIGGER (itemQuantity)
CREATE OR REPLACE TRIGGER before_cart_insert
BEFORE INSERT ON cart
FOR EACH ROW
DECLARE v_current_quantity NUMBER;
    v_quantity_sum NUMBER;
BEGIN
    SELECT MAX(itemQuantity) INTO v_current_quantity FROM cart
    WHERE username = :NEW.username AND itemNo = :NEW.itemNo;

    IF v_current_quantity IS NOT NULL THEN
        v_quantity_sum := v_current_quantity + :NEW.itemQuantity;

        IF v_quantity_sum <= 10 THEN
             UPDATE cart
                SET itemQuantity = v_quantity_sum
                WHERE username = :NEW.username AND itemNo = :NEW.itemNo;
        ELSE 
            RAISE_APPLICATION_ERROR(-20001, 'Quantity exceeds limit of 10');
        END IF;
    END IF;
END;
/
drop trigger before_cart_insert;
-------------------------------------------------------------------------------------------------


CREATE OR REPLACE TRIGGER after_checkout
after INSERT ON orderitem
FOR EACH ROW
DECLARE 
    v_itemquantity NUMBER;
    v_itemNo NUMBER;
BEGIN
    v_itemquantity := :New.itemQuantity;
    v_itemNo := :new.itemNo;
    
    update item set itemstock = itemstock - v_itemquantity where itemNo = v_itemNo;
END;
/