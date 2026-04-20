<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<html>
<head>
    <title>可借阅书籍列表</title>
    <style>
        /* 全局样式重置 */
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
        /* 标题和按钮区域 */
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .header h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 28px;
        }
        .add-btn {
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
        .add-btn:hover {
            background-color: #66b1ff;
        }
        /* 卡片网格布局 */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }
        /* 卡片样式 */
        .book-card {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }
        .book-card:hover {
            box-shadow: 0 4px 20px rgba(0,0,0,0.12);
            transform: translateY(-5px);
        }
        /* 卡片内信息排版 */
        .book-id {
            text-align: right;
            color: #909399;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .book-title {
            font-size: 20px;
            font-weight: bold;
            color: #303133;
            margin-bottom: 20px;
        }
        .book-info {
            margin-bottom: 12px;
            color: #606266;
            font-size: 14px;
            display: flex;
            justify-content: space-between;
        }
        .info-label {
            color: #909399;
        }
        /* 库存标签样式 */
        .stock-tag {
            background-color: #67C23A;
            color: white;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: bold;
        }
        .empty-tip {
            text-align: center;
            color: #909399;
            font-size: 18px;
            padding: 50px 0;
            grid-column: 1 / -1;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>可借阅书籍列表</h1>
        <!-- 按钮直接跳转到实验4的新增图书页面，和原有功能联动 -->
        <a href="book_add.jsp" class="add-btn">➕ 添加新书</a>
    </div>

    <div class="book-grid">
        <%
            // 从request域中获取Servlet传递的数据
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null && !books.isEmpty()) {
                for (Book book : books) {
        %>
        <div class="book-card">
            <div class="book-id">ID: <%= book.getBookId() %></div>
            <div class="book-title"><%= book.getTitle() %></div>
            <div class="book-info">
                <span class="info-label">作者:</span>
                <span><%= book.getAuthor() %></span>
            </div>
            <div class="book-info">
                <span class="info-label">出版社:</span>
                <span><%= book.getPublisher() %></span>
            </div>
            <div class="book-info">
                <span class="info-label">出版年份:</span>
                <span><%= book.getPublishYear() %></span>
            </div>
            <div class="book-info">
                <span class="info-label">库存:</span>
                <span class="stock-tag"><%= book.getStock() %></span>
            </div>
            <div class="book-info">
                <span class="info-label">总副本数:</span>
                <span><%= book.getTotalCopies() %></span>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="empty-tip">暂无可借阅图书</div>
        <% } %>
    </div>
</div>
</body>
</html>