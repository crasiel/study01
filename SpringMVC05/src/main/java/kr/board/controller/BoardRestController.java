package kr.board.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@RequestMapping("/board")
@RestController		// AJAX 통신 때 사용하는 controller이므로 @ResponseBody(JSON)응답 어노테이션 생략 가능 
public class BoardRestController {

	@Autowired private BoardMapper mapper;
	
	@GetMapping("/all")
	public List<Board> boardList(){	
		// @ResponseBody : jackson-databind(객체->json 데이터 포멧으로 자동 변환) API, json 형식으로 변환해서 응답
		List<Board> list = mapper.getList();
		return list;		//JSON 데이터 형식으로 변환(API)해서 리턴(응답)
	}
	
	@PostMapping("/new")
	public void boardInsert(Board vo) {	// void로 리턴이 없더라도 제어권을 success로 넘겨줌
		mapper.boardInsert(vo);		// 등록
	}
	
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) {
		mapper.boardDelete(idx);
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board vo) {		// @RequestBody : json 데이터를 받아서 vo 타입으로 맵핑
		System.out.println("title : " + vo.getTitle());
		mapper.boardUpdate(vo);
	}
	
	@GetMapping("/{idx}")
	public Board boardContents(@PathVariable("idx") int idx) {
		Board vo = mapper.boardContent(idx);
		return vo;			// vo->json
	}
	
	@PutMapping("/count/{idx}")
	public Board boardCont(@PathVariable("idx") int idx) {
		mapper.boardCount(idx);
		Board vo = mapper.boardContent(idx);
		return vo;
	}
}
