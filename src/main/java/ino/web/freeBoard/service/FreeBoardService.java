package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.FreeBoardDto;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/*public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("freeBoardGetList",map);
	}*/
	
	
/*	public int freeBoardInsertPro(HashMap<String, Object> map){
		int result=sqlSessionTemplate.insert("freeBoardInsertPro",map);
		return result;
	}*/
	
/*	public HashMap<String, Object> getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}*/
	
/*	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}*/
	
/*	public int freeBoardModify(HashMap<String, Object> map){
		return sqlSessionTemplate.update("freeBoardModify", map);
	}*/

/*	public int FreeBoardDelete (int num) {
		return sqlSessionTemplate.delete("freeBoardDelete", num);	
	}*/
	
/*	public int selectCount(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectOne("selectCount",map);
	}*/

	
}
