<%@ page language="java" import="java.sql.*, java.io.*, java.text.*, java.lang.*, java.util.*, java.net.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../WEB-INF/include/DB.jsp" %>

<%
    String FILENAME = "";
    String ORIGINAL = "";
    String num = request.getParameter("num");
    String FILEPATH = request.getParameter("file");
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    InputStream in = null;
    OutputStream os = null;
    File file = null;
    boolean skip = false;
    String client = "";

    try {
        Class.forName(jdbc_driver);
        conn = DriverManager.getConnection(jdbc_url, "JSP", "JSP");
        stmt = conn.createStatement();
        request.setCharacterEncoding("UTF-8");

        String sql = "SELECT FILENAME, ORIGINAL FROM board2 WHERE num=" + num;
        rs = stmt.executeQuery(sql);
        String savePath = URLDecoder.decode(FILEPATH,"UTF-8");

        if (rs.next()) {
            FILENAME = rs.getString(1);
            ORIGINAL = rs.getString(2);

            String filename = FILENAME;
            // 실제 내보낼 파일명
            String orgfilename = ORIGINAL;

            

            file = new File(savePath);
            in = new FileInputStream(savePath);

            client = request.getHeader("User-Agent");
            // 파일 다운로드 헤더 지정
            response.reset();
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Description", "JSP Generated Data");

            if (!skip) {
                if (client.indexOf("MSIE") != -1) {
                    response.setHeader("Content-Disposition",
                            "attachment; filename=" + new String(orgfilename.getBytes("KSC5601"), "ISO8859_1"));
                } else {
                    // 한글 파일명 처리
                    orgfilename = new String(orgfilename.getBytes("utf-8"), "iso-8859-1");

                    response.setHeader("Content-Disposition", "attachment; filename=\"" + orgfilename + "\"");
                    response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
                }

                response.setHeader("Content-Length", "" + file.length());

                os = response.getOutputStream();
                byte b[] = new byte[(int) file.length()];
                int leng = 0;

                while ((leng = in.read(b)) > 0) {
                    os.write(b, 0, leng);
                }

            } else {
                response.setContentType("text/html;charset=UTF-8");
                out.println("<script language='javascript'>alert('파일을 찾을 수 없습니다');history.back();</script>");
            }

            in.close();
            os.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>