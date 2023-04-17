<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="EUC-KR">

<title>Oracle Connection Test</title>

</head>

<body>

<%@ page import="java.sql.*" %>

<h2> '톰캣 +  Oracle' 연결 TEST.. </h2>

<%

        try{

                String driverName="oracle.jdbc.driver.OracleDriver";

                String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";

                Class.forName(driverName);

                Connection conn = DriverManager.getConnection(dbURL,"JSP","JSP");

                out.println("Oracle Database 에 접속 성공!");

                conn.close();

        }catch(Exception e){

                out.println("Oracle Database 에 접속 오류!!");

                out.println(e.getMessage());

                e.printStackTrace();

        }

%>

</body>

</html>