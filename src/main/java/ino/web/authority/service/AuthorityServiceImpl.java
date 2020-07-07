package ino.web.authority.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.google.gson.Gson;

import ino.web.authority.Dao.AuthorityDao;

@Service
public class AuthorityServiceImpl implements IAuthorityService{

	@Autowired
	AuthorityDao AuthorityDao;
	@Autowired
	private DataSourceTransactionManager txManager;

	@Override
	public String groupList() {
		List<HashMap<String, Object>> list=AuthorityDao.selectGroupList();
		String json=new Gson().toJson(list);
		return json;
	}

	@Override
	public List<HashMap<String, Object>> authorityList() {

		return AuthorityDao.selectAuthorityList();
	}

	@Override
	public List<HashMap<String, Object>> mappingList(String groupid) {
		return AuthorityDao.selectMappingList(groupid);
	}

	@Override
	public String authoritySave(HashMap<String, Object> map) {
		//트랜잭션
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);  
		String rs="fail";
		int insetRs=0;
		int deleteRs=0;
		System.out.println(map.get("insertData"));
		System.out.println(map.get("deleteData"));
		List<HashMap<String, Object>> insertList=(List<HashMap<String, Object>>) map.get("insertData");
		List<HashMap<String, Object>> deleteist=(List<HashMap<String, Object>>) map.get("deleteData");
		
		try{
		if(insertList.size()>0){	
		 insetRs=AuthorityDao.insertData(insertList);
		System.out.println("insetRs : "+insetRs);
		}
		if(deleteist.size()>0){
		 deleteRs=AuthorityDao.deleteData(deleteist);
		}
		if(insetRs!=0 ||deleteRs!=0 ){		
			 rs= "success";
			 txManager.commit(status);
		}
	
		}catch (Exception e) {
			rs="txfail";
			txManager.rollback(status);
		}
		return rs;
	}

	@Override
	public String login(HttpServletRequest req,HashMap<String, Object> map) {
		
		HttpSession session=req.getSession();
		String rs="fail";
		
		HashMap<String, Object> loginMap=AuthorityDao.selectLogin(map);
		
		if(loginMap.size()>0){
			session.setAttribute("user_id", map.get("user_id"));
			session.setAttribute("group_id", loginMap.get("GROUP_ID"));
			rs="success";
		}
		else
			rs="fail";
		
		System.out.println("loginMap : "+loginMap);
		System.out.println("rs : "+rs);
		return rs;
	}

	@Override
	public List<HashMap<String, Object>> menuList(HashMap<String, Object> map) {
		
		System.out.println(map.get("group_id"));
		//System.out.println(map.get("object_name"));
		List<HashMap<String, Object>> list=AuthorityDao.selectMenuList(map);
		System.out.println(list);
		
		return list;
	}




	
}
