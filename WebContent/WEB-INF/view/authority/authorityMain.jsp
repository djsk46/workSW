<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		//console.log("show["+i+"] : "+show[i]);
		$("li").eq(i).css("display",show[i]);
	}
})

var jsonList=${jsonList};
console.log(jsonList);
var group_id;
var group_name;
var authorityArr;
$(function(){
	showGroup();
});

/* group table on load */
function showGroup(){
	var jsonList=${jsonList};
	var str="";
	str+="<table >";
	str+="<tr>";
	str+="<th style='width:60px;'>그룹ID</th>";
	str+="<th style='width:80px;'>그룹 이름</th>";
	str+="<th style='width:80px;'>사용 여부</th>";
	str+="</tr>";
	for(var i=0; i<jsonList.length;i++){
		var groupID=jsonList[i].GROUP_ID;
		var groupName=jsonList[i].GROUP_NAME;
		
		str+="<tr>";
		str+="<td><a href='javascript:void(0)' onclick='authorityList("+groupID+",\""+groupName+"\")'>"+jsonList[i].GROUP_ID+"</a></td>";
		str+="<td><a href='javascript:void(0)' onclick='authorityList("+groupID+",\""+groupName+"\")'>"+jsonList[i].GROUP_NAME+"</a></td>";
		str+="<td>"+jsonList[i].USE_YN+"</td>";
		str+="</tr>";
	}
	str+="</table>";
	
	$("#group_table").empty();
	$("#group_table").html(str);
	
}

function authorityList(groupID,groupName){
	 group_id=groupID;
	 group_name=groupName;
	$.ajax({ 
		 type: "post", 
		 url : "./authorityList.ino", 
		 data: {"groupid":groupID}, 
		 dataType:'json',
		 success : function(data) {
	 		
			 showAuthority(data,groupID,groupName);
			 }, error: function(error) {
				 console.log("error : ");
				 console.log(error);
				 }
			 });	//ajax End
}

/* showAuthority on load  */
var strr="";
function showAuthority(data,groupID,groupName){
	console.log("z");
	console.log(data);
	authorityArr=data.authorityList;
	var str="";
	str+="<form>";
	str+="<table >";
	str+="<tr>";
	str+="<th style='width:20px;'>CHECK</th>";
	str+="<th style='width:80px;'>USE_YN</th>";
	str+="<th style='width:60px;'>OBJ_ID</th>";
	str+="<th style='width:100px;'>OBJ_Name</th>";
	str+="<th style='width:50px;'>DEPT</th>";
	str+="</tr>";
	for(var i=0;i<data.authorityList.length;i++){	
		var useYn="미사용";
		str+="<td>";
		str+="<input type='checkbox' name='check' ";
		for(var j=0;j<data.mappingList.length;j++){
		
			if(data.mappingList[j].OBJECT_ID==data.authorityList[i].OBJECT_ID){
				str+="checked";
				useYn="사용중";
			}
		} 
		str+=" style='width:20px;'/>";
		str+="<td><input type='text' name='dept' value='"+useYn+"' readOnly style='all:unset; width:50px;'/></td>";
		str+="<td><input type='text' name='objectId' value='"+data.authorityList[i].OBJECT_ID+"' readOnly style='all:unset; width:80px;' /></td>";
		str+="<td><input type='text' name='objectName' value='"+data.authorityList[i].OBJECT_NAME+"' readOnly style='all:unset; width:100px;' /></td>";
		str+="<td><input type='text' name='dept' value='"+data.authorityList[i].DEPT+"' readOnly style='all:unset; width:40px;' /></td>";
		
		str+="<td><input type='hidden' name='group_id' value='"+groupID+"' /></td>";
		str+="<td><input type='hidden' name='group_name' value='"+groupName+"' /></td>";
		str+="<td><input type='hidden' name='high_obj' value='"+data.authorityList[i].HIGH_OBJ+"' readOnly style='all:unset; width:40px;' /></td>";
		str+="</tr>";
	}
	str+="</form>";
	str+="</table >";
	
	$("#authorit_table").empty();
	$("#authorit_table").html(str);
	strr=str;
}

