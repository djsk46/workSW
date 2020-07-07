<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<script type="text/javascript">
$(function(){
	var show=${show};
	for(var i=0;i<show.length;i++){
		console.log("show["+i+"] : "+show[i]);
		$("li").eq(i).css("display",show[i]);
	}
})

function delete1(){
	if(confirm('�����Ͻðڽ��ϱ�?')==true){
	var num=$("#num").val().trim();			//�۹�ȣ
		$.ajax({ 
			 type: "post", 
			 url : "./freeBoardDelete.ino", 
			 data: {"num":num}, 
			 dataType:'text',
			 success : function(data) {
				 console.log(data);
				 alert("�ۻ��� : "+data);
				 location.href = "./main.ino";
				 }, error: function(error,data) {
				 alert("����");
					 console.log(error);
					 console.log(data);
					 }
		});	//ajax end
	}
	else
		return false;
}

function modify(){
	var title=$("#title").val().trim();		//����
	var content=$("#content").val().trim();	//����
	var name=$("#name").val().trim();		//�̸�
	var regdate=$("#regdate").val().trim();	//��¥
	var num=$("#num").val().trim();			//�۹�ȣ
	if(title==""){
		alert("������ �Է����ּ���.");
		return false;
	}
	if(confirm("�����Ͻðڽ��ϱ�?")){
	
	var param={
			"name" : name,
			"content" : content,
			"regdate" : regdate,
			"num" : num,
			"title" : title
			  }
	$.ajax({ 
		 type: "post", 
		 url : "./freeBoardModify.ino", 
		 data: param, 
		 dataType:'text',
		 success : function(data) {
			 console.log(data);
			 alert("�ۼ��� : "+data);
			 //location.href = "./main.ino";
			 }, error: function(error,data) {
			 alert("����");
				 console.log(error);
				 console.log(data);
				 }
	});	//ajax end
}
}	//modify end

</script>
</head>
<body>

	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">
	
	<form name="insertForm">
		<input type="hidden" id="num" name="num" value="${freeBoardMap.NUM }" />
		
		<div style="width: 150px; float: left;">�̸� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id="name" name="name" value="${freeBoardMap.NAME }" readonly/></div>
		
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id="title" name="title"  value="${freeBoardMap.TITLE }"/></div>
	
		<div style="width: 150px; float: left;">�ۼ�����</div>
		<div style="width: 500px; float: left;" align="left"><input type="text"  id="regdate" name="regdate"  value="${freeBoardMap.REGDATE }"/></div>
	
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><textarea id="content" name="content" rows="25" cols="65"  >${freeBoardMap.CONTENT }</textarea></div>
		<div align="right">
		<input type="button" id="btn" value="����" onclick="modify()">
		<input type="button" id="del_btn" value="����" onclick="delete1()">
		
		<input type="button" value="���" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div>
		
	</form>
	
</body>
</html>