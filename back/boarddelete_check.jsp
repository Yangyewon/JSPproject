<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import = "java.sql.*"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>

<%
 request.setCharacterEncoding("euc-kr");
 
 String PASS = request.getParameter("password");
 String NUM = request.getParameter("num"); //null
 String PASSWORD = null;
 
 Class.forName(jdbc_driver);
 
 if(NUM == null){
  NUM = "1";
 }
 int num = Integer.parseInt(NUM);
 
 try{
  Connection conn = DriverManager.getConnection(jdbc_url,"JSP", "JSP");
  Statement stmt = conn.createStatement();
  String sql = "SELECT password FROM board2 WHERE num="+NUM;
  ResultSet rs = stmt.executeQuery(sql);
  System.out.println(PASS);
  if(rs.next()){
   PASSWORD = rs.getString(1);
   System.out.println(PASSWORD);
  }
  if(PASSWORD.equals(PASS)){
   sql = "DELETE FROM board2 WHERE num="+NUM;
   stmt.executeUpdate(sql);
%>
	
<script type="text/javascript">
    self.window.alert("해당글을 삭제 하였습니다.");
    location.href = "../front/board_list2.jsp";
</script>

<% 
 rs.close();
 stmt.close();
 conn.close();
  } else{
%>
	
<script type="text/javascript">
    self.window.alert("비밀번호를 잘못 입력하였습니다.");
    location.href = "../front/board_delete.jsp";
</script>

<%
  }
 }catch(SQLException e){
  out.println(e.toString());
 }
%>