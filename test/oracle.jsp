<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="EUC-KR">

<title>Oracle Connection Test</title>

</head>

<body>

<%@ page import="java.sql.*" %>

<h2> '��Ĺ +  Oracle' ���� TEST.. </h2>

<%

        try{

                String driverName="oracle.jdbc.driver.OracleDriver";

                String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";

                Class.forName(driverName);

                Connection conn = DriverManager.getConnection(dbURL,"JSP","JSP");

                out.println("Oracle Database �� ���� ����!");

                conn.close();

        }catch(Exception e){

                out.println("Oracle Database �� ���� ����!!");

                out.println(e.getMessage());

                e.printStackTrace();

        }

%>

</body>

</html>