
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhập thông tin sinh viên</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(to right, #e0f7fa, #b2ebf2);
            color: #333;
        }
        h2 {
            text-align: center;
            color: #00695c;
            margin-bottom: 30px;
            font-size: 2em;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        h3 {
            color: #00796b;
            font-size: 1.5em;
            margin-bottom: 15px;
            border-bottom: 2px solid #b0bec5;
            padding-bottom: 5px;
        }
        .form-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            border: 1px solid #b0bec5;
        }
        .form-group {
            margin-bottom: 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }
        .form-group label {
            font-weight: 600;
            color: #37474f;
            flex: 1 1 200px;
            min-width: 150px;
        }
        .form-group input, .form-group select {
            flex: 2 1 300px;
            padding: 10px;
            border: 1px solid #b0bec5;
            border-radius: 5px;
            font-size: 1em;
            transition: border-color 0.3s ease;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #00796b;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 121, 107, 0.2);
        }
        .form-group input[type="submit"], .form-group button {
            background-color: #00796b;
            color: white;
            border: none;
            padding: 12px 25px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .form-group input[type="submit"]:hover, .form-group button:hover {
            background-color: #004d40;
        }
        .form-group button.remove-btn {
            background-color: #e57373;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .form-group button.remove-btn:hover {
            background-color: #d32f2f;
        }
        .error {
            color: #d32f2f;
            text-align: center;
            font-weight: 500;
            margin-bottom: 20px;
        }
        .message {
            color: #388e3c;
            text-align: center;
            font-weight: 500;
            margin-bottom: 20px;
        }
        .section {
            margin-top: 25px;
            padding: 20px;
            background-color: #f5fafa;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }
        .totNghiepEntry, .congViecEntry {
            padding: 15px;
            border: 1px dashed #b0bec5;
            border-radius: 5px;
            margin-bottom: 15px;
            background-color: #fff;
        }
    </style>
</head>
<body>
    <h2>Nhập thông tin sinh viên</h2>

    <div class="form-container">
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>

        <form action="/sinhvien/save" method="post" accept-charset="UTF-8">
            <!-- Thông tin sinh viên -->
            <div class="section">
                <h3>Thông tin sinh viên</h3>
                <div class="form-group">
                    <label for="soCMND">Số CMND:</label>
                    <input type="text" id="soCMND" name="soCMND" required>
                </div>
                <div class="form-group">
                    <label for="hoTen">Họ Tên:</label>
                    <input type="text" id="hoTen" name="hoTen">
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email">
                </div>
                <div class="form-group">
                    <label for="soDT">Số Điện Thoại:</label>
                    <input type="text" id="soDT" name="soDT">
                </div>
                <div class="form-group">
                    <label for="diaChi">Địa Chỉ:</label>
                    <input type="text" id="diaChi" name="diaChi">
                </div>
            </div>

            <!-- Thông tin tốt nghiệp -->
            <div class="section">
                <h3>Thông tin tốt nghiệp</h3>
                <div id="totNghiepFields">
                    <div class="totNghiepEntry">
                        <div class="form-group">
                            <label for="maTruong">Mã Trường:</label>
                            <select name="maTruong[]" required>
                                <option value="">Chọn trường</option>
                                <c:forEach var="truong" items="${truongs}">
                                    <option value="${truong.maTruong}">${truong.tenTruong}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="maNganh">Mã Ngành:</label>
                            <select name="maNganh[]" required>
                                <option value="">Chọn ngành</option>
                                <c:forEach var="nganh" items="${nganhs}">
                                    <option value="${nganh.maNganh}">${nganh.tenNganh}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="heTN">Hệ Tốt Nghiệp:</label>
                            <input type="text" name="heTN[]">
                        </div>
                        <div class="form-group">
                            <label for="ngayTN">Ngày Tốt Nghiệp (yyyy-MM-dd):</label>
                            <input type="date" name="ngayTN[]">
                        </div>
                        <div class="form-group">
                            <label for="loaiTN">Loại Tốt Nghiệp:</label>
                            <input type="text" name="loaiTN[]">
                        </div>
                    </div>
                </div>
                <button type="button" onclick="addTotNghiepField()">Thêm bằng tốt nghiệp</button>
            </div>

            <!-- Thông tin công việc -->
            <div class="section">
                <h3>Thông tin công việc</h3>
                <div id="congViecFields">
                    <div class="congViecEntry">
                        <div class="form-group">
                            <label for="maNganhCV">Mã Ngành Công Việc:</label>
                            <select name="maNganhCV[]">
                                <option value="">Chọn ngành</option>
                                <c:forEach var="nganh" items="${nganhs}">
                                    <option value="${nganh.maNganh}">${nganh.tenNganh}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="ngayVaoCongTy">Ngày Vào Công Ty (yyyy-MM-dd):</label>
                            <input type="date" name="ngayVaoCongTy[]">
                        </div>
                        <div class="form-group">
                            <label for="tenCongTy">Tên Công Ty:</label>
                            <input type="text" name="tenCongTy[]">
                        </div>
                        <div class="form-group">
                            <label for="diaChiCongTy">Địa Chỉ Công Ty:</label>
                            <input type="text" name="diaChiCongTy[]">
                        </div>
                        <div class="form-group">
                            <label for="thoiGianLamViec">Thời Gian Làm Việc:</label>
                            <input type="text" name="thoiGianLamViec[]">
                        </div>
                    </div>
                </div>
                <button type="button" onclick="addCongViecField()">Thêm công việc</button>
            </div>

            <div class="form-group">
                <input type="submit" value="Lưu Thông Tin">
            </div>
        </form>
    </div>

    <script>
        function addTotNghiepField() {
            const container = document.getElementById("totNghiepFields");
            const entry = document.createElement("div");
            entry.className = "totNghiepEntry";
            entry.innerHTML = `
                <div class="form-group">
                    <label for="maTruong">Mã Trường:</label>
                    <select name="maTruong[]" required>
                        <option value="">Chọn trường</option>
                        <c:forEach var="truong" items="${truongs}">
                            <option value="${truong.maTruong}">${truong.tenTruong}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="maNganh">Mã Ngành:</label>
                    <select name="maNganh[]" required>
                        <option value="">Chọn ngành</option>
                        <c:forEach var="nganh" items="${nganhs}">
                            <option value="${nganh.maNganh}">${nganh.tenNganh}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="heTN">Hệ Tốt Nghiệp:</label>
                    <input type="text" name="heTN[]">
                </div>
                <div class="form-group">
                    <label for="ngayTN">Ngày Tốt Nghiệp (yyyy-MM-dd):</label>
                    <input type="date" name="ngayTN[]">
                </div>
                <div class="form-group">
                    <label for="loaiTN">Loại Tốt Nghiệp:</label>
                    <input type="text" name="loaiTN[]">
                </div>
                <button type="button" class="remove-btn" onclick="this.parentElement.remove()">Xóa</button>
            `;
            container.appendChild(entry);
        }

        function addCongViecField() {
            const container = document.getElementById("congViecFields");
            const entry = document.createElement("div");
            entry.className = "congViecEntry";
            entry.innerHTML = `
                <div class="form-group">
                    <label for="maNganhCV">Mã Ngành Công Việc:</label>
                    <select name="maNganhCV[]">
                        <option value="">Chọn ngành</option>
                        <c:forEach var="nganh" items="${nganhs}">
                            <option value="${nganh.maNganh}">${nganh.tenNganh}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="ngayVaoCongTy">Ngày Vào Công Ty (yyyy-MM-dd):</label>
                    <input type="date" name="ngayVaoCongTy[]">
                </div>
                <div class="form-group">
                    <label for="tenCongTy">Tên Công Ty:</label>
                    <input type="text" name="tenCongTy[]">
                </div>
                <div class="form-group">
                    <label for="diaChiCongTy">Địa Chỉ Công Ty:</label>
                    <input type="text" name="diaChiCongTy[]">
                </div>
                <div class="form-group">
                    <label for="thoiGianLamViec">Thời Gian Làm Việc:</label>
                    <input type="text" name="thoiGianLamViec[]">
                </div>
                <button type="button" class="remove-btn" onclick="this.parentElement.remove()">Xóa</button>
            `;
            container.appendChild(entry);
        }
    </script>
</body>
</html>
