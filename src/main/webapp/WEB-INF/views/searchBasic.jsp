<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm cơ bản</title>
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
    </style>
</head>
<body>
    <h2>Tìm kiếm cơ bản</h2>

    <!-- Form tìm kiếm -->
    <div class="search-form">
        <form action="/sinhvien/searchBasic" method="post">
            <input type="text" name="keyword" placeholder="Nhập số CMND hoặc họ tên" value="${param.keyword}">
            <input type="submit" value="Tìm kiếm">
        </form>
    </div>

    <!-- Bảng hiển thị kết quả -->
    <c:if test="${not empty sinhViens}">
        <table>
            <thead>
                <tr>
                    <th>Số CMND</th>
                    <th>Họ Tên</th>
                    <th>Email</th>
                    <th>Số Điện Thoại</th>
                    <th>Địa Chỉ</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="sinhVien" items="${sinhViens}">
                    <tr>
                        <td>${sinhVien.soCMND}</td>
                        <td>${sinhVien.hoTen}</td>
                        <td>${sinhVien.email}</td>
                        <td>${sinhVien.soDT}</td>
                        <td>${sinhVien.diaChi}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty sinhViens and not empty param.keyword}">
        <p style="text-align: center;">Không tìm thấy sinh viên</p>
    </c:if>
</body>
</html>