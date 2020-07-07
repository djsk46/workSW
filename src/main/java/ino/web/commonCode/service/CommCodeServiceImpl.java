package ino.web.commonCode.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.sun.javafx.collections.MappingChange.Map;

import ino.web.commonCode.Dao.CommonCodeDao;
@Service
public class CommCodeServiceImpl implements ICommCodeService{

	@Autowired
	CommonCodeDao commonCodeDao;
	@Autowired
	private DataSourceTransactionManager txManager;
	
	@Override
	public List<HashMap<String, Object>> selectCommonCodeList2(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list=commonCodeDao.selectCommonCodeList2(map);
		if(list!=null)
			return list;
		else
			return null; 
	}

	@Override
	public List<HashMap<String, Object>> selectCommonCodeList() {
		List<HashMap<String, Object>> list=commonCodeDao.selectCommonCodeList();
		if(list!=null)
			return list;
		else
			return null;
	}

	@Override
	public List<HashMap<String, Object>> selectCommonCodeDetailList(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list=commonCodeDao.selectCommonCodeDetailList(map);
		if(list!=null)
			return list;
		else
			return null;
	}
	
	@Override
	public String insertDcode(String[] code, String[] dcode, String[] dcode_name, String[] use_yn, String[] mUseYn, String[] mDcode_name, String[] mDcode, String[] dDcode) {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
		
		List<HashMap<String,String>> insertList = new ArrayList<HashMap<String,String>>();
		List<HashMap<String,String>> modifyList = new ArrayList<HashMap<String,String>>();
		List<HashMap<String,String>> deleteList = new ArrayList<HashMap<String,String>>();
		int result=0;
		int modifyRs=0;
		int deleteRs=0;
		String rs="fail";

		for(int i=0;i<code.length;i++){
			HashMap<String, String> map = new HashMap<String,String>();
			map.put("CODE", code[i]);
			map.put("DCODE", dcode[i]);
			map.put("DCODE_NAME", dcode_name[i]);
			map.put("USE_YN", use_yn[i]);
			insertList.add(map);		
		}
		System.out.println(mDcode.length);
		System.out.println(mDcode_name.length);
		for(int i=0;i<mDcode.length;i++){
			HashMap<String, String> map = new HashMap<String,String>();
			map.put("MDCODE", mDcode[i]);
			map.put("MDCODE_NAME", mDcode_name[i]);
			map.put("MUSEYN", mUseYn[i]);
			modifyList.add(map);		
		}
		for(int i=0;i<dDcode.length;i++){
			HashMap<String, String> map = new HashMap<String,String>();
			map.put("DDCODE", dDcode[i]);
			deleteList.add(map);
		}
		
		
		try{
			
		for(int i=0;i<insertList.size();i++){
			 result=commonCodeDao.insertDcode(insertList.get(i));
		}// for end
		
		for(int i=0;i<modifyList.size();i++){
			modifyRs=commonCodeDao.modifyDcode(modifyList.get(i));
		}// for end
		
		for(int i=0;i<deleteList.size();i++){
			deleteRs=commonCodeDao.deleteDcode(deleteList.get(i));
		}// for end
		
		if(result!=0 || modifyRs!=0 || deleteRs!=0)
			 rs= "success";
		 else
			 rs= "fail";
		txManager.commit(status);
		
		}catch (Exception e) {
			System.out.println("Exception : " +e);
			txManager.rollback(status);
//			throw new Exception(); // Spring에 던져준다
		}
		
		return rs;
		
	}

	@Override
	public int checkAjax(String[] dcode) {
		List<HashMap<String,String>> checkList = new ArrayList<HashMap<String,String>>();
		int result=0;
		System.out.println("-------");
		for (int i = 0; i < dcode.length; i++) {
            for (int j = 0; j < dcode.length; j++) {
            	if(i==j)
            		continue;
                if (dcode[i].equals(dcode[j])) {  // 중복검사
                    System.out.println("중복되는 수 입니다 다시입력하세요.  ( 중복숫자 " + dcode[j] + ")");
                    return 1;
                }
                
            }
        }

			 result=commonCodeDao.checkAjax(dcode);	
			 if(result!=0)
				 return result;
			 else
				 return 0;
	}


}
