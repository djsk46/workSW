package ino.web.authority.Dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AuthorityDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<HashMap<String, Object>> selectGroupList() {
		return sqlSessionTemplate.selectList("selectGroupList");
	}

	public List<HashMap<String, Object>> selectAuthorityList() {
		return sqlSessionTemplate.selectList("selectAuthorityList");
	}

	public List<HashMap<String, Object>> selectMappingList(String groupid) {
		return sqlSessionTemplate.selectList("selectMappingList",groupid);
	}

	public int insertData(List<HashMap<String, Object>> insertList) {
		System.out.println("insertData DAO");
		return sqlSessionTemplate.insert("insertData",insertList);
	}

	public int deleteData(List<HashMap<String, Object>> deleteist) {
		return sqlSessionTemplate.delete("deleteData", deleteist);
	}

	public HashMap<String, Object> selectLogin(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectOne("selectLogin",map);
	}

	public List<HashMap<String, Object>> selectMenuList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList("selectMenuList",map);
	}

}
