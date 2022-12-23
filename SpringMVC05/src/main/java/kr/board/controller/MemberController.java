package kr.board.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.AuthVO;
import kr.board.entity.Member;
import kr.board.mapper.MemberMapper;

@Controller
public class MemberController {
	
	@Autowired private MemberMapper mapper; 
	
	@Autowired PasswordEncoder pwEncoder;
	
	@RequestMapping("/memJoin.do")
	public String memJoin() {
		return "/member/join";		// join.jsp
	}
	
	@RequestMapping("/memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(@RequestParam("memId") String memId) {
		Member m = mapper.memRegisterCheck(memId);
		if(m != null || memId.equals("")) {
			return 0;		// 이미 존재하는 회원, 입력불가
		}
		return 1;			// 사용 가능한 아이디
	}
	
	// 회원 가입
	@RequestMapping("/memRegister.do")
	public String memRegister(Member m, String memPassword1, String memPassword2,
			RedirectAttributes rttr, HttpSession session) {		// RedirectAttributes 에 객체 바인딩
		if(m.getMemId() == null || m.getMemId().equals("") || 
			memPassword1 == null ||	memPassword1.equals("")|| 
			memPassword2 == null ||	memPassword2.equals("")||
			m.getMemAge() == 0 ||  m.getAuthList() == null ||
			m.getMemName() == null || m.getMemName().equals("") ||
			m.getMemGender()==null || m.getMemGender().equals("") ||
			m.getMemEmail() == null || m.getMemEmail().equals("")	
			) {
			// 누락메시지를 가지고 가기? = 객체 바인딩X,
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			return "redirect:/memJoin.do";		// ${msgType}, ${msg}
		}
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			return "redirect:/memJoin.do";	
		}
		m.setMemProfile(""); // 사진이미지는 없다는 의미 ""
		
