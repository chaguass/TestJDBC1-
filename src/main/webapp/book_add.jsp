<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加图书</title>
    <style>body{padding:20px;}.form{width:400px;margin:0 auto;}input{width:100%;margin:8px 0;padding:6px;}</style>
</head>
<body>
<h2 align="center">添加图书信息</h2>
<div class="form">
    <form action="book_add.jsp" method="post">
        书名：<input type="text" name="title" required><br>
        作者：<input type="text" name="author" required><br>
        出版社：<input type="text" name="publisher" required><br>
        出版年份：<input type="text" name="publish_year" required><br>
        库存：<input type="number" name="stock" required><br>
        <input type="submit" value="添加图书">
    </form>
</div>

<%
    // 处理POST提交
    if("POST".equals(request.getMethod())){
        // ========== 关键：补全数据库连接变量 ==========
        String driver = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/infodb?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
        String user = "root";
        String password = "123456";
        // =============================================

        Connection conn = null;
        PreparedStatement pstmt = null;
        try{
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            String publish_year = request.getParameter("publish_year");
            int stock = Integer.parseInt(request.getParameter("stock"));

            Class.forName(driver);
            conn = DriverManager.getConnection(url, user, password);
            // 修正SQL语法：6个占位符对应6个字段
            String sql = "INSERT INTO books(title,author,publisher,publish_year,stock,total_copies) VALUES(?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, author);
            pstmt.setString(3, publisher);
            pstmt.setString(4, publish_year);
            pstmt.setInt(5, stock);
            pstmt.setInt(6, stock); // 总册数=库存
            pstmt.executeUpdate();

            // 添加成功跳回列表
            response.sendRedirect("book_list.jsp");
        }catch(Exception e){
            out.print("添加失败："+e.getMessage());
        }finally{
            try{if(pstmt!=null)pstmt.close();if(conn!=null)conn.close();}catch(SQLException e){}
        }
    }
%>
</body>
</html>