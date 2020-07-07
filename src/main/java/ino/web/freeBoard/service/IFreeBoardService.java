package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface IFreeBoardService {
	
	int getNewNum();
	HashMap<String, Object> getDetailByNum(int num);
	int selectCount(HashMap<String, Object> map);
	HashMap<String, Object> freeBoardList(HashMap<String, Object> map);
	int freeBoardInsertPro(HashMap<String, Object> map, HttpServletRequest req);
	int freeBoardModify(HashMap<String, Object> map, HttpServletRequest req);
	int freeBoardDelete(int num, HttpServletRequest req);

}
