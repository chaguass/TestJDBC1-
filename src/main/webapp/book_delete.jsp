<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // ========== 1. 定义数据库变量（放在最顶部） ==========
    String driver = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/infodb?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
    String user = "root";
    String password = "123456";

    // 2. 获取要删除的图书ID
    int book_id = Integer.parseInt(request.getParameter("book_id"));

    // 3. 数据库删除操作
    Connection conn = null;
    PreparedStatement pstmt = null;
    try{
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, password);
        String sql = "DELETE FROM books WHERE book_id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, book_id);
        pstmt.executeUpdate();

        // 跳回列表页
        response.sendRedirect("book_list.jsp");
    }catch(Exception e){
        out.print("删除失败："+e.getMessage());
    }finally{
        // 关闭资源
        try{if(pstmt!=null)pstmt.close();if(conn!=null)conn.close();}catch(SQLException e){}
    }
%>