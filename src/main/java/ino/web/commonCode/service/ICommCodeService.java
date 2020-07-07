package ino.web.commonCode.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

public interface ICommCodeService {

	List<HashMap<String, Object>> selectCommonCodeList2(HashMap<String, Object> map);

	List<HashMap<String, Object>> selectCommonCodeList();

	List<HashMap<String, Object>> selectCommonCodeDetailList(HashMap<String, Object> map);
	
	String insertDcode(String[] code, String[] dcode, String[] dcode_name, String[] use_yn, String[] mUseYn, String[] mDcode_name, String[] mDcode, String[] dDcode);
	
	int checkAjax(String[] dcode);

}
