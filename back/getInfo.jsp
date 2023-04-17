<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/DB.jsp" %>
 
 
<%
	// �������� ȭ������ ��������
	// ���̵� �������� ȸ�������� ��ȸ�ؼ� ���� ȭ������ ����
	
	String user_id = (String)session.getAttribute("user_id");
    	//DB���ῡ �ʿ��� ���� ����
	String uid = "JSP";
	String upw = "JSP";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from members where id = ?";
	
	try{
		// ����̹� ȣ��
		Class.forName(jdbc_driver);
		
		// conn ����
		conn = DriverManager.getConnection(jdbc_url, uid, upw);
		
		// pstmt ����
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		// sql����
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			user_id = rs.getString("ID");
			String name = rs.getString("NAME");
			String phone1 = rs.getString("PHONE1");
			String phone2 = rs.getString("PHONE2");
			String phone3 = rs.getString("PHONE3");
			String gender = rs.getString("GENDER");
			
			// ������� �����ϱ� ����
			request.setAttribute("ID", user_id);
			request.setAttribute("NAME", name);
			request.setAttribute("PHONE1", phone1);
			request.setAttribute("PHONE2", phone2);
			request.setAttribute("PHONE3", phone3);
			request.setAttribute("GENDER", gender);
			
			// ������ �̵�
			request.getRequestDispatcher("../front/update.jsp").forward(request, response);
			
		} else{ // ������ ����� ���
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