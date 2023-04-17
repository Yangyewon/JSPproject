<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ include file="../WEB-INF/include/header.jsp" %>
<%@ include file="../WEB-INF/include/DB.jsp" %>


<%
	request.setCharacterEncoding("euc-kr");  
	String searchtype = request.getParameter("searchtype");
	String searchtext = request.getParameter("searchtext");
	
	// union, error ���͸�
	if (searchtext.matches("(?i).*union.*") || searchtext.toUpperCase().contains("UTL_INADDR.GET_HOST_NAME") || searchtext.toUpperCase().contains("UTL_INADDR.GET_HOST_ADDRESS") || searchtext.toUpperCase().contains("CTXSYS.DRITHSX.SN")){
		out.println("<script>alert('SQL Injection�� �Ұ��մϴ�.');history.back();</script>");
		return;
	}
  //blind ���͸�
  if (searchtext.matches("(?i).*substr.*") || searchtext.matches("(?i).*ascii.*")
  || searchtext.matches(".*[<>].*"))  {
    out.println("<script>alert('Blind Injection�� ���͸� �Ǿ��ֽ��ϴ�.');history.back();</script>");
    return;
}
	
	// �ʱ�ȭ
	Connection conn = null;
	Statement stmt = null;
	Class.forName(jdbc_driver);

  try{
    conn = DriverManager.getConnection(jdbc_url,"JSP","JSP");
    stmt = conn.createStatement();
	

    String sql = "SELECT NUM, SUBJECT, WRITER, CONTENTS, HIT, ORIGINAL, to_char(REG_DATE, 'YYYY-MM-DD') FROM BOARD2 ";
	//out.print(searchtext);
	
	if(searchtype.equals("subject")){
        sql += "WHERE SUBJECT LIKE '%" + searchtext + "%' ";
      } else if(searchtype.equals("writer")){
        sql += "WHERE WRITER LIKE '%" + searchtext + "%' ";
      } else if(searchtype.equals("content")){
        sql += "WHERE CONTENTS LIKE '%" + searchtext + "%' ";
      } else {
		response.sendRedirect("../front/board_list2.jsp");
	  }

    sql += "ORDER BY NUM DESC";

    ResultSet rs = stmt.executeQuery(sql);
	
%>	

 <!-- JAVA SCRIPT -->
<script type="text/javascript">
 function gourl(url){
  location.href=url;
 }
</script>
<div class="search-page">

	

	<div class="search-table">
	
	
	
<table border="0" summary="�Խ��� �˻�">
<div class="search-top">
<div>
	
</div>
<div class="search-caption">�˻� ��ȸ ���</div>
<div class="search-result-form">
		<form  name="searchForm" method="get" action="../sql_blind/board_search.jsp">
			
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
</div>


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
	int count = 0; 
   while(rs.next()){
    int NUM = rs.getInt(1);
    String SUBJECT = rs.getString(2);
    String WRITER = rs.getString(3);
    String REG_DATE = rs.getString(7);
    int HIT = rs.getInt(5); 
	count += 1;
 %>
	 
 <tr>
  <td align="center"><%=NUM %></td>
  <td align="center"><a href="../front/board_view.jsp?num=<%=NUM %>"> <%=SUBJECT %> </a></td>
  <td align="center"><%=WRITER %></td>
  <td align="center"><%=REG_DATE %></td>
  <td align="center"><%=HIT %></td>
 </tr>
 
 <% 
   } if (count==0){%>
	<td> </td>
    <td align="center"> �˻��� �Խù��� �����ϴ�.</td>
	<td> </td>
	<td> </td>
	<td> </td>
  <% }
  rs.close();
  stmt.close();
  conn.close();
  }catch(SQLException e){
   out.println(e.toString());
  }
 %>
 
 </tbody>

</table>


 <div class="to-login-block-search">
  <%if(session.getAttribute("user_id") != null) {%>
  <input type="submit" class="button is-primary" value="�۾���" onclick="gourl('../front/board_write.jsp');"/>
  <%}
  else { %>
	<a href="../front/login.jsp">�α��� �� �� �ۼ��� �����մϴ�</a>
	<%}%>
  <input type="button" class="button is-primary" value="���" onclick="gourl('../front/board_list2.jsp');"/>
  </div>
  </div>
  </div>
</body>
</html>
<style type="text/css">
.search-page {
	display:flex;
	flex-direction: column;
	align-items: center;
}
.search-table {
  width: 1000px;
}
.to-login-block-search {
	margin-top: 10px;
	text-align: right;
	width: 100%;
}
.search-caption{
	/* margin: 80px 0 15px 0; */
	font-size: 24px;
	font-weight: bolder;
}
.search {
	width: 100%;
	display:flex;
	justify-content: flex-end;
}
.search-top {
	display: flex;
	justify-content: flex-end;
	margin: 35px 0 20px 0;
}


.search-result-form {
	display: flex;
	margin-left: 24px;
}


#table {
   border-radius: 5px;
}


table th {
	color: white;
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
</style>