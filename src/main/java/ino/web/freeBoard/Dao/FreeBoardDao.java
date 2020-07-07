package ino.web.freeBoard.Dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeBoardDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public int freeBoardInsertPro(HashMap<String, Object> map) {
		return sqlSessionTemplate.insert("freeBoardInsertPro",map);
	}

	public int getNewNum() {
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	public HashMap<String, Object> getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int freeBoardModify(HashMap<String, Object> map){
		return sqlSessionTemplate.update("freeBoardModify", map);
	}

	public int freeBoardDelete (HashMap<String, Object> map) {
		return sqlSessionTemplate.delete("freeBoardDelete", map);	
	}

	public int selectCount(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectOne("selectCount",map);
	}

	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("freeBoardGetList",map);
	}

	public List<HashMap<String, Object>> selectCommonCodeList() {
		return sqlSessionTemplate.selectList("selectCommonCodeList");
	}

	public int freeBoardHistoryUp(HashMap<String, Object> map) {
		return sqlSessionTemplate.update("updateFreeBoardHistoryUp",map);
		
	}

	public int freeBoardHistoryMaxNum() {
		
		return sqlSessionTemplate.selectOne("selectFreeBoardHistoryMaxNum");
		
	}
	
	
}
