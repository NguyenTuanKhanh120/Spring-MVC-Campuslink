<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhập thông tin công việc</title>
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
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            padding: 10px;
        }
        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            text-align: center;
        }
        .message {
            color: green;
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Nhập thông tin công việc</h2>

    <div class="form-container">
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>

        <form action="/congviec/save" method="post">
            <div class="form-group">
                <label for="soCMND">Số CMND:</label>
                <input type="text" id="soCMND" name="soCMND" required>
            </div>
            <div class="form-group">
                <label for="maNganh">Mã Ngành:</label>
                <select id="maNganh" name="maNganh" required>
                    <option value="">Chọn ngành</option>
                    <c:forEach var="nganh" items="${nganhs}">
                        <option value="${nganh.maNganh}">${nganh.tenNganh}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="ngayVaoCongTy">Ngày Vào Công Ty (yyyy-MM-dd):</label>
                <input type="date" id="ngayVaoCongTy" name="ngayVaoCongTy" required>
            </div>
            <div class="form-group">
                <label for="tenCongTy">Tên Công Ty:</label>
                <input type="text" id="tenCongTy" name="tenCongTy">
            </div>
            <div class="form-group">
                <label for="diaChiCongTy">Địa Chỉ Công Ty:</label>
                <input type="text" id="diaChiCongTy" name="diaChiCongTy">
            </div>
            <div class="form-group">
                <label for="thoiGianLamViec">Thời Gian Làm Việc:</label>
                <input type="text" id="thoiGianLamViec" name="thoiGianLamViec">
            </div>
            <div class="form-group">
                <input type="submit" value="Lưu Thông Tin">
            </div>
        </form>
    </div>
</body>
</html>