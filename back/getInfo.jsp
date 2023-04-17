<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>
 
 
<%
	// 정보수정 화면으로 가기전에
	// 아이디 기준으로 회원정보를 조회해서 다음 화면으로 전달
	
	String user_id = (String)session.getAttribute("user_id");
    	//DB연결에 필요한 변수 선언
	String uid = "JSP";
	String upw = "JSP";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from members where id = ?";
	
	try{
		// 드라이버 호출
		Class.forName(jdbc_driver);
		
		// conn 생성
		conn = DriverManager.getConnection(jdbc_url, uid, upw);
		
		// pstmt 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		// sql실행
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			user_id = rs.getString("ID");
			String name = rs.getString("NAME");
			String phone1 = rs.getString("PHONE1");
			String phone2 = rs.getString("PHONE2");
			String phone3 = rs.getString("PHONE3");
			String gender = rs.getString("GENDER");
			
			// 포워드로 전달하기 위해
			request.setAttribute("ID", user_id);
			request.setAttribute("NAME", name);
			request.setAttribute("PHONE1", phone1);
			request.setAttribute("PHONE2", phone2);
			request.setAttribute("PHONE3", phone3);
			request.setAttribute("GENDER", gender);
			
			// 포워드 이동
			request.getRequestDispatcher("../front/update.jsp").forward(request, response);
			
		} else{ // 세션이 만료된 경우
			response.sendRedirect("../front/login.jsp");
		}
	} catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("../front/login.jsp");
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