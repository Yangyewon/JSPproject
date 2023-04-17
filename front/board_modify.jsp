<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import = "java.sql.*" %>
<%@ include file="../WEB-INF/include/header.jsp" %>
<%@ include file="../WEB-INF/include/DB.jsp" %>

<%

 //�Ķ����
 String SUBJECT = request.getParameter("subject");
 String WRITER = request.getParameter("writer");
 String CONTENTS = request.getParameter("contents");
 String PASSWORD ="";
 String NUM = request.getParameter("num");
 String FILENAME ="";
 String ORIGINAL ="";

 if(NUM == null || NUM == " "){
  NUM = "1";
  response.sendRedirect("../front/board_list2.jsp");
 }
 //num�� ���ڷ� 
 int num = Integer.parseInt(NUM);
 
 
 Class.forName(jdbc_driver);
 
 //TRY~CATCH��
 try{
  Connection conn = DriverManager.getConnection(jdbc_url,"JSP","JSP");
  Statement stmt = conn.createStatement();
  
  String sql = "SELECT subject, writer, contents, password, filename, original FROM board2 WHERE num="+NUM;
  ResultSet rs = stmt.executeQuery(sql);
  
  if(rs.next()){
   SUBJECT = rs.getString(1);
   WRITER = rs.getString(2);
   CONTENTS = rs.getString(3);
   FILENAME = rs.getString(5);
   ORIGINAL = rs.getString(6);
  }
  
 //DB ����
 rs.close();
 stmt.close();
 conn.close();
 
 }catch(SQLException e){
  out.println(e.toString());
 }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <title>�Խ��� ����</title>
    <!--  CSS ���� -->
    <style type="text/css">
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
    </style>

    <!-- �ڹ� ��ũ��Ʈ ���� -->
    <script type="text/javascript">
        function BoardModifyCheck() {
            var subject = document.getElementById('subject');
            var password = document.getElementById('password');
            var contents = document.getElementById('contents');

            if (subject.value == "") {
                alert("������ �Է��ϼ���!");
                subject.focus();
                return false;
            }

            if (password.value == "") {
                alert("�н����带 �Է��ϼ���!");
                password.focus();
                return false;
            }
            if (contents.value == "") {
                alert("������ �Է��ϼ���!");
                contents.focus();
                return false;
            }
        }
    </script>
</head>

<body>
    <div class="board-modify-page">
        <main class="board-modify">
            <form name="BoardModifyForm" method="post" action="../back/boardmodify_ok.jsp?num=<%=NUM%>" onsubmit="return BoardModifyCheck()">
                <table class="modify-table" border="1" summary="�� �����ϱ�">
                    <caption class="modify-caption"><b>�� �����ϱ�</b></caption>
                    <colgroup>
                        <col width=100 />
                        <col width=500 />
                    </colgroup>

                    <tbody>
                        <tr>
                            <th align="center">����</th>
                            <td>
                                <input type="text" id="subject" name="subject" maxlength=50 value="<%=SUBJECT %>" />
                            </td>
                        </tr>
                        <tr>
                            <th align="center">�ۼ���</th>
                            <td><%=WRITER %></td>
                        </tr>
                        <tr>
                            <th align="center">��й�ȣ</th>
                            <td>
                                <input type="password" id="password" name="password" maxlength=50 value="<%=PASSWORD %>" />
                            </td>
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
                            <td colspan="2">
                                <textarea class="content" rows=15 cols=85 id="contents" name="contents"><%=CONTENTS %></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="button-group-modify">
                    <input class="button is-primary" type="submit" value="����" />
                    <input class="button is-primary" type="button" value="���" onclick="history.back(-1)">
                    <div>
            </form>
        </main>
    </div>
</body>

</html>

<style type="text/css">
    .board-modify-page {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .board-modify {
        width: 1000px;
    }

    .modify-table {
        margin-top: 150px;
        border-radius: 5px;
        width: 100%
    }

    .modify-caption {
        margin-bottom: 15px;
        font-size: 24px;
        font-weight: bolder;
    }

    .modify-button-group {
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
        width: 100%
    }

    .button-group-modify {
        margin-top: 5px;
        width: 100%;
        display: flex;
        justify-content: flex-end;
        gap: 2px;
    }
</style>