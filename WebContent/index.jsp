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
 

 $(function(){	 
	 if("${user_id}"!=""){
		 location.href="/defaultPage.ino";
	 }
	 $("#sub_btn").click(function(){
		 loginCheck()
	 }); 
	 
 });
 function enterKey(){
	 if (window.event.keyCode === 13) {
         loginCheck();
    }

 }
 function loginCheck(){
	 var user_id=$("input[name=user_id]").val();
	 var password=$("input[name=password]").val();
	 var loginData={"user_id":user_id,"password":password};
	 var JsonData=JSON.stringify(loginData);
	 if(user_id.trim()==""||password.trim()==""){
		 alert("아이디와 비밀번호를 입력해주세요.");
		 return false;
	 }
	 
			 $.ajax({ 
				 type: "post", 
				 url : "./login.ino", 
				 data: JsonData, 
				 dataType:'html',
				 contentType : "application/json; charset=UTF-8",
				 success : function(data) {
					 if(data=="success"){
						 location.href="/defaultPage.ino";
					 }else{ 
					 alert("로그인 실패");
					 }
					 
					 }, error: function(error) {
						 console.log("error : ");
						 console.log(error);
						 }
					 });	//ajax End
 }
 </script>
</head>
<body>
<a href="<%=request.getContextPath() %>/main.ino">메인페이지</a>
	<div id='main_div'>
			<input type="text" onkeyup="enterKey()" name="user_id" placeHolder="로그인" style=" height:30px; margin-bottom: 5px;"/><br />
			<input type="password" onkeyup="enterKey()" name="password" placeHolder="비밀번호" style=" height:30px;"/>
			<input type="button"  id="sub_btn" value="로그인"/>
	</div>
</body>
</html>