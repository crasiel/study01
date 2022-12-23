package kr.board.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import kr.board.entity.AuthVO;
import kr.board.entity.Member;

@Mapper		// - Mybatis API
public interface MemberMapper {

	public Member memRegisterCheck(String memId);	// 아이디 중복확인ㄴ

	public int register(Member m) throws Exception;	// 회원등록 성공 1, 실패 0

	public Member memLogin(Member m);	// 로그인

	public int memUpdate(Member m);		// 회원정보 수정
	
	public void memImageUpdate(Member m);

	public Member getMember(String memId);

	public void authInsert(AuthVO saveVO);

	public void authDelete(String memId);
}
