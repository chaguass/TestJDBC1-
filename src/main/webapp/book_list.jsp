<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="dao.BookDaoImpl" %>
<html>
<head>
    <title>图书管理列表</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft YaHei", sans-serif;
        }
        body {
            background-color: #f5f7fa;
            padding: 30px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .header h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 28px;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-bottom: 20px;
        }
        .btn {
            background-color: #409EFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #66b1ff;
        }
        .btn-success {
            background-color: #67C23A;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        th {
            background-color: #409EFF;
            color: white;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .operate a {
            margin: 0 5px;
            color: #409EFF;
            text-decoration: none;
        }
        .operate a:hover {
            color: #66b1ff;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>图书管理列表</h1>
        <div class="btn-group">
            <!-- 原有：添加新书按钮 -->
            <a href="book_add.jsp" class="btn">➕ 添加新书</a>
            <!-- 新增：跳转到实验5 可借阅图书页面 -->
            <a href="availableBooks" class="btn btn-success">📖 查看可借阅图书</a>
        </div>
    </div>

    <table>
        <tr>
            <th>图书ID</th>
            <th>书名</th>
            <th>作者</th>
            <th>出版社</th>
            <th>出版年份</th>
            <th>库存</th>
            <th>总副本数</th>
            <th>操作</th>
        </tr>
        <%
            // 调用新增的findAllBook方法
            BookDaoImpl dao = new BookDaoImpl();
            List<Book> list = dao.findAllBook();
            if (list != null && !list.isEmpty()) {
                for (Book book : list) {
        %>
        <tr>
            <td><%= book.getBookId() %></td>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            <td><%= book.getPublisher() %></td>
            <td><%= book.getPublishYear() %></td>
            <td><%= book.getStock() %></td>
            <td><%= book.getTotalCopies() %></td>
            <td class="operate">
                <a href="book_edit.jsp?book_id=<%= book.getBookId() %>">修改</a>
                <a href="book_delete.jsp?book_id=<%= book.getBookId() %>" onclick="return confirm('确定删除？')">删除</a>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</div>
</body>
</html>