/* 저장 버튼 클릭시 */
$(function(){
	$("#sub_btn").click(function(){
		var checkbox=$("input[name=check]:checked");
		var unCheckbox=$("input[name=check]:not(:checked)");
		var insertData=new Array();
		var deleteData=new Array();
		checkbox.each(function(i){	//check된 만큼 반복
			var tr=checkbox.parent().parent().eq(i);
			var td=tr.children();
			var useYn=td.eq(1).find("input").prop("defaultValue");
			var object_id=td.eq(2).find("input").prop("defaultValue");
			var object_name=td.eq(3).find("input").prop("defaultValue");
			var dept=td.eq(4).find("input").prop("defaultValue");
			var group_id=td.eq(5).find("input").prop("defaultValue");
			var group_name=td.eq(6).find("input").prop("defaultValue");
			var high_obj=td.eq(7).find("input").prop("defaultValue");
			if(useYn!="사용중"){
			insertData[i]={
					"GROUP_ID" : group_id,
					"GROUP_NAME" : group_name,
					"OBJECT_ID" : object_id,
					"OBJECT_NAME" : object_name,
					"DEPT" : dept,
					"HIGH_OBJ":high_obj
					  }
			}
		});//checked End
		unCheckbox.each(function(i){	//check된 만큼 반복
			var tr=unCheckbox.parent().parent().eq(i);
			var td=tr.children();
			var object_id=td.eq(2).find("input").prop("defaultValue");
			var useYn=td.eq(1).find("input").prop("defaultValue");
			var group_id=td.eq(5).find("input").prop("defaultValue");
			var high_obj=td.eq(7).find("input").prop("defaultValue");
			if(useYn=="사용중"){
				
			deleteData[i]={
					"GROUP_ID" : group_id,
					"OBJECT_ID" : object_id,
					"HIGH_OBJ":high_obj
					  }
			}
		});	//unChecked End
		insertData  = insertData.filter(function(item) {
			  return item !== null && item !== undefined && item !== '';
			});
		deleteData  = deleteData.filter(function(item) {
			  return item !== null && item !== undefined && item !== '';
			});
		
		for(var i=0;i<authorityArr.length;i++){
			
			for(var j=0;j<insertData.length;j++){
				if(authorityArr[i].OBJECT_ID==insertData[j].HIGH_OBJ){
					var YN=$("input[name=objectId][value="+authorityArr[i].OBJECT_ID+"]").parents('tr').children().eq(1).find('input').val();
					var checked=$("input[name=objectId][value="+authorityArr[i].OBJECT_ID+"]").parents('tr').children().eq(0).find('input').prop("checked");
					if(!checked){
						if(YN!='사용중'){
						 	alert("상위 dept가 활성화되어 있지않습니다.");
						 	$("#authorit_table").empty();
							$("#authorit_table").html(strr);
							return false;
						 }
					}
				}
			}
			for(var j=0;j<deleteData.length;j++){
				if(authorityArr[i].HIGH_OBJ==deleteData[j].OBJECT_ID){
					var YN=$("input[name=high_obj][value="+authorityArr[i].HIGH_OBJ+"]").parents('tr').children().eq(1).find('input').val();
					var checked=$("input[name=high_obj][value="+authorityArr[i].HIGH_OBJ+"]").parents('tr').children().eq(0).find('input').prop("checked");
					if(checked){
						if(YN=='사용중'){
						 	alert("하위 dept가 활성화되어있습니다.");
						 	$("#authorit_table").empty();
							$("#authorit_table").html(strr);
							return false;
						}else{
							if(checked){
								alert("하위 dept가 활성화되어있습니다.!");
								$("#authorit_table").empty();
								$("#authorit_table").html(strr);
								return false;
							}
							
						}
					}
				}
			}
			
			
		}
		
		var saveData={"insertData":insertData
				     ,"deleteData":deleteData
		  			}
	 	var JsonData=JSON.stringify(saveData);
		console.log(saveData.insertData); 
		console.log(JsonData); 
		if(insertData.length==0&&deleteData.length==0){
			alert("변경된 값이 없습니다.");
			return false;
		}
		$.ajax({ 
			 type: "post", 
			 url : "./authoritySave.ino", 
			 data: JsonData, 
			 dataType:'html',
			 contentType : "application/json; charset=UTF-8",
			 success : function(data) {
				 console.log(data);
				 alert(data);
				 authorityList(group_id,group_name);
				 //location.reload();
				 }, error: function(error) {
					 console.log("error : ");
					 console.log(error);
					 }
				 });	//ajax End
		
		
	})	//sub_btn click End
});

</script>

<style>
#group_table{
	margin-left:10px;
	width:220px;
	height: 450px; 
	border: 1px solid black;
	margin-top:44px;
}

#authorit_table{
	margin-left:20px;
	width:380px;
	height: 450px; 
	border: 1px solid black;
}
th{
	text-align: center;
}
table,tr,td{
	border-bottom: 1px solid black;
	border-collapse: collapse;
	text-align: center;
}
</style>
</head>
<body>

<!--main div  -->
<div id="main_container" style="display: flex;">

	<div id="group_container">
		<h1>GROUP TABLE</h1>
		<div id="group_table" >
			
		</div>
	</div>

	<div id="authorit_container">
	<h1>AUTHORITY TABLE</h1>
	<div align='right'>
	<button id="sub_btn" align='right'>저장</button>
	</div>
		<div id="authorit_table">
		
		</div>
	</div>
</div>

</body>
</html>