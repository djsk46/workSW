package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import ino.web.freeBoard.Dao.FreeBoardDao;
import ino.web.freeBoard.common.util.PagingUtil;

@Service
public class FreeBoardServiceImpl implements IFreeBoardService {

	@Autowired
	FreeBoardDao freeBoardDao;
	
	@Override
	public int freeBoardInsertPro(HashMap<String, Object> map, HttpServletRequest req) {
		System.out.println("글쓰기 서비스");
		String id=(String) req.getSession().getAttribute("user_id");
		int result=0;
//		int rs=0;
		map.put("reg_user",id);
		map.put("num1","0");
		try{		
		 result=freeBoardDao.freeBoardInsertPro(map);
		 System.out.println("result : "+result);
		 
	/*   int num=freeBoardDao.freeBoardHistoryMaxNum();
		 map.put("num", num);
		 rs=freeBoardDao.freeBoardHistoryUp(map);
		 result=1; */
		
		}catch (Exception e) {
			result= 0;
		}
		return result;
	}
	
	
	@Override
	public int getNewNum(){
		return freeBoardDao.getNewNum();
	}
	
	
	@Override
	public HashMap<String, Object> getDetailByNum(int num) {
		return freeBoardDao.getDetailByNum(num);
	}
	
	
	@Override
	public int freeBoardModify(HashMap<String, Object> map, HttpServletRequest req) {
//		int rs=0;
		int result=0;
		String id=(String) req.getSession().getAttribute("user_id");
		map.put("reg_user",id);
		result=freeBoardDao.freeBoardModify(map);
//		int num=freeBoardDao.freeBoardHistoryMaxNum();
//		 map.put("num", num);
//		 
//		 rs=freeBoardDao.freeBoardHistoryUp(map);
		return result;
	}
	
	
	@Override
	public int freeBoardDelete(int num, HttpServletRequest req) {
//		int rs=0;
		int result=0;
		String id=(String) req.getSession().getAttribute("user_id");
		HashMap<String,Object> map = new HashMap<String,Object>();
		 map.put("reg_user",id);
		 map.put("num",num);
		result=freeBoardDao.freeBoardDelete(map);
//		int maxNum=freeBoardDao.freeBoardHistoryMaxNum();
//		 map.put("num", maxNum);
//		 rs=freeBoardDao.freeBoardHistoryUp(map);
		return result;
	}
	
	
	@Override
	public int selectCount(HashMap<String, Object> map) {
		return freeBoardDao.selectCount(map);
	}
	
	
	@Override
	public HashMap<String, Object> freeBoardList(HashMap<String, Object> map) {
		System.out.println("메인 비즈니스 로직");
		System.out.println("map : "+map);
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		int count=(int) map.get("count");
		int curPage=(int) map.get("curPage");
		System.out.println("count : "+count);
		System.out.println("curPage : "+curPage);
		PagingUtil pageUt= new PagingUtil(count, curPage);
		map.put("start", pageUt.getPageBegin());
		map.put("end", pageUt.getPageEnd());	
		
		List<HashMap<String, Object>> list =freeBoardDao.freeBoardList(map);
		String json=new Gson().toJson(list);
		resultMap.put("list",json);
		resultMap.put("pageUt",pageUt);
		return resultMap;
	
		
	}


	




	
		

}
