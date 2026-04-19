<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改图书</title>
    <style>body{padding:20px;}.form{width:400px;margin:0 auto;}input{width:100%;margin:8px 0;padding:6px;}</style>
</head>
<body>
<h2 align="center">修改图书信息</h2>
<%
    // ========== 1. 先定义数据库变量（放在最顶部，确保全局可用） ==========
    String driver = "com.mysql.cj.jdbc.Driver";
    // 改成你的数据库名（比如infodb）、账号、密码
    String url = "jdbc:mysql://localhost:3306/infodb?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
    String user = "root";
    String password = "123456";

    // 2. 获取要修改的图书ID
    int book_id = Integer.parseInt(request.getParameter("book_id"));

    // 3. 定义回显用的变量
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String title="",author="",publisher="",publish_year="";
    int stock=0;

    // 4. 数据库查询回显数据
    try{
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();
        String sql = "SELECT * FROM books WHERE book_id="+book_id;
        rs = stmt.executeQuery(sql);
        if(rs.next()){
            title = rs.getString("title");
            author = rs.getString("author");
            publisher = rs.getString("publisher");
            publish_year = rs.getString("publish_year");
            stock = rs.getInt("stock");
        }
    }catch(Exception e){
        out.print("回显失败："+e.getMessage());
    }
%>

<!-- 表单回显数据 -->
<div class="form">
    <form action="book_edit.jsp" method="post">
        <input type="hidden" name="book_id" value="<%=book_id%>">
        书名：<input type="text" name="title" value="<%=title%>" required><br>
        作者：<input type="text" name="author" value="<%=author%>" required><br>
        出版社：<input type="text" name="publisher" value="<%=publisher%>" required><br>
        出版年份：<input type="text" name="publish_year" value="<%=publish_year%>" required><br>
        库存：<input type="number" name="stock" value="<%=stock%>" required><br>
        <input type="submit" value="保存修改">
    </form>
</div>

<%
    // 处理表单提交（修改数据）
    if("POST".equals(request.getMethod())){
        PreparedStatement pstmt = null;
        try{
            // 重新获取表单提交的参数
            int id = Integer.parseInt(request.getParameter("book_id"));
            String t = request.getParameter("title");
            String a = request.getParameter("author");
            String p = request.getParameter("publisher");
            String py = request.getParameter("publish_year");
            int s = Integer.parseInt(request.getParameter("stock"));

            // 重新建立连接（避免之前的连接关闭）
            conn = DriverManager.getConnection(url, user, password);
            String sql = "UPDATE books SET title=?,author=?,publisher=?,publish_year=?,stock=? WHERE book_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,t);
            pstmt.setString(2,a);
            pstmt.setString(3,p);
            pstmt.setString(4,py);
            pstmt.setInt(5,s);
            pstmt.setInt(6,id);
            pstmt.executeUpdate();

            // 跳回列表页
            response.sendRedirect("book_list.jsp");
        }catch(Exception e){
            out.print("修改失败："+e.getMessage());
        }finally{
            // 关闭资源
            try{if(pstmt!=null)pstmt.close();if(conn!=null)conn.close();}catch(SQLException e){}
        }
    }
%>
</body>
</html>