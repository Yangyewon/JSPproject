<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>
<%@ page import="java.security.MessageDigest" %>

<%
	//request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
    
	//해시값 생성
	String input = "yang"+pw+"yang";
	MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hash = md.digest(input.getBytes("UTF-8"));
	//아래 과정을 위해 StringBuffer로 선언
	StringBuffer hexString = new StringBuffer();
	
	//바이트 배열 형태의 해시값을 16진수 문자열로 변환
	 for (int i = 0; i < hash.length; i++) {
        String hex = Integer.toHexString(0xff & hash[i]);
        if (hex.length() == 1) hexString.append('0');
        hexString.append(hex);
    }
	pw = "hihihi"+hexString.toString();

	String uid = "JSP";
	String upw = "JSP";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from members where id = ? and pw = ?";
	
	try{
		// 드라이버 호출
		Class.forName(jdbc_driver);
		
		// conn 생성
		conn = DriverManager.getConnection(jdbc_url, uid, upw);
		
		// pstmt 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		
		// sql실행
		rs = pstmt.executeQuery();
		
		if(rs.next()){ // 로그인 성공(인증의 수단 session)
			id = rs.getString("ID");
			String name = rs.getString("NAME");
		
			session.setAttribute("user_id", id);
			session.setAttribute("user_name", name);
			
			response.sendRedirect("../front/login_success.jsp"); // 페이지이동
			
		} else{ // 로그인 실패
			response.sendRedirect("../front/login_fail.jsp"); // 실패 페이지
		}
	} catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("../front/login.jsp"); // 에러가 난 경우도 리다이렉트
	} finally{
		try{
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	}
 %>