package ino.web.authority.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface IAuthorityService {

	String groupList();

	List<HashMap<String, Object>> authorityList();

	List<HashMap<String, Object>> mappingList(String groupid);

	String authoritySave(HashMap<String, Object> map);

	String login(HttpServletRequest req, HashMap<String, Object> map);

	List<HashMap<String, Object>> menuList(HashMap<String, Object> map);

}