		// 회원 테이블에 저장하기
		try {
			// 추가 : 비밀번호를 암호화 하기(API - SecurityConfig.java -> 메소드 추가함)
			String encyptPw = pwEncoder.encode(m.getMemPassword());
			m.setMemPassword(encyptPw);
			
			int cnt = mapper.register(m);
			
			if(cnt == 1) {		// 회원가입 성공 메시지 -> 회원 권한 추가
				// 권한 테이블에 회원의 권한 저장
				List<AuthVO> list = m.getAuthList();
				for(AuthVO auth:list) {
					if(auth.getAuth()!= null) {
						AuthVO saveVO = new AuthVO();
						saveVO.setMemId(m.getMemId());	// 회원 아이디
						saveVO.setAuth(auth.getAuth());	// 회원의 권한
						mapper.authInsert(saveVO);
					}
				}
				System.out.println("가입은 성공");
				rttr.addFlashAttribute("msgType", "성공 메시지");
				rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
				// 회원가입이 성공하면 => 로그인 처리하기
				// getMember() -> 회원 정보 + 권한정보
				Member mvo = mapper.getMember(m.getMemId());
				System.out.println(mvo);
				session.setAttribute("mvo", mvo); 	// ${!empty m} 체크해보기
				return "redirect:/";
			}else {
				rttr.addFlashAttribute("msgType", "실패 메시지");
				rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다.");
			}
		} catch (Exception e) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "중복된 아이디 입니다.");
		}
		return "redirect:/memJoin.do";
		
		
	}
	
	// 로그아웃
	@RequestMapping("/memLogout.do")
	public String memLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 로그인 화면 이동
	@RequestMapping("/memLoginForm.do")
	public String memLoginForm() {
		return "member/memLoginForm";
	}
	
	@RequestMapping("/memLogin.do")
	public String memLogin(Member m, RedirectAttributes rttr,HttpSession session) {
		// 입력값 누락시 처리
		if(m.getMemId() == null || m.getMemId().equals("") || m.getMemPassword() == null || m.getMemPassword().equals("")) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "입력을 올바르게 해주세요.");
			return "redirect:/memLoginForm.do";
		}
		
		Member mvo = mapper.memLogin(m);	// memId로만 먼저 검색해서 대상을 가져온다.
		// 추가 :  비밀번호 일치여부 체크 (입력값과 mvo에서 가져온 패스워드 비교)
		if(mvo != null && pwEncoder.matches(m.getMemPassword(), mvo.getMemPassword())) {	// 로그인 성공
			rttr.addFlashAttribute("msgType", "성공 메시지");
			rttr.addFlashAttribute("msg", mvo.getMemId() + "님 로그인 했습니다.");
			session.setAttribute("mvo", mvo);
			return "redirect:/";
		}else {				// 로그인 실패
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "아이디, 비밀번호를 확인해주세요.");
			return "redirect:/memLoginForm.do";
		}
	}
	
	// 회원 정보 수정
	@RequestMapping("/memUpdateForm.do")
	public String memUpdateForm() {
		return "member/memUpdateForm";
	}
	
	@RequestMapping("/memUpdate.do")
	public String memUpdate(Member m, String memPassword1, String memPassword2, RedirectAttributes rttr, HttpSession session) {
		if(m.getMemId() == null || m.getMemId().equals("") || 
				memPassword1 == null ||	memPassword1.equals("")|| 
				memPassword2 == null ||	memPassword2.equals("")||
				m.getMemAge() == 0 || m.getAuthList() == null ||
				m.getMemName() == null || m.getMemName().equals("") ||
				m.getMemGender()==null || m.getMemGender().equals("") ||
				m.getMemEmail() == null || m.getMemEmail().equals("")	
				) {
				// 누락메시지를 가지고 가기? = 객체 바인딩X,
				rttr.addFlashAttribute("msgType", "실패 메시지");
				rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
				return "redirect:/memUpdateForm.do";		// ${msgType}, ${msg}
		}
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			return "redirect:/memUpdateForm.do";	
		}
		
		// 회원 수정 저장하기, 추가 : 비밀번호 암호화
		try {
			String encyptPw = pwEncoder.encode(m.getMemPassword());
			m.setMemPassword(encyptPw);
			int cnt = mapper.memUpdate(m);
			if(cnt == 1) {		// 회원가입 성공 메시지
				// 기존 권한을 삭제하고 
				mapper.authDelete(m.getMemId());
				
				// 새로운 권한을 추가하기
				List<AuthVO> list = m.getAuthList();
				for(AuthVO auth:list) {
					if(auth.getAuth()!= null) {
						AuthVO saveVO = new AuthVO();
						saveVO.setMemId(m.getMemId());	// 회원 아이디
						saveVO.setAuth(auth.getAuth());	// 회원의 권한
						mapper.authInsert(saveVO);
					}
				}
				rttr.addFlashAttribute("msgType", "성공 메시지");
				rttr.addFlashAttribute("msg", "회원정보수정에 성공했습니다.");
				// 회원정보수정 성공하면 => 로그인 처리하기
				Member mvo = mapper.getMember(m.getMemId());
				session.setAttribute("mvo", mvo); 	// ${!empty m} 체크해보기
			}
		} catch (Exception e) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "회원정보수정에 실패했습니다.");
			return "redirect:/memUpdateForm.do";
		}
		return "redirect:/";
	}

	// 회원 사진 등록 폼
	@RequestMapping("/memImageForm.do")
	public String memImageForm() {
		return "member/memImageForm";
	}
	
	// 회원사진 이미지 업로드(upload, DB저장)
	@RequestMapping("/memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) {
		// 파일 업로드 API(3가지 중 하나인 cos.jar(고전방식) )
		MultipartRequest multi = null;
		int fileMaxSize = 10*1024*1024;	// 10MB
		String savePath = request.getRealPath("resources/upload");		// 업로드할 실제 경로
		try {
			// 이미지 업로드
			// DefaultFileRenamePolicy - 업로드시 같은 이름의 파일이 있을 경우 자동으로 다른 이름 부여(rename)
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());		
		} catch (Exception e) {
			// 톰캣 서버 용량제한으로 return처리 안될 경우가 생김(원하는 작동 안됨) => 톰캣 servers폴더 > server.xml에     maxSwallowSize="-1" 추가해주기
			// <Connector connectionTimeout="20000" port="8085" protocol="HTTP/1.1" maxSwallowSize="-1" redirectPort="8443"/>
			e.printStackTrace();
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");
			return "redirect:/memImageForm.do";
		}
		// 데이터베이스 테이블에 회원 이미지 업데이트
		String memId = multi.getParameter("memId");
		String newProfile = "";
		File file = multi.getFile("memProfile");	// 서버측 upload 폴더에 올려진 파일명 가져옴 .metadata 폴더
		if(file != null) {	// 업로드가 된 상태(.png, .jpg, .gif)
			// 이미지 파일 여부 체크 -> 이미지 파일이 아니면 삭제(1.png)
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase(); 	// 확장자를 대문자로 통일해서 비교, PNG GIF JPG
			if(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
				// 새로 업로드된 이미지(new -> 1.PNG), 현재 DB에 있는 이미지(old -> 4.PNG)
				String oldProfile = mapper.getMember(memId).getMemProfile();
				File oldFile = new File(savePath + "/" + oldProfile);		// 예전에 저장한 파일이 있는지
				if(oldFile.exists()) {
					oldFile.delete();
				}
				newProfile = file.getName();
			}else {	//이미지 파일이 아니면 파일 삭제 후 오류 처리메시지
				if(file.exists()) {
					file.delete();		// 삭제
				}
				rttr.addFlashAttribute("msgType", "실패 메시지");
				rttr.addFlashAttribute("msg", "이미지 파일만 업로드 가능합니다.(png, gif, jpg)");
				return "redirect:/memImageForm.do";
			}
		}
		// 새로운 이미지를 DB에 update
		Member mvo = new Member();
		mvo.setMemId(memId);
		mvo.setMemProfile(newProfile);
		mapper.memImageUpdate(mvo);			// 이미지 업데이트 성공
		//	변경된 정보를 다시 불러오기
		mvo = mapper.getMember(memId);
		session.setAttribute("mvo", mvo);		// 세션을 새롭게 생성
		rttr.addFlashAttribute("msgType", "성공 메시지");
		rttr.addFlashAttribute("msg", "이미지 변경이 성공했습니다.");
		return "redirect:/";
	}
	
	
}
