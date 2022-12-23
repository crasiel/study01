package kr.board.entity;

import java.util.List;

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
	private List<AuthVO> authList;		
	//AuthVO의 auth에 자동으로 값 입력 - authList[0].auth, authList[1].auth, authList[2].auth
	//getter,setter는 lombok으로 자동 생성
}
