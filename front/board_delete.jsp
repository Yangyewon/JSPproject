<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/header.jsp" %>

<%
 //NULL�� üũ �� ó��
 String NUM = request.getParameter("num");
 if(NUM == null || NUM == " "){ //num���� ������� ó�� -> list ������
  NUM = "1";
  response.sendRedirect("../front/board_list2.jsp");
 }
 //num�� ���ڷ� 
 int num = Integer.parseInt(NUM);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <title class="title">�� �����ϱ�</title>
    <!-- CSS ���� -->


    <!-- �ڹٽ�ũ��Ʈ -->
    <script type="text/javascript">
        function DeleteCheck() {
            var password = document.getElementById('password');

            if (password.value == " ") {
                alert("��й�ȣ�� �Է��ϼ���!!");
                password.focus();
                return false;
            } else {
                return true;
            }
        }
    </script>
</head>

<body>
    <div class="delete-page">
        <div class="delete-board">�� �����ϱ�</div>
        <form name="DeleteForm" method="post" action="../back/boarddelete_check.jsp" onsubmit="return DeleteCheck()">
            <!-- GET ��� -->

            <input type="hidden" id="num" name="num" value="<%=num %>" />

            <table border="1" summary="�Խ��� ���� ��">

                <colgroup>
                    <col width="100px" />
                    <col width="500px" />
                </colgroup>
                <tbody>
                    <tr>
                        <th align="center">��й�ȣ</th>
                        <td><input type="password" id="password" name="password" size="20" maxlength="50"></td>
                    </tr>
                </tbody>
            </table>

            <div class="button-group-delete">
                <input class="button is-primary" type="submit" value="����" />
                <input class="button is-primary" type="button" value="���" onclick="history.back(-1)" />
            </div>
    </div>
    </form>
</body>

</html>

<style type="text/css">
    .delete-page {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 60vh;
    }

    .delete-board {
        margin-bottom: 15px;
        font-size: 24px;
        font-weight: bolder;
    }

    th {
        padding: 0.5em .5em;
    }

    table td {
        vertical-align: middle;
        padding: 0.5em .5em;
    }

    .button-group-delete {
        margin-top: 5px;
        width: 100%;
        display: flex;
        justify-content: flex-end;
        gap: 2px;
    }

    <style>