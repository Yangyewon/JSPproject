<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@page import="java.util.*,java.io.*"%>
<%@page import="java.sql.*"%>
<%@ page import="java.security.MessageDigest" %>


<%@ include file="../WEB-INF/include/DB.jsp"%>

<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	//error 메시지 필터링
	
	if ( id.toUpperCase().contains("UTL_INADDR.GET_HOST_NAME") 
		|| id.toUpperCase().contains("UTL_INADDR.GET_HOST_ADDRESS") || id.toUpperCase().contains("CTXSYS.DRITHSX.SN")){
		out.println("<script>alert('SQL Injection은 불가합니다.');history.back();</script>");
		return;
	}

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
				out.println("<script>alert('5회 이상 오류로 로그인이 불가합니다. 관리자에게 문의하세요');location.href='../front/main.jsp';</script>");
			} else {
				session.setAttribute("user_id", id);
				session.setAttribute("user_name", name);
				//session.setMaxInactiveInterval(120);
				response.sendRedirect("../front/login_success.jsp"); // 페이지이동
			}
		
			//String sqlUpdate = "update members set fail_count = 5 where id ='"+id+"'";
			//stmt.executeUpdate(sqlUpdate);
			
			
		} else{ // 로그인 실패
			int failCount = 0;
			String sqlCount = "select fail_count from members where id = '"+id+"'";
			countRS = stmt.executeQuery(sqlCount);
			if(countRS.next()) {
				failCount = countRS.getInt("fail_count");
			}
			if (failCount == 0) {
				out.println("<script>alert('5회 이상 오류로 로그인이 불가합니다. 관리자에게 문의하세요');location.href='../front/main.jsp';</script>");
			} else {
				failCount--;
				String sqlUpdate = "update members set fail_count = "+failCount+" where id = '" + id + "'";
				stmt.executeUpdate(sqlUpdate);
				response.sendRedirect("../front/login_fail.jsp"); // 실패 페이지
			}
		}
	} catch(Exception e){
		//out.println(e.toString());
		//e.printStackTrace();
		response.sendRedirect("../front/login.jsp"); // 에러가 난 경우도 리다이렉트
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