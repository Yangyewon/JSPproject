<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@page import="java.util.*,java.io.*"%>
<%@page import="java.sql.*"%>
<%@ page import="java.security.MessageDigest" %>


<%@ include file="../WEB-INF/include/DB.jsp"%>

<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	//error �޽��� ���͸�
	
	if ( id.toUpperCase().contains("UTL_INADDR.GET_HOST_NAME") 
		|| id.toUpperCase().contains("UTL_INADDR.GET_HOST_ADDRESS") || id.toUpperCase().contains("CTXSYS.DRITHSX.SN")){
		out.println("<script>alert('SQL Injection�� �Ұ��մϴ�.');history.back();</script>");
		return;
	}

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
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	ResultSet countRS = null;
	
	try{
		conn = DriverManager.getConnection(jdbc_url, "JSP", "JSP");
		stmt = conn.createStatement();
		
		String sql = "select * from members where id = '"+id+"' and pw = '"+pw+"'";
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){ 
			id = rs.getString("ID");
			String name = rs.getString("NAME");
			int fail = rs.getInt("fail_count");

			if (fail == 0){
				out.println("<script>alert('5ȸ �̻� ������ �α����� �Ұ��մϴ�. �����ڿ��� �����ϼ���');location.href='../front/main.jsp';</script>");
			} else {
				session.setAttribute("user_id", id);
				session.setAttribute("user_name", name);
				//session.setMaxInactiveInterval(120);
				response.sendRedirect("../front/login_success.jsp"); // �������̵�
			}
		
			//String sqlUpdate = "update members set fail_count = 5 where id ='"+id+"'";
			//stmt.executeUpdate(sqlUpdate);
			
			
		} else{ // �α��� ����
			int failCount = 0;
			String sqlCount = "select fail_count from members where id = '"+id+"'";
			countRS = stmt.executeQuery(sqlCount);
			if(countRS.next()) {
				failCount = countRS.getInt("fail_count");
			}
			if (failCount == 0) {
				out.println("<script>alert('5ȸ �̻� ������ �α����� �Ұ��մϴ�. �����ڿ��� �����ϼ���');location.href='../front/main.jsp';</script>");
			} else {
				failCount--;
				String sqlUpdate = "update members set fail_count = "+failCount+" where id = '" + id + "'";
				stmt.executeUpdate(sqlUpdate);
				response.sendRedirect("../front/login_fail.jsp"); // ���� ������
			}
		}
	} catch(Exception e){
		//out.println(e.toString());
		//e.printStackTrace();
		response.sendRedirect("../front/login.jsp"); // ������ �� ��쵵 �����̷�Ʈ
	} finally{
		try{
			rs.close();
			stmt.close();
			conn.close();
		} catch(Exception e){
			//out.println(e.toString());
			e.printStackTrace();
		}
	}
 %>