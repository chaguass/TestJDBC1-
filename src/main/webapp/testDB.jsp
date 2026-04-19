<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>图书借阅管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft YaHei", sans-serif;
        }

        body {
            background-color: #f5f7fa;
            padding: 40px 20px;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .title {
            text-align: center;
            font-size: 26px;
            color: #2c3e50;
            margin-bottom: 25px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        th {
            background-color: #3498db;
            color: white;
            padding: 14px;
            font-size: 15px;
            text-align: center;
        }

        td {
            padding: 13px;
            text-align: center;
            border-bottom: 1px solid #eee;
            color: #34495e;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .success {
            color: #27ae60;
            text-align: center;
            margin-bottom: 15px;
            font-size: 16px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">📚 图书借阅记录查询</div>
    <p class="success">✅ 数据加载成功</p>

    <table>
        <tr>
            <th>借阅编号</th>
            <th>读者姓名</th>
            <th>图书名称</th>
            <th>借阅日期</th>
            <th>应还日期</th>
        </tr>

        <%
            String driver = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/infodb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            String username = "root";
            String password = "123456";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName(driver);
                conn = DriverManager.getConnection(url, username, password);

                String sql = "SELECT br.record_id, r.name, b.title, br.borrow_date, br.due_date " +
                        "FROM borrow_records br " +
                        "JOIN readers r ON br.reader_id = r.reader_id " +
                        "JOIN books b ON br.book_id = b.book_id";

                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int recordId = rs.getInt("record_id");
                    String readerName = rs.getString("name");
                    String bookTitle = rs.getString("title");
                    String borrowDate = rs.getString("borrow_date");
                    String dueDate = rs.getString("due_date");
        %>
        <tr>
            <td><%= recordId %></td>
            <td><%= readerName %></td>
            <td><%= bookTitle %></td>
            <td><%= borrowDate %></td>
            <td><%= dueDate %></td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <tr>
            <td colspan="5" style="color:red;">⚠️ 查询失败：<%= e.getMessage() %></td>
        </tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        %>
    </table>
</div>

</body>
</html>