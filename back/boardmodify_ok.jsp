<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("euc-kr"); %>
<%@ include file="../WEB-INF/include/DB.jsp" %>

<%

 /* 파라미터 */
 //NULL 값 체크 후 행변환
 String NUM = request.getParameter("num");
 String PASSWORD = null;
 
 //NULL값 체크 후 처리
 if(NUM == null){
  NUM = "1";
 }
 int num = Integer.parseInt(NUM);
  
 
 String subject = request.getParameter("subject");
 String contents = request.getParameter("contents");
 String pass = request.getParameter("password");
 
 Class.forName(jdbc_driver);
 
 try{

   Connection conn = DriverManager.getConnection(jdbc_url,"JSP", "JSP");
   Statement stmt = conn.createStatement();
   String sql = "SELECT password FROM board2 WHERE num="+NUM;
   ResultSet rs = stmt.executeQuery(sql);
   
  if(rs.next()){
   PASSWORD = rs.getString(1);
  }
  
  /* 기존 패스워드와 비교 */
  if(PASSWORD.equals(pass)){
   sql = "UPDATE board2 SET subject='"+ subject +"', contents='"+ contents +"' WHERE num="+NUM;
   stmt.executeUpdate(sql);
%>
 <script type="text/javascript">
  self.window.alert("글이 수정되었습니다.");
  location.href="../front/board_view.jsp?num=<%=NUM %>"; 
 </script>
<%
 //DB 종료
 rs.close();
 stmt.close();
 conn.close();
  } else {
%>
 <script type="text/javascript">
  self.window.alert("비밀번호가 틀렸습니다.");
  history.back(-1);
 </script>  
<%
  }
 }catch(SQLException e){
  out.println(e.toString());
 }
%>