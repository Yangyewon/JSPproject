<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>	
<%@ include file="/WEB-INF/include/header.jsp" %>

<%
	/*
	1. ������ �Ѿ�� �����͸� ���� ó���մϴ�.
	2. SQL���� �̿��ؼ� DB�� ������Ʈ �۾�.
	3. executeUpdate() ������ 1�� ��ȯ, ���н� 0�� ��ȯ
	4. ������Ʈ�� �����ϸ� ���ǿ� ����� �̸��� ������ �Ŀ�
		update_success.jsp�� �����̷�Ʈ
		
	      ������Ʈ�� �����ϸ�, update_fail.jsp�� �����̷�Ʈ
	*/
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("ID");
	String pw = request.getParameter("PW");
	String name = request.getParameter("NAME");
	String phone1 = request.getParameter("PHONE1");
	String phone2 = request.getParameter("PHONE2");
	String phone3 = request.getParameter("PHONE3");
	String gender = request.getParameter("GENDER");
    //DB���ῡ �ʿ��� ���� ����
	String url = "jdbc:oracle:thin:@localhost:1521/XE";
	String uid = "JSP";
	String upw = "JSP";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "update members set pw = ?, name = ?, phone1 = ?, phone2 = ?, phone3 = ?, gender = ?"
			   + "where id = ?";
	
	try{
		// ����̹� ȣ��
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		// conn ����
		conn = DriverManager.getConnection(url, uid, upw);
		
		// pstmt ����
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