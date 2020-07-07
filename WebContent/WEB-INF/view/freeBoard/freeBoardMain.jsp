<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head profile="http://www.w3.org/2005/10/profile">
<link rel="icon" type="image/png" href="http://example.com/myicon.png"> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!--캐시를 사용하지 않겠다  -->
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<title>Insert title here</title>

<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
  
  
<script type="text/javascript">
var COM001="";
var search="";
var startDay ="";
var endDay = "";
var show;
$(function(){
	
	console.log("---");
	console.log(${show});
	 show=${show};
	for(var i=0;i<show.length;i++){
		//console.log("show["+i+"] : "+show[i]);
		$("li").eq(i).css("display",show[i]);
	}
})
$(function(){
	/* $("li").css("display",show); */
	
	
	$("#sub_btn").click(function(){
	var curPage=1;
	 COM001=$("#COM001").val();
	 search=$("#search").val();
	 startDay = $("#startDay").val();
	 endDay =   $("#endDay").val();
	 regexp = /^[0-9]*$/;
	if(startDay!="" && endDay!=""){
		
		if(!dateCheckFct(startDay)){
			$("#startDay").focus();
			return false;
				}
		if(!dateCheckFct(endDay)){	
			$("#endDay").focus();
			return false;
				}
		
		//종료일이 시작일보다 작으면	
		if(startDay>endDay){
			alert("종료일은 시작일보다 커야합니다.");		
			$("#endDay").focus();
			return false;
		}
		
	}else if(startDay=="" && endDay!=""){
		alert("시작일을 입력해주세요.");
		$("#startDay").focus();
		return false;
	}else if(endDay=="" && startDay!=""){
		alert("종료일을 입력해주세요.");
		$("#endDay").focus();
		return false;
	}	
	
	 if(startDay=="" && endDay==""){ 
	if(search.trim()==""){
		alert("검색어를 입력해주세요.");
		$("#search").focus();
		return false;
		}
	 }
		
		if(COM001=="DCOM002"){
			if(!regexp.test(search) ) {
				alert("숫자만 입력하세요");
				$("#search").val("").focus();
			return false;
			}
		}
	var param={
			"COM001" : COM001,
			"search" : search,
			"startDay" : startDay,
			"endDay" : endDay,
			"curPage" : curPage
			  }
	$.ajax({ 
		 type: "post", 
		 url : "./freeBoardSearch.ino", 
		 data: param, 
		 dataType:'json',
		 success : function(data) {
			 console.log("-----------z");
			 console.log(data);
			 var str="";
			 var str2="";
		 	 
			 history.pushState(null,null,
						"./main.ino?curPage="+data.pageUt.curPage+"&COM001="+COM001+"&search="+search+"&startDay="+startDay+"&endDay="+endDay+"&show="+show); 
			 mainList(data);
			 }, error: function(error) {
				 console.log("error : ");
				 console.log(error);
				 }
			 });	//ajax End
	 
	
	});	//click end
});  //(function) end

function searchKey(){
	
	  if (window.event.keyCode === 13) {
			 COM001=$("#COM001").val();
			 search=$("#search").val();
			 startDay = $("#startDay").val();
			 endDay =   $("#endDay").val();
			var regexp = /^[0-9]*$/
			
			 if(startDay=="" && endDay==""){ 
					if(search.trim()==""){
						alert("검색어를 입력해주세요.");
						$("#search").focus();
						return false;
					}
			  }
			
			if(startDay>endDay){
				alert("종료일은 시작일보다 커야합니다.");		
				$("#endDay").focus();
				return false;
			}
	
			if(COM001=="DCOM002"){
				if(!regexp.test(search) ) {
					alert("숫자만 입력하세요");
					$("#search").val("").focus();
					return false;
				}
			}
			
			searchFct(1);
			
     	} else {	//엔터키(13)가 아닐시
  	   		return false;
     }
  } 
  
