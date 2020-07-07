package ino.web.commonCode.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import ino.web.commonCode.service.CommCodeService;
import ino.web.commonCode.service.CommCodeServiceImpl;
import ino.web.commonCode.service.ICommCodeService;
import ino.web.freeBoard.service.FreeBoardServiceImpl;

@Controller
public class CommCodeController {
	

	@Autowired
	private ICommCodeService iCommCodeService;
	
	
	@RequestMapping("/commonCode.ino")
	public ModelAndView commonCode(HttpServletRequest req
								  ,@RequestParam(value="show", defaultValue="") String[] show){
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> map = new HashMap<String,Object>();

		List<HashMap<String,Object>> list = iCommCodeService.selectCommonCodeList();
		
		//String json=new Gson().toJson(list);
		mav.addObject("list" , list);
		String showjson=new Gson().toJson(show);
		mav.addObject("show",showjson);
		mav.setViewName("commonCodeMain");
		
		return mav;
	}
	
	
	@RequestMapping("/commonCodeInsert.ino")
	public ModelAndView commonCodeInsert(HttpServletRequest req){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("commonCodeInsert");	
		return mav;
	}
	
	
	@RequestMapping("/commonCodeDetail.ino")
	public ModelAndView commonCodeDetail(@RequestParam(value="code", defaultValue="") String code){
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> map = new HashMap<String,Object>();
		System.out.println("디테일 컨트롤러");
		System.out.println("code : "+code);
		map.put("code", code);
		List<HashMap<String,Object>> list=iCommCodeService.selectCommonCodeDetailList(map);
		String json=new Gson().toJson(list);
		System.out.println("list : "+json);
		
		mav.addObject("json",json);
		mav.setViewName("commonCodeDetail");
		return mav;
	}
	
	
	@RequestMapping("/checkAjax.ino")
	@ResponseBody
	public int checkAjax(@RequestParam(value="code", defaultValue="") String[] code
			,@RequestParam(value="dcode", defaultValue="") String[] dcode
			,@RequestParam(value="dcode_name", defaultValue="") String[] dcode_name
			,@RequestParam(value="use_yn", defaultValue="") String[] use_yn){
		//HashMap<String,Object> map = new HashMap<String,Object>();
		int result=0;
		System.out.println("체크 컨트롤러");
		
		result=iCommCodeService.checkAjax(dcode);
		System.out.println("check result ="+result);
		return result;
	}
	
	
	
	@RequestMapping("/insertDcode.ino")
	@ResponseBody
	public String insertDcode(@RequestParam(value="code", defaultValue="") String[] code
							       ,@RequestParam(value="dcode", defaultValue="") String[] dcode
							       ,@RequestParam(value="dcode_name", defaultValue="") String[] dcode_name
							       ,@RequestParam(value="mDcode", defaultValue="") String[] mDcode
							       ,@RequestParam(value="mDcode_name", defaultValue="") String[] mDcode_name
							       ,@RequestParam(value="dDcode", defaultValue="") String[] dDcode
							       ,@RequestParam(value="use_yn", defaultValue="") String[] use_yn
							       ,@RequestParam(value="mUseYn", defaultValue="") String[] mUseYn){
		//HashMap<String,Object> map = new HashMap<String,Object>();
		String result="";
//		System.out.println("인설트 디코드 컨트롤러");
//		System.out.println("code : "+code[0]);
//		System.out.println("dcode : "+dcode[0]);
//		System.out.println("dcode_name : "+dcode_name[0]);
//		System.out.println("use_yn : "+use_yn[0]);
//		System.out.println("-------");
//		System.out.println("mUseYn : "+mUseYn[0]);
//		System.out.println("mDcode : "+mDcode[0]);
//		System.out.println("mDcode_name : "+mDcode_name[0]);
//		System.out.println("mUseYn : "+mUseYn[1]);
//		System.out.println("mDcode_name : "+mDcode_name[1]);
//		System.out.println("-------");
//		System.out.println("dDcode : "+dDcode[0]);
		
		result=iCommCodeService.insertDcode(code,dcode,dcode_name,use_yn,mUseYn,mDcode_name,mDcode,dDcode);
		System.out.println("result ="+result);
		return result;
	}
	
	
	
}	//Class End
