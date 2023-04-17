<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>
<%
	// 1. id값은 세션에서 얻습니다.
	String id = (String)session.getAttribute("user_id");
    
	String uid = "JSP";
	String upw = "JSP";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "delete from members where id = ?";
	
	try{
		// 드라이버 호출
		Class.forName(jdbc_driver);
		// conn 생성
		conn = DriverManager.getConnection(jdbc_url, uid, upw);
		// pstmt 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// sql 실행
		int result = pstmt.executeUpdate();
		
		if(result == 1){ // 성공
			session.invalidate(); // 세션에 정보삭제
			//out.println("<script>alert('계정이 삭제되었습니다');</script>");
			response.sendRedirect("../front/login.jsp");			
		} else{ // 실패
			response.sendRedirect("../front/login_success.jsp");
		}
		
	} catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("../front/login_success.jsp");
	} finally{
		try{
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	}
%>