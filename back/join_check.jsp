<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@page import="java.util.*,java.io.*"%>
<%@page import = "java.sql.*"%>
<%@page import="java.security.MessageDigest"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>


<%
	request.setCharacterEncoding("euc-kr");
//입력 값 가져오기
	String ID = request.getParameter("ID");
	String PW = request.getParameter("PW");
	String NAME = request.getParameter("NAME");
	String PHONE1 = request.getParameter("PHONE1");
	String PHONE2 = request.getParameter("PHONE2");
	String PHONE3 = request.getParameter("PHONE3");
	String GENDER = request.getParameter("GENDER");
	
	String input = "yang"+PW+"yang";
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hash = md.digest(input.getBytes("euc-kr"));
    StringBuffer hexString = new StringBuffer();
    for (int i = 0; i < hash.length; i++) {
        String hex = Integer.toHexString(0xff & hash[i]);
        if (hex.length() == 1) hexString.append('0');
        hexString.append(hex);
    }
    PW = "hihihi"+hexString.toString();

	
	try{
		Connection conn = DriverManager.getConnection(jdbc_url,"JSP","JSP");
		Statement stmt = conn.createStatement();
		
		String sql = "insert into members (ID, PW, NAME, PHONE1, PHONE2, PHONE3, GENDER)";
		sql+="values('"+ ID +"', '"+ PW +"','" + NAME + "','" + PHONE1 + "','" + PHONE2 + "' ,'" + PHONE3+ "','" + GENDER + "')";
		
		int result = stmt.executeUpdate(sql);
		
		if(result == 1){ //성공시
			response.sendRedirect("../front/join_success.jsp");
		} else{ //실패시
			response.sendRedirect("../front/join_fail.jsp");
		}
		stmt.close();
		conn.close();
		
	} catch(SQLException e){
		out.println(e.toString());
	}
%>