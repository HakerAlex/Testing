<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <title>Тестирование - Вход</title>
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-select.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/lity.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/dropify.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/custom.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Oswald:100,300,400,500,600,800%7COpen+Sans:300,400,500,600,700,800%7CMontserrat:400,700'
          rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Favicons -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/assets/img/favicon.ico">
</head>

<body class="nav-on-header">

<%@ include file="../pages/template/template.jsp" %>


<header class="site-header size-lg text-center "
        style="background-image: url(${pageContext.request.contextPath}/resources/assets/img/bg-banneruser.jpg);">
    <div class="logcontainer">

        <div class="login-block">
            <%--<img src="${pageContext.request.contextPath}/resources/assets/img/logo.jpg" alt="">--%>
            <h5>Введите учетные данные</h5>

            <form id="login" class="login" method="post"
                  action="${pageContext.request.contextPath}/j_spring_security_check">


                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-email"></i></span>
                        <input type="email" value="${email}" class="form-control" name="j_username"
                               placeholder="Ваш e-mail адрес">
                    </div>
                </div>


                <hr class="hr-xs">


                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-unlock"></i></span>
                        <input class="form-control" name="j_password" placeholder="Пароль" size="30" type="password"/>
                    </div>
                </div>
                <c:if test="${!empty error}">
                    <div class="bs-example">
                        <div class="alert alert-danger">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            <strong>Ошибка</strong> Проверьте учетные данные!! Возможно пользователь уже в системе.
                        </div>
                    </div>
                </c:if>
                <hr class="hr-xs">
                <button class="btn btn-primary btn-block" type="submit">Войти</button>

            </form>

        </div>
    </div>
    </div>

</header>


<%@ include file="../pages/template/templatefoot.jsp" %>
<!-- Scripts -->
<script src="${pageContext.request.contextPath}/resources/assets/js/app.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/custom.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/parsley.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>


</body>
</html>
