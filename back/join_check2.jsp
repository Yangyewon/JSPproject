<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>

<%
	request.setCharacterEncoding("euc-kr");

	String ID = request.getParameter("ID");
	String PW = request.getParameter("PW");
	String NAME = request.getParameter("NAME");
	String PHONE1 = request.getParameter("PHONE1");
	String PHONE2 = request.getParameter("PHONE2");
	String PHONE3 = request.getParameter("PHONE3");
	String GENDER = request.getParameter("GENDER");
	
	// 1.변수선언
	String uid = "JSP";
	String upw = "JSP"; 
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "insert into members values(?, ?, ?, ?, ?, ?, ?)";
	
	try{
		// 1. 드라이버 로드
		Class.forName(jdbc_driver);
		
		// 2. conn 생성
		conn = DriverManager.getConnection(jdbc_url, uid, upw);
		
		// 3. pstmt 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, ID);
		pstmt.setString(2, PW);
		pstmt.setString(3, NAME);
		pstmt.setString(4, PHONE1);
		pstmt.setString(5, PHONE2);
		pstmt.setString(6, PHONE3);
		pstmt.setString(7, GENDER);
		
		// 4. sql문 실행
		int result = pstmt.executeUpdate();
		
		if(result == 1){ // 성공
			response.sendRedirect("../front/join_success.jsp");
		} else{ // 실패
			response.sendRedirect("../front/join_fail.jsp");
		}
		
	} catch(Exception e){
		e.printStackTrace();
	} finally{
		try{
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	}
%>