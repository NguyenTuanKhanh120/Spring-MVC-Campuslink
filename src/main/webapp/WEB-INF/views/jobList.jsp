<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách công việc của sinh viên</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .search-form {
            margin-bottom: 20px;
            text-align: center;
        }
        .search-form input[type="text"] {
            padding: 8px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .search-form input[type="submit"] {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-form input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Danh sách công việc của sinh viên</h2>

    <!-- Form tìm kiếm -->
    <div class="search-form">
        <form action="/sinhvien/searchJob" method="get">
            <input type="text" name="keyword" placeholder="Nhập số CMND hoặc họ tên" value="${param.keyword}">
            <input type="submit" value="Tìm kiếm">
        </form>
    </div>

    <!-- Bảng hiển thị kết quả -->
    <table>
        <thead>
            <tr>
                <th>Số CMND</th>
                <th>Họ Tên</th>
                <th>Thông tin tốt nghiệp</th>
                <th>Thông tin công việc</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${results}">
                <tr>
                    <td>${result[0]}</td>
                    <td>${result[1]}</td>
                    <td>${result[2]}</td>
                    <td>${result[3]}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty results}">
                <tr>
                    <td colspan="4" style="text-align: center;">Không tìm thấy kết quả</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>