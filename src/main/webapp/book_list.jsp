<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书列表</title>
    <style>
        body{padding:20px;}
        table{border-collapse:collapse;width:90%;margin:20px auto;}
        th,td{border:1px solid #ccc;padding:8px;text-align:center;}
        th{background:#4CAF50;color:white;}
        a{margin:0 5px;text-decoration:none;color:#069;}
        .add{display:block;margin:0 auto;width:120px;text-align:center;background:#4CAF50;color:white;padding:6px;border-radius:4px;}
    </style>
</head>
<body>
<h2 align="center">图书信息列表</h2>
<a href="book_add.jsp" class="add">添加新图书</a>
<table>
    <tr>
        <th>图书ID</th><th>书名</th><th>作者</th><th>出版社</th><th>出版年份</th><th>库存</th><th>总册数</th><th>操作</th>
    </tr>
    <%
        // ========== 关键修改：改成你实际的数据库信息 ==========
        String driver = "com.mysql.cj.jdbc.Driver";
        // 把 infodb 改成你自己的数据库名（实验3用的是infodb）
        String url = "jdbc:mysql://localhost:3306/infodb?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
        String user = "root"; // 你的数据库账号
        String password = "123456"; // 你的数据库密码
        // ====================================================

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try{
            Class.forName(driver);
            conn = DriverManager.getConnection(url, user, password);
            stmt = conn.createStatement();
            String sql = "SELECT * FROM books";
            rs = stmt.executeQuery(sql);
            while(rs.next()){
    %>
    <tr>
        <td><%=rs.getInt("book_id")%></td>
        <td><%=rs.getString("title")%></td>
        <td><%=rs.getString("author")%></td>
        <td><%=rs.getString("publisher")%></td>
        <td><%=rs.getString("publish_year")%></td>
        <td><%=rs.getInt("stock")%></td>
        <td><%=rs.getInt("total_copies")%></td>
        <td>
            <a href="book_edit.jsp?book_id=<%=rs.getInt("book_id")%>">修改</a>
            <a href="book_delete.jsp?book_id=<%=rs.getInt("book_id")%>" onclick="return confirm('确定删除？')">删除</a>
        </td>
    </tr>
    <%
            }
        }catch(Exception e){
            out.print("查询失败："+e.getMessage());
        }finally{
            try{if(rs!=null)rs.close();if(stmt!=null)stmt.close();if(conn!=null)conn.close();}catch(SQLException e){}
        }
    %>
</table>
</body>
</html>