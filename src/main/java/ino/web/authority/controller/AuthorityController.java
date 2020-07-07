package ino.web.authority.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import ino.web.authority.service.IAuthorityService;

@Controller
public class AuthorityController {
	
	@Autowired
	IAuthorityService AuthorityService;
	
	@RequestMapping("/login.ino")
	@ResponseBody
	public String login(HttpServletRequest req
						,@RequestBody HashMap<String,Object> map){
		String rs="fail";
		System.out.println("로그인 컨트롤러");
		System.out.println(map.get("user_id"));
		System.out.println(map.get("password"));
		rs=AuthorityService.login(req,map);
		System.out.println("rs : "+rs);
		return rs;
	}
	
	@RequestMapping("/logout.ino")
	public ModelAndView logout(HttpServletRequest req){
		ModelAndView mav = new ModelAndView();
		req.getSession().invalidate();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	@RequestMapping("/menuList.ino")
	@ResponseBody
	public List<HashMap<String, Object>> menuList(@RequestBody HashMap<String,Object> map){
		
		System.out.println("메뉴리스트 컨트롤러");
		List<HashMap<String, Object>> list=AuthorityService.menuList(map);
		
		return list;
	}
	
	@RequestMapping("/authorityMain.ino")
	public ModelAndView authorityMain(@RequestParam(value="show", defaultValue="") String[] show){
		ModelAndView mav = new ModelAndView();
		String jsonList=AuthorityService.groupList();
		
		mav.addObject("jsonList",jsonList);
		String showjson=new Gson().toJson(show);
		mav.addObject("show",showjson);
		mav.setViewName("authorityMain");
		return mav;
	}
	
	@RequestMapping("/authorityList.ino")
	@ResponseBody
	public HashMap<String,Object> authorityList(@RequestParam(value="groupid", defaultValue="")String groupid){
		List<HashMap<String, Object>> authorityList=AuthorityService.authorityList();
		List<HashMap<String, Object>> mappingList=AuthorityService.mappingList(groupid);
		
		System.out.println("authorityList C : "+authorityList);
		System.out.println("mappingList C : "+mappingList);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("authorityList", authorityList);
		map.put("mappingList", mappingList);
		return map;
	}
	
	
	@RequestMapping("/authoritySave.ino")
	@ResponseBody
	public String authoritySave(@RequestBody HashMap<String,Object> map){
		String result="fail";
		
		result=AuthorityService.authoritySave(map);

		return result;
	}
	
	
}
