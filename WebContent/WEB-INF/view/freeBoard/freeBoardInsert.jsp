<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var show=${show};
	for(var i=0;i<show.length;i++){
		console.log("show["+i+"] : "+show[i]);
		$("li").eq(i).css("display",show[i]);
	}
})
 $(function(){
	$("#btn").click(function(){
		var name = $("#name").val().trim(); 		
		var title = $("#title").val().trim(); 		
		var content = $("#content").val().trim(); 
		console.log(name+title+content);
		if(name==""){
			alert("�̸��� �Է����ּ���");
			return false;
		}
		if(title==""){
			alert("������ �Է����ּ���");
			return false;
		}
			
		if(confirm("���� ����Ͻðڽ��ϱ�?")==true){
			var param={
					"name" : name,
					"content" : content,
					"title" : title
					  }
			
			$.ajax({ 
				 type: "post", 
				 url : "./freeBoardInsertPro.ino", 
				 data: param, 
				 dataType:'text',
				 success : function(data) {
					 console.log(data);
					 if(data!=0){
						 
					 alert("�۾��� �Ϸ�");
					 location.href = "./freeBoardDetail.ino?num="+data+"";
					 }
					 else
					 alert("�۾��� ����");
						 
					 }, error: function(error,data) {
					 alert("����");
						 console.log(error);
						 console.log(data);
						 }
					 });	//ajax End
		}
		else
			return false;
		
	});
	
	
}) 

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
	
	<form>
		<div style="width: 150px; float: left;">�̸� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id="name" name="name" /></div>
		
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id="title" name="title"/></div>
	
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><textarea id="content" name="content" rows="25" cols="65"  ></textarea></div>
		<div align="right">
		<input type="button" id="btn" value="�۾���">
		<input type="button" value="�ٽþ���" onclick="reset()">
		<input type="button" value="���" onclick="history.back()">
		&nbsp;&nbsp;&nbsp;
		</div>
	
	</form>


</body>
</html>