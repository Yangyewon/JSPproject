<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>
<%
	// 1. id���� ���ǿ��� ����ϴ�.
	String id = (String)session.getAttribute("user_id");
    
	String uid = "JSP";
	String upw = "JSP";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "delete from members where id = ?";
	
	try{
		// ����̹� ȣ��
		Class.forName(jdbc_driver);
		// conn ����
		conn = DriverManager.getConnection(jdbc_url, uid, upw);
		// pstmt ����
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// sql ����
		int result = pstmt.executeUpdate();
		
		if(result == 1){ // ����
			session.invalidate(); // ���ǿ� ��������
			//out.println("<script>alert('������ �����Ǿ����ϴ�');</script>");
			response.sendRedirect("../front/login.jsp");			
		} else{ // ����
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