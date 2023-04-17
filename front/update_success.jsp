<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>	
<%@ include file="/WEB-INF/include/header.jsp" %>

<%
	/*
	1. 폼에서 넘어온 데이터를 각각 처리합니다.
	2. SQL문을 이용해서 DB에 업데이트 작업.
	3. executeUpdate() 성공시 1을 반환, 실패시 0을 반환
	4. 업데이트가 성공하면 세션에 저장된 이름을 변경한 후에
		update_success.jsp로 리다이렉트
		
	      업데이트에 실패하면, update_fail.jsp로 리다이렉트
	*/
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("ID");
	String pw = request.getParameter("PW");
	String name = request.getParameter("NAME");
	String phone1 = request.getParameter("PHONE1");
	String phone2 = request.getParameter("PHONE2");
	String phone3 = request.getParameter("PHONE3");
	String gender = request.getParameter("GENDER");
    //DB연결에 필요한 변수 선언
	String url = "jdbc:oracle:thin:@localhost:1521/XE";
	String uid = "JSP";
	String upw = "JSP";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "update members set pw = ?, name = ?, phone1 = ?, phone2 = ?, phone3 = ?, gender = ?"
			   + "where id = ?";
	
	try{
		// 드라이버 호출
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		// conn 생성
		conn = DriverManager.getConnection(url, uid, upw);
		
		// pstmt 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pw);
		pstmt.setString(2, name);
		pstmt.setString(3, phone1);
		pstmt.setString(4, phone2);
		pstmt.setString(5, phone3);
		pstmt.setString(6, gender);
		pstmt.setString(7, id);
		
		int result = pstmt.executeUpdate();
		
		if(result == 1){
			session.setAttribute("user_name", name);
			
			response.sendRedirect("../back/update_success.jsp");
		} else{
			response.sendRedirect("../back/update_fail.jsp");
		}
	} catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("../back/update_fail.jsp");
	} finally{
		try{
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	}
%>