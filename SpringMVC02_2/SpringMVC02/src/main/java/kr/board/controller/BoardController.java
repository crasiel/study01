package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired private BoardMapper mapper;
	
	@RequestMapping({"/", ""})
	public String main() {
		return "main";
	}
	
	@RequestMapping("/boardList.do")
	public @ResponseBody List<Board> boardList(){	
		// @ResponseBody : jackson-databind(객체->json 데이터 포멧으로 자동 변환) API, json 형식으로 변환해서 응답
		List<Board> list = mapper.getList();
		return list;		//JSON 데이터 형식으로 변환(API)해서 리턴(응답)
	}
	
	@RequestMapping("/boardInsert.do")
	public @ResponseBody void boardInsert(Board vo) {	// void로 리턴이 없더라도 제어권을 success로 넘겨줌
		mapper.boardInsert(vo);		// 등록
	}
	
	@RequestMapping("/boardDelete.do")
	public @ResponseBody void boardDelete(@RequestParam("idx") int idx) {
		mapper.boardDelete(idx);
	}
	
	@RequestMapping("boardUpdate")
	public @ResponseBody void boardUpdate(Board vo) {
		mapper.boardUpdate(vo);
	}
	
	@RequestMapping("/boardContents.do")
	public @ResponseBody Board boardContents(int idx) {
		Board vo = mapper.boardContent(idx);
		return vo;			// vo->json
	}
	
	@RequestMapping("/boardCont.do")
	public @ResponseBody Board boardCont(int idx) {
		mapper.boardCount(idx);
		Board vo = mapper.boardContent(idx);
		return vo;
	}
}
