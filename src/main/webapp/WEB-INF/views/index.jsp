
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Quản Lý Việc Làm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .menu {
            margin-top: 30px;
        }
        .menu a {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .menu a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Chào mừng đến với Hệ thống Quản Lý Việc Làm</h1>
    <div class="menu">
        <a href="/sinhvien/form">Thêm Sinh Viên</a>
        <a href="/sinhvien/search">Tìm Kiếm Sinh Viên</a>
        <a href="/sinhvien/searchBasic">Tìm Kiếm Cơ Bản</a>
        <a href="/sinhvien/searchJob">Tìm Kiếm Công Việc</a>
    </div>
</body>
</html>