package kr.board.entity;

import lombok.Data;

@Data
public class Member {
	private int memIdx;
	private String memId;
	private String memPassword;
	private String memName;
	private int memAge;
	private String memGender;
	private String memEmail;
	private String memProfile;
	//getter,setter는 lombok으로 자동 생성
}
