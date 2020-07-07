package ino.web.freeBoard.controller;

import ino.web.commonCode.service.CommCodeService;
import ino.web.commonCode.service.CommCodeServiceImpl;
import ino.web.freeBoard.common.util.PagingUtil;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;
import ino.web.freeBoard.service.FreeBoardServiceImpl;

import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.google.gson.Gson;

@Controller
public class FreeBoardController {
	@Autowired
	private CommCodeServiceImpl iCommCodeService;
	@Autowired
	private FreeBoardServiceImpl iFreeBoardService;
	
	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest req
			               , @RequestParam(value="COM001", defaultValue="") String COM001
						   , @RequestParam(value="startDay",defaultValue="") String startDay
			               , @RequestParam(value="endDay" , defaultValue="") String endDay
			 		       , @RequestParam(value="search", defaultValue="") String search
			 		       , @RequestParam(value="show", defaultValue="") String[] show
			 			   , @RequestParam(value="curPage", defaultValue="1") int curPage) throws JsonProcessingException{
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> map = new HashMap<String,Object>();
		HttpSession session=req.getSession();
		System.out.println("session id : "+session.getAttribute("user_id"));
		String id=(String) session.getAttribute("user_id");
		
		if(id==null || id==""){
			mav.setViewName("redirect:/");
			return mav;
		}
		
		//count 구해야함
		map.put("COM001", COM001);
		map.put("search", search);
		map.put("startDay", startDay.replace("-",""));
		map.put("endDay", endDay.replace("-",""));
		int count = iFreeBoardService.selectCount(map);
		map.put("count", count);
		map.put("curPage", curPage);
		
		HashMap<String,Object> resultMap = iFreeBoardService.freeBoardList(map);
		map.put("code" , "COM001");
		map.put("mUseYs" , "Y");
		map.put("dUseYs" , "Y");
		
		List<HashMap<String,Object>> commList1 = iCommCodeService.selectCommonCodeList2(map);
		System.out.println("공통 코드(COM001) : "+commList1);
		
		map.put("code" , "COM002");
		map.put("mUseYs" , "Y");
		map.put("dUseYs" , "Y");
		List<HashMap<String,Object>> commList2 = iCommCodeService.selectCommonCodeList2(map);
		System.out.println("공통 코드(COM002) : "+commList2);
		
		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",resultMap.get("list"));
		mav.addObject("commList1",commList1);
		mav.addObject("commList2",commList2);
		mav.addObject("count",count);
		mav.addObject("pageUt",resultMap.get("pageUt"));
		
		ObjectMapper mapper=new ObjectMapper();
		String showjson=mapper.writeValueAsString(show);
		mav.addObject("show",showjson);
		String mapJson=new Gson().toJson(map);
		mav.addObject("search",mapJson);
		
		return mav;
	}
	
	@RequestMapping("/defaultPage.ino")
	public ModelAndView defaultPage(@RequestParam(value="show", defaultValue="") String[] show){
		ModelAndView mav = new ModelAndView();
		String showjson=new Gson().toJson(show);
		mav.addObject("show",showjson);
		mav.setViewName("defaultPage");
		return mav;
	}
	
	@RequestMapping("/freeBoardInsert.ino")
	public ModelAndView freeBoardInsert(@RequestParam(value="show", defaultValue="") String[] show){
		ModelAndView mav = new ModelAndView();
		String showjson=new Gson().toJson(show);
		mav.addObject("show",showjson);
		mav.setViewName("freeBoardInsert");
		return mav;
	}
	
	@RequestMapping("/freeBoardInsertPro.ino")
	@ResponseBody
	public int freeBoardInsertPro(HttpServletRequest req, @RequestParam("name") String name,
																 @RequestParam("title") String title,
																 @RequestParam("content") String content){
		HashMap<String, Object> map= new HashMap<>();
		map.put("name", name);
		map.put("title", title);
		map.put("content", content);
		System.out.println("HI");
			int result=iFreeBoardService.freeBoardInsertPro(map,req);
			System.out.println("글쓰기 result="+result);
			if(result!=0){
				int num=iFreeBoardService.getNewNum();
				System.out.println("num="+num);
				return num;
			}	
			else
				return 0;
		
	}
	
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request, int num
									  , @RequestParam(value="show", defaultValue="") String[] show){
		HashMap<String, Object> map=iFreeBoardService.getDetailByNum(num);
		ModelAndView mav = new ModelAndView();
		String showjson=new Gson().toJson(show);
		mav.addObject("show",showjson);
		mav.addObject("freeBoardMap",map);
		mav.setViewName("freeBoardDetail");
		return mav;
	}
	
	@RequestMapping("/freeBoardModify.ino")
	@ResponseBody
	public String freeBoardModify(HttpServletRequest req, @RequestParam("name") String name,
															  @RequestParam("num") String num,
			 											      @RequestParam("title") String title,
			 											      @RequestParam("regdate") String regdate,
			 												  @RequestParam("content") String content){
		HashMap<String, Object> map= new HashMap<>();
		map.put("name", name);
		map.put("num1", num);
		map.put("title", title);
		map.put("regdate", regdate);
		map.put("content", content);
		try {
			int result=iFreeBoardService.freeBoardModify(map,req);
			if(result!=0){
				return "Success";
			}
			else{
				return "fail";
			}
			
		} catch (Exception e) {
			return "fail";
		}
	}
	
		
	@RequestMapping("/freeBoardDelete.ino")
	@ResponseBody
	public String FreeBoardDelete(HttpServletRequest req,int num){
		int result=iFreeBoardService.freeBoardDelete(num,req);
		System.out.println("result="+result);
		try {
			if(result!=0){
				return "Success";
			}
			else{
				return "fail";
			}
			
		} catch (Exception e) {
			return "fail";
		}
	}
	
	
	@RequestMapping(value ="/freeBoardSearch.ino")
	@ResponseBody
	public HashMap<String, Object> FreeBoardSearch(@RequestParam("COM001") String COM001
												 , @RequestParam(value="startDay",defaultValue="") String startDay
												 , @RequestParam(value="endDay" , defaultValue="") String endDay
												 , @RequestParam("search" ) String search
											     , @RequestParam(value="curPage", defaultValue="1") int curPage){
		System.out.println(COM001+"\t"+search);
		HashMap<String, Object> map= new HashMap<>();
		map.put("COM001", COM001);
		map.put("search", search);
		map.put("startDay", startDay.replace("-",""));
		map.put("endDay", endDay.replace("-",""));
		System.out.println("현재 페이지 : "+curPage);
		int count = iFreeBoardService.selectCount(map);
		map.put("count", count);
		map.put("curPage", curPage);
		System.out.println("검색 갯수 : "+count);
			HashMap<String,Object> resultMap =iFreeBoardService.freeBoardList(map);
			map.put("pageUt", resultMap.get("pageUt"));
			map.put("list", resultMap.get("list"));
			return map;		
	}
	
}