<%@ page pageEncoding="euc-kr"%>

<%
	String user_id = (String)session.getAttribute("user_id");
	String user_name = (String)session.getAttribute("user_name");
%>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
</head>

<nav id="nav" class="navbar" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
        <a class="navbar-item" href="../front/main.jsp">
            <img src="../front/logo.PNG" width="112" height="28">
        </a>

        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
            <span aria-hidden="true"></span>
            <span aria-hidden="true"></span>
            <span aria-hidden="true"></span>
        </a>
    </div>

    <div class="navbar-menu">
        <div class="navbar-start start">
            <a class="navbar-item header-board" href="../front/board_list2.jsp">게시판</a>
            <div class="navbar-item has dropdown is-hoverable">
                <a class="navbar-link header-menu">SQLI</a>
                <div class="navbar-dropdown">
                    <a class="navbar-item" href="../front/board_list2.jsp">
                        UNION
                    </a>
                    <a class="navbar-item" href="../sql_error/board_list2.jsp">
                        ERROR
                    </a>
                    <a class="navbar-item" href="../sql_blind/board_list2.jsp">
                        BLIND
                    </a>
                </div>
            </div>
            <div class="navbar-item has dropdown is-hoverable">
                <a class="navbar-link header-menu">XSS</a>
                <div class="navbar-dropdown">
                    <!--그냥되는거-->
                    <a class="navbar-item" href="../front/board_write.jsp">
                        Stored XSS
                    </a>
                    <!-- 그냥되는거-->
                    <a class="navbar-item" href="../front/board_list2.jsp">
                        Reflected XSS
                    </a>
                    <!-- stored 막기 위해 입력값, 출력값 필터링 -->
                    <a class="navbar-item" href="../xss_stored/board_list2.jsp"> 
                        Secure ver.1 
                    </a>
                    <!-- reflected 막기 위해 입력값, 출력값 필터링 -->
                    <a class="navbar-item" href="../xss_reflected/board_list2.jsp"> 
                        Secure ver.2
                    </a>
                </div>
            </div>
        </div>

        <div class="navbar-end">
            <div class="navbar-item">
                <%if(session.getAttribute("user_id") != null) {%>
                <div><%=user_name %>(<%=user_id %>)님 안녕하세요 &nbsp; &nbsp;</div>
                <div class="buttons">
                    <a class="button is-primary" href="../back/logout.jsp">
                        <strong>Logout</strong>
                    </a>
                </div>
                <%}
                else {%>
                <div class="buttons">
                    <a class="button is-primary" href="../front/login.jsp">
                        <strong>Sign in</strong>
                    </a>
                    <a class="button is-light" href="../front/join.jsp">
                        <strong>Sign up</strong>
                    </a>
                </div>
                <%}%>
            </div>
        </div>
</nav>
<style type="text/css">
a {
	text-decoration: none;
}

.navbar {
	margin-top: 10px;
}

.header-board {
	font-weight: bold;
   
}
.start {
	display: flex;
	align-items: center;
}
.header-menu{
    font-weight: bold;
}


</style>