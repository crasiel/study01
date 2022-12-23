package kr.board.entity;
import lombok.Data;

@Data 	// - Lombok API
public class Board {
	private int idx;
	private String memId;
	private String title;
	private String contents;
	private String writer;
	private String indate;
	private int count;
	//getter, setter
	
}
