package kr.board.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.Board;

@Mapper //- mybatis API
public interface BoardMapper {

	public List<Board> getList();			// 전체 리스트
	public void register(Board board);
	public Board boardContent(int idx);
	public void boardInsert(Board vo);
	public void boardDelete(int idx);
	public void boardUpdate(Board vo);
	
	@Update("update board set count = count+1 where idx=#{idx}")
	public void boardCount(int idx);		// 조회수 증가
}
