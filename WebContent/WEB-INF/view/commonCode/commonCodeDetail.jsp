<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
var add_size=0;
$(function(){
/* 추가 */
$("#add_btn").click(function(){
	var add_str="";
	var list=${json};
/* 	if(add_size==0){
		add_str+="<h1 align='left'>추가</h1>";
		add_str+="<table style='width: 600px;margin-left:30px;'>";
		add_str+="<tr>";
		add_str+="<th align='left'>마스터코드</th>"; 
		add_str+="<th align='left'>디테일코드</th>";
		add_str+="<th>코드명</th>";
		add_str+="<th>사용유무</th>";
		add_str+="</tr>";
		add_str+="</table>";
		add_str+="<hr style='width: 600px'>";	
	} */
	if(add_size<3){
	add_str+="<div>";
	add_str+="<form  name='sub_frm'>";
	add_str+="<input type='button' id='del_Frm' value='-' style='margin-right:5px;'>";
	add_str+="<input type='text' id='code' name='code'  style='float=left;width: 120px;' value='"+list[0].CODE+"' readOnly/>";
	add_str+="<input type='text' id='dcode' name='dcode'  style='width: 120px;margin-left: 40px;'/>";
	add_str+="<input type='text' id='dcode_name' name='dcode_name'  style='width:120px;margin-left: 55px;margin-right: 20px'/>";
 	add_str+="Y<input type='radio' id='use_yn' name='use_yn' value='Y' />";
	add_str+="N<input type='radio' id='use_yn' name='use_yn' value='N' checked/>"; 
	add_str+="</form>";
	add_str+="</div>";
	$("#add_container").append(add_str);
	add_size++;
	}
	else{
		alert("3개까지만 추가 가능합니다.");
	}
 });
 
$(document).on("click", "input[value=-]", function(){
	$(this).parents('form').remove();
	add_size--;
});
 
 
 
 function addRequiredCheck(){
	 var dcode = $('input[name=dcode]').serializeArray();
	 var dcode_name = $('input[name=dcode_name]').serializeArray();

	 for(var i=0;i<dcode.length;i++){	 
	 if(dcode[i].value.trim()==""){
		 alert("디테일 코드는 필수입력입니다.");
		return false;
	    }
	 }
	 for(var i=0;i<dcode_name.length;i++){
		 if(dcode_name[i].value.trim()==""){
			 alert("디테일 코드 이름은 필수입력입니다.")
			return false; 
		 }
	 }
	 return true; 
 }
 
 function modifyRequiredCheck(){
	 var mDcode_name = $('input[name=mDcode_name]').serializeArray();
	 console.log(mDcode_name);
	 for(var i=0;i<mDcode_name.length;i++){
		 if(mDcode_name[i].value.trim()==""){
			 alert("디테일 코드 이름은 필수입력입니다.");
			return false; 
		 }
	 }
	 return true;
 }
 
 function checkAjax(){
	 var datafrm = $('form').serialize();
	 var result=0;
		
	 $.ajax({ 
			 type: "post", 
			 url : "./checkAjax.ino", 
			 data: datafrm, 
			 async: false,
			 dataType:'html',
			 success : function(data) {
				 console.log("check : "+data);
				 result=data;
				 }, error: function(error) {
					 console.log("error : ");
					 console.log(error);
					 }
				 });	//ajax End
				 return result;
 }
 
 
$("#sub_btn").click(function(){
	if(add_size==0 && $("input[name=check]:checked").length==0){
		alert("변경된 값이 없습니다.");
		return false;
	}
	if(confirm("저장하시겠습니까?")){
		
		if(!addRequiredCheck()){	//추가 공백 체크
			return false;
		}
		if(!modifyRequiredCheck()){		//수정 공백 체크
			return false;
		}
		var result=0;
		if(add_size!=0){
		result=checkAjax();			
		}
		if(result==0){	
		var datafrm = $('form[name=sub_frm]').serialize();
		var checkbox=$("input[name=check]:checked").parents('form').serialize();
		console.log("--s--");
		console.log(datafrm);
		console.log(checkbox);
		
		return false;
		$.ajax({ 
			 type: "post", 
			 url : "./insertDcode.ino", 
			 data: datafrm+"&"+checkbox, 
			 dataType:'html',
			 success : function(data) {
				 alert(data);
				 location.reload();
				 }, error: function(error) {
					 console.log("error : ");
					 console.log(error);
					 }
				 });	//ajax End
		}//check ENd
		else{
			alert("중복된 DCODE가 있습니다.");
		}
	}
	else{
		alert("취소하였습니다.");
		return false;
	}
});
 
});	//ready End

 //on Load
