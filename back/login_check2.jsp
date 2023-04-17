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
    
	//�ؽð� ����
	String input = "yang"+pw+"yang";
	MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hash = md.digest(input.getBytes("UTF-8"));
	//�Ʒ� ������ ���� StringBuffer�� ����
	StringBuffer hexString = new StringBuffer();
	
	//����Ʈ �迭 ������ �ؽð��� 16���� ���ڿ��� ��ȯ
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
		// ����̹� ȣ��
		Class.forName(jdbc_driver);
		
		// conn ����
		conn = DriverManager.getConnection(jdbc_url, uid, upw);
		
		// pstmt ����
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		
		// sql����
		rs = pstmt.executeQuery();
		
		if(rs.next()){ // �α��� ����(������ ���� session)
			id = rs.getString("ID");
			String name = rs.getString("NAME");
		
			session.setAttribute("user_id", id);
			session.setAttribute("user_name", name);
			
			response.sendRedirect("../front/login_success.jsp"); // �������̵�
			
		} else{ // �α��� ����
			response.sendRedirect("../front/login_fail.jsp"); // ���� ������
		}
	} catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("../front/login.jsp"); // ������ �� ��쵵 �����̷�Ʈ
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