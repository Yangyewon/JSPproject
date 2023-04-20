<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ include file="../WEB-INF/include/header.jsp" %>
<%@ include file="../WEB-INF/include/DB.jsp" %>
<%@ page import="java.io.PrintWriter"%>
<%
String NUM = request.getParameter("num");
String CONTENTS_low="";

Class.forName(jdbc_driver);

try{
 Connection conn = DriverManager.getConnection(jdbc_url,"JSP","JSP");
 Statement stmt = conn.createStatement();

 String sql = "SELECT subject, writer, contents, hit, reg_date, filename, original FROM board2 WHERE num="+NUM;
 ResultSet rs = null;
 rs = stmt.executeQuery(sql);
   
 if(rs.next()){ //resultset에 저장된 select문 실행 결과를 행단위로 1행씩 넘김
  String SUBJECT = rs.getString(1); //해당 순서의 열에 있는 데이터를 String형으로 받아옴
  String WRITER = rs.getString(2);
  String CONTENTS = rs.getString(3);
  int HIT = rs.getInt(4);
  String REG_DATE = rs.getString(5);
  String FILENAME = rs.getString(6);
  String ORIGINAL = rs.getString(7);
  HIT++;
  
  //조회수 적용
  sql = "UPDATE board2 SET hit= "+ HIT +"WHERE num= "+ NUM;
  stmt.executeUpdate(sql);
 

  CONTENTS = CONTENTS.replaceAll("\\r?\\n", "<br>");
  SUBJECT = SUBJECT.replaceAll("\\r?\\n", "<br>");
  //CONTENTS = CONTENTS.replaceAll("&lt;p&gt;","<p>");
  //CONTENTS = CONTENTS.replaceAll("&lt;br&gt;","<br>");

  CONTENTS_low = CONTENTS.toLowerCase();

  if(CONTENTS.contains("javascript") || CONTENTS.contains("script")){
    CONTENTS=CONTENTS_low;
    CONTENTS=CONTENTS.replaceAll("javascript","x-javascript");
    CONTENTS=CONTENTS.replaceAll("script", "x-script");
    //out.println("<script>alert('script포함 단어는 불가합니다');history.back();</script>");
  }
    else{
        CONTENTS="";
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>게시판 상세보기</title>
</head>

<body>
    <div class="board-view-page">
        <main class="board-view">
            <table class="view-table" border="1" summary="게시판 상세내용">
                <caption class="view-caption"><b>게시판 상세내용</b></caption>
                <colgroup>
                    <col width="130px" />
                    <col width="500px" />
                </colgroup>

                <tbody>

                    <tr>
                        <th align="center">글번호</th>
                        <td><%=NUM %></td>
                    </tr>

                    <tr>
                        <th align="center">제목</th>
                        <td><%=SUBJECT %></td>
                    </tr>

                    <tr>
                        <th align="center">작성자 / 조회</th>
                        <td><%=WRITER %> / <%=HIT %></td>
                    </tr>

                    <tr>
                        <th align="center">첨부파일</th>
                        <% 
						  if (FILENAME == null || ORIGINAL == null) { 
						%>
                        <td>첨부파일 없음</td>
                        <% 
						} else { %>
                        <td><a href="../back/board_filedown.jsp?num=<%=NUM%>" ><%=ORIGINAL%></a></td>
                        <% }%>
                    </tr>

                    <tr>
                        <td class="content" colspan="2" height="200px"><%=CONTENTS %></td>
                    </tr>
                </tbody>
            </table>
            <div class="button-group">
                <button class="button is-primary" value="목록" onclick="window.location='../xss_stored/board_list2.jsp'" />목록</button>
                <%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(WRITER)) {%>
                    <button class="button is-primary" onclick="window.location='../front/board_modify.jsp?num=<%=NUM %>'">수정</button>
                <%}
                  else if(session.getAttribute("user_id") != null) {%>
                    <button class="button is-primary" onclick="alert('권한이 없습니다.')">수정</button>	
                <%}
                  else { %>
                    <button class="button is-primary" onclick="alert('권한이 없습니다.')">수정</button>
                <%}%>

                <%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(WRITER)) {%>
                    <button class="button is-primary" onclick="window.location='../front/board_delete.jsp?num=<%=NUM %>'">삭제</button>
                <%}
                  else if(session.getAttribute("user_id") != null) {%>
                    <button class="button is-primary" onclick="alert('권한이 없습니다.')">삭제</button>	
                <%}
                  else { %>
                    <button class="button is-primary" onclick="alert('권한이 없습니다.')">삭제</button>
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
  out.println("DB에러"+e.toString());
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