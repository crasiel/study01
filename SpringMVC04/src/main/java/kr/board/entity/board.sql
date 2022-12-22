select * from board order by idx desc;

insert into board(title, content, writer) value('00','11','22');

create table mem_tbl(
	memIdx int auto_increment,
	memId varchar(20) not null,
	memPassword varchar(20) not null,
	memName varchar(20) not null,
	memAge int default 0,
	memGender varchar(20),
	memEmail varchar(50),
	memProfile varchar(50),
	primary key(memIdx)
);

select * from mem_tbl order by memIdx;

alter table board modify column memId varchar(20) not null;

