<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ include file="../WEB-INF/include/header.jsp" %>
<%@ include file="../WEB-INF/include/DB.jsp" %>
<%@ page import="java.io.PrintWriter"%>
<%
String NUM = request.getParameter("num");

Class.forName(jdbc_driver);

try{
 Connection conn = DriverManager.getConnection(jdbc_url,"JSP","JSP");
 Statement stmt = conn.createStatement();

 String sql = "SELECT subject, writer, contents, hit, reg_date, filename, original FROM board2 WHERE num="+NUM;
 ResultSet rs = null;
 rs = stmt.executeQuery(sql);
   
 if(rs.next()){ //resultset�� ����� select�� ���� ����� ������� 1�྿ �ѱ�
  String SUBJECT = rs.getString(1); //�ش� ������ ���� �ִ� �����͸� String������ �޾ƿ�
  String WRITER = rs.getString(2);
  String CONTENTS = rs.getString(3);
  int HIT = rs.getInt(4);
  String REG_DATE = rs.getString(5);
  String FILENAME = rs.getString(6);
  String ORIGINAL = rs.getString(7);
  HIT++;
  
  //��ȸ�� ����
  sql = "UPDATE board2 SET hit= "+ HIT +"WHERE num= "+ NUM;
  stmt.executeUpdate(sql);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>�Խ��� �󼼺���</title>
</head>

<body>
    <div class="board-view-page">
        <main class="board-view">
            <table class="view-table" border="1" summary="�Խ��� �󼼳���">
                <caption class="view-caption"><b>�Խ��� �󼼳���</b></caption>
                <colgroup>
                    <col width="130px" />
                    <col width="500px" />
                </colgroup>

                <tbody>

                    <tr>
                        <th align="center">�۹�ȣ</th>
                        <td><%=NUM %></td>
                    </tr>

                    <tr>
                        <th align="center">����</th>
                        <td><%=SUBJECT %></td>
                    </tr>

                    <tr>
                        <th align="center">�ۼ��� / ��ȸ</th>
                        <td><%=WRITER %> / <%=HIT %></td>
                    </tr>

                    <tr>
                        <th align="center">÷������</th>
                        <% 
						  if (FILENAME == null || ORIGINAL == null) { 
						%>
                        <td>÷������ ����</td>
                        <% 
						} else { %>
                        <td><a href="../upload/<%=FILENAME%>" download=""><%=ORIGINAL%></a></td>
                        <% }%>
                    </tr>

                    <tr>
                        <td class="content" colspan="2" height="200px"><%=CONTENTS %></td>
                    </tr>
                </tbody>
            </table>
            <div class="button-group">
                <button class="button is-primary" value="���" onclick="window.location='../front/board_list2.jsp'" />���</button>
                <%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(WRITER)) {%>
                    <button class="button is-primary" onclick="window.location='../front/board_modify.jsp?num=<%=NUM %>'">����</button>
                <%}
                  else if(session.getAttribute("user_id") != null) {%>
                    <button class="button is-primary" onclick="alert('������ �����ϴ�.')">����</button>	
                <%}
                  else { %>
                    <button class="button is-primary" onclick="alert('������ �����ϴ�.')">����</button>
                <%}%>

                <%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(WRITER)) {%>
                    <button class="button is-primary" onclick="window.location='../front/board_delete.jsp?num=<%=NUM %>'">����</button>
                <%}
                  else if(session.getAttribute("user_id") != null) {%>
                    <button class="button is-primary" onclick="alert('������ �����ϴ�.')">����</button>	
                <%}
                  else { %>
                    <button class="button is-primary" onclick="alert('������ �����ϴ�.')">����</button>
                <%}%>
            </div>
        </main>
    </div>
    <% 
 rs.close();
 }
 stmt.close();
 conn.close();
 } catch(SQLException e){
  out.println("DB����"+e.toString());
 }
%>
</body>

</html>

<style type="text/css">
    .board-view-page {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .board-view {
        width: 1000px;
    }

    .view-table {
        margin-top: 150px;
        border-radius: 5px;
        width: 100%
    }

    .view-caption {
        margin-bottom: 15px;
        font-size: 24px;
        font-weight: bolder;
    }

    .button-group {
        margin-top: 5px;
        width: 100%;
        display: flex;
        justify-content: flex-end;
        gap: 2px;
    }

    th {
        padding: 0.5em .5em;
    }

    table td {
        vertical-align: middle;
        padding: 0.5em .5em;
    }

    .content {
        vertical-align: top;
        padding: 8px;
    }

    * {
        font size: 9pt;
    }

    p {
        width: 600px;
        text-align: right;
    }

    table thead tr td {
        background-color: gray;
    }

    a:LINK {
        color: #646464;
    }

    a:ACTIVE {
        color: #646464;
    }

    a:HOVER {
        color: #646464;
    }
</style>