<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("euc-kr"); %>
<%@ include file="../WEB-INF/include/DB.jsp" %>

<%

 /* �Ķ���� */
 //NULL �� üũ �� �ຯȯ
 String NUM = request.getParameter("num");
 String PASSWORD = null;
 
 //NULL�� üũ �� ó��
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
  
  /* ���� �н������ �� */
  if(PASSWORD.equals(pass)){
   sql = "UPDATE board2 SET subject='"+ subject +"', contents='"+ contents +"' WHERE num="+NUM;
   stmt.executeUpdate(sql);
%>
 <script type="text/javascript">
  self.window.alert("���� �����Ǿ����ϴ�.");
  location.href="../front/board_view.jsp?num=<%=NUM %>"; 
 </script>
<%
 //DB ����
 rs.close();
 stmt.close();
 conn.close();
  } else {
%>
 <script type="text/javascript">
  self.window.alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
  history.back(-1);
 </script>  
<%
  }
 }catch(SQLException e){
  out.println(e.toString());
 }
%>