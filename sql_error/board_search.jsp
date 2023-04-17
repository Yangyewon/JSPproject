<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ include file="../WEB-INF/include/header.jsp" %>
<%@ include file="../WEB-INF/include/DB.jsp" %>


<%
	request.setCharacterEncoding("euc-kr");  
	String searchtype = request.getParameter("searchtype");
	String searchtext = request.getParameter("searchtext");
	
	// union 대소문자 필터링
	if (searchtext.matches("(?i).*union.*")) {
		out.println("<script>alert('UNION SQL Injection은 불가합니다.');history.back();</script>");
		return;
	}
	
	// 초기화
	Connection conn = null;
	Statement stmt = null;
	Class.forName(jdbc_driver);

  try{
    
	conn = DriverManager.getConnection(jdbc_url,"JSP","JSP");
    stmt = conn.createStatement();

    String sql = "SELECT NUM, SUBJECT, WRITER, CONTENTS, HIT, ORIGINAL, to_char(REG_DATE, 'YYYY-MM-DD') FROM BOARD2 ";
	
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
	
<table border="0" summary="게시판 검색">
<caption class="search-caption">검색 조회 결과</caption>

 <colgroup>
  <col width="100"  />
  <col width="300" />
  <col width="100" />
  <col width="100" />
  <col width="70"  />
 </colgroup>
 
 <thead class="table-th">
  <tr>
   <th>번호</th>
   <th>제목</th>
   <th>작성자</th>
   <th>등록일시</th>
   <th>조회수</th>
  </tr>
 </thead>
 
 <tbody>
 
 <%
   while(rs.next()){
    int NUM = rs.getInt(1);
    String SUBJECT = rs.getString(2);
    String WRITER = rs.getString(3);
    String REG_DATE = rs.getString(7);
    int HIT = rs.getInt(5); 
 %>
	 
 <tr>
  <td align="center"><%=NUM %></td>
  <td align="center"><a href="../front/board_view.jsp?num=<%=NUM %>"> <%=SUBJECT %> </a></td>
  <td align="center"><%=WRITER %></td>
  <td align="center"><%=REG_DATE %></td>
  <td align="center"><%=HIT %></td>
 </tr>
 
 <%
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


 <div class="to-login-block-search">
  <%if(session.getAttribute("user_id") != null) {%>
  <input type="submit" class="button is-primary" value="글쓰기" onclick="gourl('../front/board_write.jsp');"/>
  <%}
  else { %>
	<a href="../front/login.jsp">로그인 후 글 작성이 가능합니다</a>
	<%}%>
  <input type="button" class="button is-primary" value="목록" onclick="gourl('../front/board_list2.jsp');"/>
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
	margin: 80px 0 15px 0;
	font-size: 24px;
	font-weight: bolder;
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