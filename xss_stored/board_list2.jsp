<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="euc-kr"%>
<%@ page import="java.sql.*"%>
<%@ include file="../WEB-INF/include/header.jsp" %>
<%@ include file="../WEB-INF/include/DB.jsp" %>

<%
 //�ʱ�ȭ
 Connection conn = null;
 Statement stmt = null;
 int total = 0;
 
 Class.forName(jdbc_driver);
 
 try{
  conn = DriverManager.getConnection(jdbc_url,"JSP","JSP");
  stmt = conn.createStatement();
  
  
  String sqlCount ="SELECT COUNT(*) FROM board2";
  ResultSet rs = stmt.executeQuery(sqlCount);
  
  if(rs.next()){
   total = rs.getInt(1);
  }
   rs.close();
  
   String sqlList = "SELECT NUM, SUBJECT, WRITER, CONTENTS, HIT, ORIGINAL, to_char(REG_DATE, 'YYYY-MM-DD'), MOD_DATE FROM BOARD2 ORDER BY NUM DESC";
   rs = stmt.executeQuery(sqlList);
%>
	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>�Խ��� ���</title>
<!-- CSS  -->
<style type="text/css">
 * {font size:9pt;}
 p {width: 600px; text-align:right;}
 table therd tr td {background-color:gray;}
</style>
<!-- JAVA SCRIPT -->
<!-- ��ũ -->
<script type="text/javascript">
 function gourl(url){
  location.href=url;
 }
</script>
</head>
<body>

<!-- �˻���  -->
	<div class="board-page">
		<div class="board">
			<div class="search">
			<form class="search-form" name="searchForm" method="get" action="../back/board_search.jsp">
			
			<div class="select">
			  <select name="searchtype">
			   <option value="subject">����</option>
			   <option value="writer">�ۼ���</option>
			   <option value="content">����</option>
			  </select>
			</div>
			  <input class="input" type="text" name="searchtext" value=""/>
			  <button class="button is-light">�˻�</button>
		
			</form>
			</div>
		

			<!-- �Խ��� ����Ʈ -->
		
			<table id="table" border="1" summary="�Խ��� ���">
		
			 <colgroup>
			  <col width="100"  />
			  <col width="300" />
			  <col width="100" />
			  <col width="100" />
			  <col width="70"  />
			 </colgroup>
			 
			 <thead class="table-th">
			  <tr>
			   <th>��ȣ</th>
			   <th>����</th>
			   <th>�ۼ���</th>
			   <th>����Ͻ�</th>
			   <th>��ȸ��</th>
			  </tr>
			 </thead>
			 
			 <tbody>
			 <%
			  if(total==0){
			 %>
			  <tr>
			   <td align="center" colspan="5">��ϵ� �Խù��� �����ϴ�.</td>
			  </tr>
			 <%
			  } else {
			   while(rs.next()){
				int NUM = rs.getInt(1);
				String SUBJECT = rs.getString(2);
				String WRITER = rs.getString(3);
				String REG_DATE = rs.getString(7);
				int HIT = rs.getInt(5);
			 %>
			 <tr>
			  <td align="center"><%=NUM %></td>
			  <td align="center"><a href="../xss_stored/board_view.jsp?num=<%=NUM %>">

			  <%=SUBJECT %></a></td>
			  <td align="center"><%=WRITER %></td>
			  <td align="center"><%=REG_DATE %></td>
			  <td align="center"><%=HIT %></td>
			 </tr>
			 <%
			   }
			  }
			  rs.close();
			  stmt.close();
			  conn.close();
			  }catch(SQLException e){
			   out.println(e.toString());
			  }
			 %>
			 </tbody>
			
			</table>

			  <div class="to-login-block">
			  <%if(session.getAttribute("user_id") != null) {%>
			  <button class="button is-primary" onclick="gourl('../front/board_write.jsp');">�۾���</button>
			  <%}
			  else { %>
				
				<a class="to-login" href="../front/login.jsp">�α��� �� �� �ۼ��� �����մϴ�</a>
				</div>	
			  <%}%>
		 </div>
	 </div>
</body>
</html>
<style type="text/css">
.board-page {
	display:flex;
	flex-direction: column;
	align-items: center;
}

#table {
   border-radius: 5px;
}


table th {
	color: white;
}

.board {
	display:flex;
	flex-direction: column;
	align-items: center;
	margin-top: 80px;
}

.search {
	width: 100%;
	display:flex;
	justify-content: flex-end;
}

.search-form {
	display:flex;
	gap: 3px;
}

table {
  width: 1000px;
  border-collapse: collapse; 
  border: 1px #a39485 solid;
}

.table-th {
	text-align: center;
}
  
thead {
  font-weight: bold;
  background: #00d1b2;
}

th {
  padding: 1em .5em;
  vertical-align: middle;
  color: white;
}

td, th {
  border: 1px lightgray solid;
}
  
 td {
  padding: 0.5em .5em;
  vertical-align: middle;
    background: #fff;
 }

a {
  color: #00d1b2;
}

.to-login {
	color: gray;	
}

.to-login:hover {
	filter: brightness(50%);
}


.to-login-block {
	margin-top: 10px;
	text-align: right;
	width: 100%;
}
  
</style>
