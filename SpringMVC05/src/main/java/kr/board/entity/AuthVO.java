package kr.board.entity;

import lombok.Data;

@Data
public class AuthVO {
	private int no;			// 일련번호
	private String memId;	// 회원아이디
	private String auth;	// 회원권한(3가지 부여 : ROLE_USER, ROLE_MANAGER, ROLE_ADMIN)
}
