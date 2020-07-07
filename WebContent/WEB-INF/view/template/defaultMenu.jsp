<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>

<script type="text/javascript">
var onOff=0;
var menu;

function move_btn(object_name){
	
	var show=new Array();
	for(var i=0;i<$("li").length;i++){
		show[i]=$("li").eq(i).css("display");
	}
	if(object_name.trim()=="메인")
		location.href="./main.ino?show="+show;
		//location.href="./main.ino";
	
	if(object_name.trim()=="공통코드")
		location.href="./commonCode.ino?show="+show;
	
	if(object_name.trim()=="사용권한")
		location.href="./authorityMain.ino?show="+show;
}


$(function(){	
	

	var object_name="메인";
	var group_id=${group_id};
	var data={"group_id":group_id
			 ,"object_name":object_name};
	var JsonData=JSON.stringify(data);
		 $.ajax({ 
			 type: "post", 
			 url : "./menuList.ino", 
			 data:JsonData,
			 dataType:'json',
			 contentType : "application/json; charset=UTF-8",
			 async:false,
			 success : function(data) {
				 menu=data;
				 var str="";
				 for(var i=0;i<data.length;i++){
					 str+="<li>";
					 str+="<a href='javascript:void(0)' onclick='menuList(\""+data[i].OBJECT_ID+"\")'>"+data[i].OBJECT_NAME+"</a><button onclick='move_btn(\""+data[i].OBJECT_NAME+"\")'>open</button>";
					 str+="<input type='hidden' name='object_id' value='"+data[i].OBJECT_ID+"' />";
					 str+="<input type='hidden' name='high_obj' value='"+data[i].HIGH_OBJ+"' />";
					 str+="<input type='hidden' name='dept' value='"+data[i].DEPT+"' />";
					 str+="</li>";
				 }
				 $("ul").html(str);
				 for(var i=0;i<data.length;i++)
					 $("li").eq(i+1).hide();
					  
				 }, error: function(error) {
					 console.log("error : ");
					 console.log(error);
					 }
				 });	//ajax End 
})
function menuList(object_id){	
	if(object_id=="OBJECT100"){
		 if($("input[name=high_obj][value=OBJECT100").parent().css("display") == "none"){
			$("input[name=dept][value=2]").parent().show();
		}
		else{
			$("input[name=dept][value=2]").parent().hide();
			$("input[name=dept][value=3]").parent().hide();
		}	 
	}
	else{
		
		for(var i=0;i<menu.length;i++){	
			if(object_id==menu[i].HIGH_OBJ){
			$("input[name=high_obj][value="+menu[i].HIGH_OBJ+"]").parent().toggle();
			}
		}
	}
	
}



</script>

</head>
<body>
	<br><br><br><br>
	<ul id="show">
		<!-- <li>
			<a href="javascript:void(0)" id='main' onclick="menuList('메인')">메인</a>
			<button onclick="move_btn('메인')">open</button>
		</li> -->
	</ul>
	
</body>
</html>