<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../WEB-INF/include/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> �Խ��� �۾��� </title>
<!-- �ڹ� ��ũ��Ʈ -->
<script type="text/javascript">
//url
 function gourl(url){
  location.href=url;
 }

//��ȿ�� üũ
 function BoardWriteChk(){
  var sub= document.getElementById('subject');
  var wri= document.getElementById('writer');
  var pass= document.getElementById('password');
  var cont= document.getElementById('contents');
  
  if(sub.value == "" || sub.value == null){
   alert("������ �Է� �Ͻʽÿ�");
   sub.focus();
   return false;
  }
  
  if(pass.value == "" || pass.value == null){
   alert("������ ���� ��й�ȣ�� �Է��ϼ���");
   pass.focus();
   return false;
  }
  
  if(cont.value == "" || cont.value == null){
   alert("������ �Է��ϼ���");
   cont.focus();
   return false;
  }
  subject.submit();
 }
</script>
<!-- CSS -->
<style type="text/css">
 * {font size:9pt;}
 p {width: 600px; text-align:right;}
 table therd tr td {background-color:gray;}
</style>
</head>
<body>
<div class="board-write-page">
	<main class="board-write">
<!-- �Խ��� �۾��� -->
<form name="BoardWrite" action="../xss_stored/boardwrite_ok.jsp" method="post" enctype="multipart/form-data" onsubmit="return BoardWriteChk();" >
<table class="write-table" border="1" summary="�Խ��� ��� ��">
<caption class="write-caption">�Խ��� ���</caption>
 <colgroup>
  <col width="100"/>
  <col width="500"/>
 </colgroup>
 
 <tbody>
  <tr>
   <th align="center">����</th>
   <td><input type="text" id="subject" name="SUBJECT" maxlength="50" value=""/></td>
  </tr>
  <tr>
   <th align="center">�ۼ���</th>
   <td><%=user_name%></td>
  </tr>
  <tr>
   <th align="center">��й�ȣ</th>
   <td><input type="password" id="password" name="PASSWORD" maxlength="50" value=""/></td>
  </tr>
    <tr>
   <th align="center">����</th>
   <td><input type="file" name="file"></td>
  </tr>
  <tr>
   <td colspan="2"><textarea class="content" id="contents" name="CONTENTS" rows="15" cols="75"></textarea></td>
  </tr>
 </tbody>
</table>
  <div class="write-button-group">
	  <input class="button is-primary" type="button" value="���" onclick="gourl('../front/board_list2.jsp');"/>
	  <input class="button is-primary"  type="submit" value="���" onclick="gourl('../back/boardwrite_ok.jsp');"/>
	  <input class="button is-primary" type="reset" value="���" onclick="javascript:history.back(-1);"/>
 </div>

</form>
</main>
</div>
</body>
</html>

<style type="text/css">
.board-write-page {
	display:flex;
	flex-direction: column;
	align-items: center;
}
.board-write {
	width: 1000px;
}
.write-table {
	margin-top: 150px;
	border-radius: 5px;
	width: 100%
}

.write-caption {
	margin-bottom: 15px;
	font-size: 24px;
	font-weight: bolder;
}
.write-button-group {
	margin-top: 5px;
	width: 100%;
	display:flex;
	justify-content: flex-end;
	gap: 2px;
}
th {
  padding: 0.5em .5em;
}
table td {
  vertical-align: middle;
  padding: 0.5em .5em;
}
.content {
    vertical-align: top;
	padding: 8px;
	width: 100%
}

.button-group-write {
	margin-top: 5px;
	width: 100%;
	display:flex;
	justify-content: flex-end;
	gap: 2px;
}
</style>