/* ---------------searchFct Ajax----------------------  */
function searchFct(curPage){
	for(var i=0;i<$("li").length;i++){
		show[i]=$("li").eq(i).css("display");
		console.log("show["+i+"] : "+show[i]);
	}	
	
		 COM001=$("#COM001").val();
		 search=$("#search").val();
		 startDay = $("#startDay").val();
		 endDay =   $("#endDay").val();
	
		if(startDay!="" && endDay!=""){
			
			if(!dateCheckFct(startDay)){
				$("#startDay").focus();
				return false;
					}
			if(!dateCheckFct(endDay)){	
				$("#endDay").focus();
				return false;
					}	
			//종료일이 시작일보다 작으면
			if((startDay-endDay)>0){
				alert("종료일은 시작일보다 커야합니다.");		
				$("#endDay").focus();
				return false;
			}
			
		}else if(startDay=="" && endDay!=""){
			alert("시작일을 입력해주세요.");
			$("#startDay").focus();
			return false;
		}else if(endDay=="" && startDay!=""){
			alert("종료일을 입력해주세요.");
			$("#endDay").focus();
			return false;
		}
		
		var param={
				"COM001" : COM001,
				"startDay" : startDay,
				"endDay" : endDay,
				"search" : search,
				"curPage" : curPage
				  }
		console.log(COM001);
		console.log(search);
	$.ajax({ 
		 type: "post", 
		 url : "./freeBoardSearch.ino", 
		 data: param, 
		 dataType:'json',
		 success : function(data) {
			 console.log(data);
			 console.log(data.list);
			 console.log(data.length);
			 
			  history.pushState(null,null,
						"./main.ino?curPage="+data.pageUt.curPage+"&COM001="+COM001+"&search="+search+"&startDay="+startDay+"&endDay="+endDay+"&show="+show); 
						mainList(data);	
						
			 }, error: function(error) {
				 console.log("error : ");
				 console.log(error);
				 }
			 });	//ajax End
			  
		}	//fct end


/* --------------search Ajax End---------------------  */
 
 function pageSearch(curPage){
			searchFct(curPage);
		}
 
 $(window).on('popstate', function(event) {

	  location.href=location.href;

}); 
		
</script>

<script type="text/javascript">
/* main이동시 load */
$(function (){	
 var list=${freeBoardList };
 var searchList=${search };
var str="";
var str2="";
var search=searchList.search;
var start_day="";
start_day+=searchList.startDay.substring(0,4)+"-"+searchList.startDay.substring(4,6)+"-"+searchList.startDay.substring(6,8);
var end_day="";
end_day+=searchList.endDay.substring(0,4)+"-"+searchList.endDay.substring(4,6)+"-"+searchList.endDay.substring(6,8);

$("#search").val(search);
if(searchList.startDay!=""&&searchList.endDay!=""){
	
$("#startDay").val(start_day);
$("#endDay").val(end_day);
}



for(var i=0;i<list.length;i++){
	 str+="<div style='width: 50px; float: left;'>"+list[i].NUM+"</div>";	
	 str+="<div style='width: 300px; float: left;'><a href='javascript:void(0)' onclick='showMenuBar("+list[i].NUM+")'>"+list[i].TITLE+"</a></div>";
	 str+="<div style='width: 150px; float: left;'>"+list[i].NAME+"</div>";
	 str+=" <div style='width: 150px; float: left;'>"+list[i].REGDATE+"</div>";
	 str+="<hr style='width: 600px'>";
}
  if (${pageUt.curPage} >1){
    str2+= "<a href='javascript:void(0)' onclick='pageSearch(1)'>[처음]</a>";
 }

 if(${pageUt.blockBegin} > 1){
	str2+= "<a href='javascript:void(0)' onclick='pageSearch("+${pageUt.prevPage10}+")' >[<<]</a>";
 }
 if(${pageUt.curPage} > 1){
	str2+="<a href='javascript:void(0)' onclick='pageSearch("+${pageUt.prevPage}+")' >[<]</a>";
 }
	
 for(var i=${pageUt.blockBegin};i<=${pageUt.blockEnd};i++){ 
	
	switch(i){
		case ${pageUt.curPage}: 
       	    str2+= " <span style='color: red'> "+i+" </span>";
       	    break;
		default:
        	str2+= "<a href='javascript:void(0)' onclick='pageSearch("+i+")'> "+i+" </a>";
        	//str2+= "<button onclick='pageSearch("+${pageUt.curBlock}+")'> "+i+" </button>";
        	break;
	 }
 }
	 

if(${pageUt.curPage} < ${pageUt.totPage}){
	str2+= "<a href='javascript:void(0)' onclick='pageSearch("+${pageUt.nextPage}+")'>[>]</a>";
	str2+= "<a href='javascript:void(0)' onclick='pageSearch("+${pageUt.nextPage10}+")'>[>>]</a>";
}
 
if(${pageUt.curPage} < ${pageUt.totPage}){
	str2+= "<a href='javascript:void(0)' onclick='pageSearch("+${pageUt.totPage}+")'>[끝]</a>";
}  

$("#res_cont").empty();
$("#res_cont").html(str);

$("#page_cont").empty();
$("#page_cont").html(str2);   
});
/* main이동시 load End */
 
