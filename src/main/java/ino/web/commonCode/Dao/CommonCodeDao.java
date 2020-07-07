package ino.web.commonCode.Dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommonCodeDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<HashMap<String, Object>> selectCommonCodeList2(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("selectCommonCodeList2",map);
	}

	public List<HashMap<String, Object>> selectCommonCodeList() {
		
		return sqlSessionTemplate.selectList("selectCommonCodeList");
	}

	public List<HashMap<String, Object>> selectCommonCodeDetailList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("selectCommonCodeDetailList",map);
	}

	public int insertDcode(HashMap<String, String> hashMap) {
		return sqlSessionTemplate.insert("insertDcode",hashMap);
	}

	public int checkAjax(String[] dcode) {
		return sqlSessionTemplate.selectOne("checkAjax",dcode);
	}

	public int modifyDcode(HashMap<String, String> hashMap) {
		return sqlSessionTemplate.update("modifyDcode",hashMap);
		
	}

	public int deleteDcode(HashMap<String, String> hashMap) {
		return sqlSessionTemplate.delete("deleteDcode",hashMap);
	}

}
