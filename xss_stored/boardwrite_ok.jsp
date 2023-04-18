<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.*,java.io.*"%>
<%@page import = "java.sql.*"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>

<%
	String user_id = (String)session.getAttribute("user_id");
%>

<%
 //for upload
 String saveFolder = application.getRealPath("/upload") ;
 String encType = "euc-kr";
 int maxSize = 5 * 1024 * 1024;
  
 MultipartRequest multi = null;
 multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());

 
 Class.forName(jdbc_driver);
 
 String SUBJECT  = multi.getParameter("SUBJECT");
 String CONTENTS   = multi.getParameter("CONTENTS");
 String PASSWORD   = multi.getParameter("PASSWORD");
 String FILENAME = multi.getFilesystemName("file");
 String ORIGINAL = multi.getOriginalFileName("file");

 
CONTENTS = CONTENTS
 .replaceAll("<", "&lt;")
 .replaceAll(">", "&gt;")
 .replaceAll("\\(", "&#40;")
 .replaceAll("\\)", "&#41;")
 .replaceAll("'", "&#39;")
 .replaceAll("\"", "&#34;");
 .replaceAll("\\r?\\n", "<br>");

SUBJECT = SUBJECT
 .replaceAll("<", "&lt;")
 .replaceAll(">", "&gt;")
 .replaceAll("\\(", "&#40;")
 .replaceAll("\\)", "&#41;")
 .replaceAll("'", "&#39;")
 .replaceAll("\"", "&#34;");
 .replaceAll("\\r?\\n", "<br>");


 if (FILENAME == null)
 {
	 FILENAME="";
	 ORIGINAL="";
 }
 
 
 try{
  Connection conn = DriverManager.getConnection(jdbc_url,"JSP","JSP");
  Statement stmt = conn.createStatement();

  String sql  = "INSERT INTO board2(NUM, SUBJECT, WRITER, CONTENTS, REG_DATE, PASSWORD, FILENAME, ORIGINAL)";
  sql += "VALUES(board2_seq.NEXTVAL,'" + SUBJECT + "', '"+ user_id +"','"+CONTENTS+"', sysdate,'"+PASSWORD+"','"+FILENAME+"','"+ORIGINAL+"')";
  stmt.executeUpdate(sql);
  
  stmt.close();
  conn.close();
 } catch(SQLException e){
  out.println(e.toString());
 }
 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	alert("게시물이 작성되었습니다.");
	location.href="../xss_stored/board_list2.jsp";
</script>
</head>
</html>