function showMenuBar(num){
	
	for(var i=0;i<$("li").length;i++){
		show[i]=$("li").eq(i).css("display");
		console.log("show["+i+"] : "+show[i]);
	}
	
	location.href="./freeBoardDetail.ino?num="+num+"&show="+show;
}

function mainList(data) {
	var jsonList=data.list;
	var list=JSON.parse(jsonList);
	
/* 	var start_day="";
	start_day+=data.startDay.substring(0,4)+"-"+data.startDay.substring(4,6)+"-"+data.startDay.substring(6,8);
	var end_day="";
	end_day+=data.endDay.substring(0,4)+"-"+data.endDay.substring(4,6)+"-"+data.endDay.substring(6,8);
	$("#startDay").val(start_day);
	$("#endDay").val(end_day);  */

	
	
	var str="";
	var str2="";
	if(list=="")
	str+="<div style='width: 300px; float: left;'>검색 결과가 없습니다.</div>";
 	for(var i=0;i<list.length;i++){
		 str+="<div style='width: 50px; float: left;'>"+list[i].NUM+"</div>";	
		 str+="<div style='width: 300px; float: left;'><a href='javascript:void(0)' onclick='showMenuBar("+list[i].NUM+")'>"+list[i].TITLE+"</a></div>";
		 str+="<div style='width: 150px; float: left;'>"+list[i].NAME+"</div>";
		 str+=" <div style='width: 150px; float: left;'>"+list[i].REGDATE+"</div>";
		 str+="<hr style='width: 600px'>";
	} 
	 if (data.pageUt.curPage >1){
	    str2+= "<a href='javascript:void(0)' onclick='pageSearch(1)'>[처음]</a>";
	 }

	 if(data.pageUt.blockBegin > 1){
		str2+= "<a href='javascript:void(0)' onclick='pageSearch("+data.pageUt.prevPage10+")' >[<<]</a>";
	 }
	 if(data.pageUt.curPage > 1){
		str2+="<a href='javascript:void(0)' onclick='pageSearch("+data.pageUt.prevPage+")' >[<]</a>";
	 }
		
	 for(var i=data.pageUt.blockBegin;i<=data.pageUt.blockEnd;i++){ 
		
		switch(i){
			case data.pageUt.curPage: 
	       	    str2+= " <span style='color: red'> "+i+" </span>";
	       	    break;
			default:
	        	str2+= "<a href='javascript:void(0)' onclick='pageSearch("+i+")'> "+i+" </a>";
	        	break;
		 }
	 }
		 

	if(data.pageUt.curPage < data.pageUt.totPage){
		str2+= "<a href='javascript:void(0)' onclick='pageSearch("+data.pageUt.nextPage+")'>[>]</a>";
		str2+= "<a href='javascript:void(0)' onclick='pageSearch("+data.pageUt.nextPage10+")'>[>>]</a>";
	}
	 
	if(data.pageUt.curPage < data.pageUt.totPage){
		str2+= "<a href='javascript:void(0)' onclick='pageSearch("+data.pageUt.totPage+")'>[끝]</a>";
	}   

	$("#res_cont").empty();
	$("#res_cont").html(str);

 	$("#page_cont").empty();
	$("#page_cont").html(str2);    
	};

	
//----------------날짜 유효성 검사-----------------------//
function dateCheckFct(days){
	var lengthRx =/^\d{4}-\d{2}-\d{2}$/;
	if(!lengthRx.test(days)){
		alert("날짜형식을 맞춰주세요.(YYYY-DD-MM)");
		return false;
	}
	else{
	var rxDatePattern = /^(\d{4})(\d{1,2})(\d{1,2})$/; //YYYY,MM,DD               
    var dtArray = days.replace(/-/g,"").match(rxDatePattern); //  //YYYY,MM,DD 나눠서 배열 담기 
	var dtYear = dtArray[1];
	var dtMonth = dtArray[2];
	var dtDay = dtArray[3];

    
	if(dtYear<1900)	{
		alert("연도를 확인해주세요.(19xx~)");
        return false;		
	}	
	
	else if (dtMonth < 1 || dtMonth > 12){
		alert("01~12월 사이에서 입력해주세요.");
        return false;
    }
    else if (dtDay < 1 || dtDay > 31){
    	alert("01~31일 사이에서 입력해주세요.");
        return false;
    }
    else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31){
    	alert("01~30일 사이에서 입력해주세요.");
        return false;
    }
    else if (dtMonth == 2) {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay > 29 || (dtDay == 29 && !isleap)){
        	alert("해당년도에 존재하지 않는 일입니다.");      	
            return false;
        }
    }
    return true;   		
	}
}