$(function (){
	makeLoad();
});
function makeLoad(){
	var list=${json};
	console.log(list);
 	var str="";
 	
	for(var i=0;i<list.length;i++){
	str+="<form name='modifyFrms'>";
	str+="<table style='width: 600px'>";
	str+="<tr>";
	str+="<td align='center' style='width:10% ; '><input type='checkbox' name='check'/></td>";
	str+="<td align='center' style='width:20% ; text-align: center;'>"+list[i].CODE+"</td>";
	str+="<td align='center' style='width:20% ; text-align: center;'><input type='text' name='mDcode' value='"+list[i].DCODE+"' readonly='readonly' style='all:unset;width: 120px;'/></td>";        
	str+="<td align='center' style='width:25% ; text-align: center;'><input type='text' name='mDcode_name' value='"+list[i].DCODE_NAME+"'  readonly='readonly' style='all:unset;width: 120px;'/></td>";
	str+="<td align='center' style='width:10% ;'><input type='text' value='"+list[i].USE_YN+"' readonly='readonly' style='all:unset;width:20px'/><input type='hidden' id='crud_type' name='crud_type' value=''/>";
	
	if(list[i].USE_YN=="Y"){
	str+="<label style='float:left;'>Y<input type='radio' name='mUseYn' value='Y' checked='checked' style='width:10px'/></label><label style='float:left;'>N<input type='radio' name='mUseYn' value='N' style='width:10px'/></label>";
	}
	else{
	//str+="<form name='modifyFrms'>";
	str+="<label style='float:left;'>Y<input type='radio' name='mUseYn' value='Y'  style='width:10px'/></label><label style='float:left;'>N<input type='radio' name='mUseYn' value='N' checked='checked' style='width:10px'/></label>";		
	//str+="</form>";
	}
	str+="</td>";
	str+="</tr>";
	str+="</table>";
	str+="</form>";
	}
	$("#list_container").empty();
	$("#list_container").html(str); 
}  
	
$(function (){
	$("#modify_btn").click(function(){
	var checkbox=$("input[name=check]:checked");
	checkbox.each(function(i){	//check된 만큼 반복
		var tr=checkbox.parent().parent().eq(i);
		var td=tr.children();
		var defaultValue=td.eq(3).find("input").prop("defaultValue");
		var defaultChecked=td.eq(4).find('label').children().prop("defaultChecked");
		console.log("----");
		console.log(td.eq(4).find('label').children("input[name=mUseYn]"));
		console.log(td.eq(4).find('label').children().prop("defaultChecked"));
	/* 	console.log(td.eq(3).children().val());
		console.log(td.eq(4).children().val()); */	
		if(td.eq(4).find('input[type=hidden]').attr("value")!="delete"){
			
		if(td.eq(4).children('input[type=hidden]').attr("value")=="modify"){
			td.eq(3).children().attr("readOnly",true).prop("value",defaultValue).css("background-color","transparent").css("border","none");
			td.eq(4).children('input[type=hidden]').attr("value","");
			td.eq(4).children('input').css("display","block");
			td.eq(4).find('label').css("display","none");
		    //td.eq(4).find('label').children().prop("checked",defaultChecked);
		 	td.eq(0).children().prop("checked", false);
		} 
		else{
		td.eq(2).children('input[type=text]').attr("name","mDcode");
		td.eq(3).children('input[type=text]').attr("name","mDcode_name");
		td.eq(3).children().attr("readOnly",false).css("background-color","white").css("border","1px black solid");
		td.eq(4).children('input[type=hidden]').attr("value","modify")
		td.eq(4).children('input').css("display","none");
		//td.eq(4).find('label').children().prop("checked",true);
		td.eq(4).find('label').css("display","block");
		}
	  }
	})	//each end
	
	});	//수정버튼 end
})
$(function(){
	$("#delete_btn").click(function(){
		var checkbox=$("input[name=check]:checked");
		
		checkbox.each(function(i){	//check된 만큼 반복
			var tr=checkbox.parent().parent().eq(i);
			var td=tr.children();

			if(td.eq(4).children('input[type=hidden]').attr("value")!="modify"){
				
			if(td.eq(4).children('input[type=hidden]').attr("value")=="delete"){
				td.css("opacity","100%");
				td.eq(4).children('input[type=hidden]').attr("value","");
				td.eq(2).children('input[type=text]').attr("name","mDcode");
				td.eq(3).children('input[type=text]').attr("name","mDcode_name");
				td.eq(0).children().prop("checked", false);
			} 
			else{
			td.css("opacity","40%");
			td.eq(2).children('input[type=text]').attr("name","dDcode");
			td.eq(3).children('input[type=text]').attr("name","dDcode_name");
			console.log(td.eq(2).children('input[type=text]').attr("name"));
			td.eq(4).children('input[type=hidden]').attr("value","delete");
			}
			}
		})	//each end
	});	//삭제버튼 end
});
</script>

<style>
label{
display: none;
}
#aa{
text-align: center;

}
td{
padding: 7px 0;
border-bottom: 1px black solid;
}
table,tr,th,td{
border-collapse: collapse;
}
</style>
</head>
<body>

 <div style="background-color:#dedede; height:700px;">
				<tiles:insertAttribute name="content" />
	
	<div id="main_container" style="margin-left: 20px;" align="left">
	<h1 style="margin-top: 20px;">디테일 </h1>
		<div style="width:600px;" align="right">
			<button id="delete_btn">삭제</button>
			<button id="modify_btn">수정</button>
			<button id="add_btn">추가</button>
			<button id="sub_btn">저장</button>
		</div>
<hr style='width: 600px'align="left">
<div>
	<table id='list_table' style='width: 600px'>
 		<tr>
			<th align='center' style='width: 10%; text-align: center;'>check</th>
			<th align='center' style='width: 20%; text-align: center;'>마스터코드</th>
			<th align='center' style='width: 20%; text-align: center;'>디테일코드</th>
			<th align='center' style='width: 25%; text-align: center;'>코드명</th>
			<th align='center' style='width: 10%; text-align: center;'>사용유무</th>
		</tr> 

	</table> 
</div>

	<div id="list_container">
	
	</div>
	</div>
	
	<div id="add_container" style="float:left;margin-left: 20px;">
	
	</div>


	</div>

</body>
</html>