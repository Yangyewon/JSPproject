<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ include file="../WEB-INF/include/header.jsp" %>

<%
 //NULL값 체크 후 처리
 String NUM = request.getParameter("num");
 if(NUM == null || NUM == " "){ //num값이 없을경우 처리 -> list 보내줌
  NUM = "1";
  response.sendRedirect("../front/board_list2.jsp");
 }
 //num을 숫자로 
 int num = Integer.parseInt(NUM);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <title class="title">글 삭제하기</title>
    <!-- CSS 영역 -->


    <!-- 자바스크립트 -->
    <script type="text/javascript">
        function DeleteCheck() {
            var password = document.getElementById('password');

            if (password.value == " ") {
                alert("비밀번호를 입력하세요!!");
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
        <div class="delete-board">글 삭제하기</div>
        <form name="DeleteForm" method="post" action="../back/boarddelete_check.jsp" onsubmit="return DeleteCheck()">
            <!-- GET 방식 -->

            <input type="hidden" id="num" name="num" value="<%=num %>" />

            <table border="1" summary="게시판 삭제 폼">

                <colgroup>
                    <col width="100px" />
                    <col width="500px" />
                </colgroup>
                <tbody>
                    <tr>
                        <th align="center">비밀번호</th>
                        <td><input type="password" id="password" name="password" size="20" maxlength="50"></td>
                    </tr>
                </tbody>
            </table>

            <div class="button-group-delete">
                <input class="button is-primary" type="submit" value="삭제" />
                <input class="button is-primary" type="button" value="취소" onclick="history.back(-1)" />
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