//----------------날짜 유효성 검사끝---------------------//


//----------------날짜 하이픈 자동완성-------------------//
function dateKey(date){
	// 백스페이스키(8),tab(9) 예외
	var key= window.event.keyCode;
	if(key === 8 || key === 9)
		return false;		
	console.log(date.value);
	console.log(date.value.length);
	
	var dateLength=date.value.length;
	var temp="";
	var res="";
	temp=date.value;
	//날짜  /(\d{4})(\d{2})(\d{2})/, '$1-$2-$3'
	var regex = /^[0-9,-]*$/;
	//var regex = /(\d{4})(\d{2})(\d{2})/;
	
	//window.event.keyCode === 48~57 96~105
	//if(key>=48 || key<=57 && key>=96 || key<=105){
		
	if(!regex.test(temp)){
		alert("숫자만 입력해주세요.");
		$("#"+date.id+"").val("").focus();
	}
		 if(dateLength==4){
			temp+="-";
			$("#"+date.id+"").val(temp);
			return false;
		}
		if(dateLength==7){
			temp+="-";
			$("#"+date.id+"").val(temp);
			return false;
		} 
		
			var lengthRx =/^[0-9]([-]?[0-9])*$/;
		if($("#startDay").val().length==10){
			$("#endDay").focus();
		}
		
		if($("#endDay").val().length==10){
				$("#search").focus();
		}
		
}

//----------------날짜 하이픈 자동완성 끝-------------------//
function showInsert(){
	for(var i=0;i<$("li").length;i++){
		show[i]=$("li").eq(i).css("display");
		console.log("show["+i+"] : "+show[i]);
	}
	
	location.href="./freeBoardInsert.ino?show="+show;
}
</script>

</head>
<body>
	<div id="container">
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
	<div style="display:inline-block; float:left; margin-left: 20px;" >
	<select name="COM001" id="COM001" style="height:30px;">
 	     <c:forEach items="${commList1 }" var="commList1">
					<option value="${commList1.DCODE }">${commList1.DCODE_NAME }</option>
		 </c:forEach>  
	</select> 
	
 	<select name="COM002" id="COM002" style="height:30px;">
 	     <c:forEach items="${commList2 }" var="commList2">
					<option value="${commList2.DCODE }">${commList2.DCODE_NAME }</option>
		 </c:forEach>  
	</select> 

	<input type="text" name="search" onkeyup="searchKey()" id="search" style="height:24px;">
	
	<input type="button" id="sub_btn" value="검색">
	</div>
	
	<div style="display:inline-block;">
		<a href="javascript:void(0)" onclick="showInsert()">글쓰기</a>
	</div>
	
	<div style="display:inline-block; float:left; margin: 5px 0px 5px 20px;">
	<input type="text" id="startDay" name="startDay" style="height:24px;" placeholder="시작일(yyyy-mm-dd)" onkeyup="dateKey(this)" maxlength="10"  />
	<input type="text" id="endDay" name="endDay" style="height:24px;" placeholder="종료일(yyyy-mm-dd)" onkeyup="dateKey(this)" maxlength="10" />
	</div>
	
	</div>
	<hr style="width: 600px">
	<div id="res_cont">
	<%-- 
	<c:forEach var="dto" items="${freeBoardList }">
		 <div style="width: 50px;  float: left; ">${dto.NUM}</div>	
		 <div style="width: 300px; float: left;"><a href='./freeBoardDetail.ino?num=${dto.NUM}'>${dto.TITLE}</a></div>
		 <div style="width: 150px; float: left;">${dto.NAME}</div>
		 <div style="width: 150px; float: left;">${dto.REGDATE}</div>
		 <hr style='width: 600px'>          
	</c:forEach>
	 --%>
	</div>
	
	<div id="page_cont">  
 </div>
                
	</div>
	
</body>
</html>