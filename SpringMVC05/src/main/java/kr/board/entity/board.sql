-- 스프링 Security(회원 테이블)  member_idx : 프로그램에서 숫자 증가,   mem_password : 암호화, board는 기존 테이블 그대로 사용 --
create table member_tbl(
	memIdx int not null,	
	memId varchar(20) not null,
	memPassword varchar(70) not null,	
	memName varchar(20) not null,
	memAge int,
	memGender varchar(20),
	memEmail varchar(50),
	memProfile varchar(50),
	primary key(memId)
);

-- 사용자 권한 테이블 --
create table member_auth(
	no int not null auto_increment,
	memId varchar(50) not null,
	auth varchar(50) not null,
	primary key(no),
	constraint fk_member_auth foreign key(memId) references member_tbl(memId)
);


select * from member_tbl order by memIdx;

select * from member_auth order by no;

select * from board order by idx desc;


select * from member_tbl join member_auth where member_tbl.memId='admin';










