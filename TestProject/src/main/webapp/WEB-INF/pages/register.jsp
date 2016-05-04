<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <title>Тестирование - Регистрация</title>
    <!-- Styles -->
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
            <h5>Данные о вашем аккаунте</h5>

            <form id="new_user" class="new_user" method="post"
                  action="${pageContext.request.contextPath}/createuser" commandName="createuser">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-user"></i></span>
                        <input type="text" value="${name}" class="form-control" name="name" placeholder="Ваше имя">
                    </div>

                    <c:if test="${!empty errorname}">
                        <div class="bs-example">
                            <div class="alert alert-danger">
                                <a href="#" class="close" data-dismiss="alert">&times;</a>
                                <strong>Ошибка</strong> ${errorname}
                            </div>
                        </div>
                    </c:if>

                </div>

                <hr class="hr-xs">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-user"></i></span>
                        <input type="text" value="${surname}" class="form-control" name="surname"
                               placeholder="Ваша фамилия">
                    </div>
                </div>
                <c:if test="${!empty errorsurname}">
                    <div class="bs-example">
                        <div class="alert alert-danger">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            <strong>Ошибка</strong> ${errorsurname}
                        </div>
                    </div>
                </c:if>
                <hr class="hr-xs">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-mobile"></i></span>
                        <input type="text" value="${phone}" class="form-control" name="phone" placeholder="Ваш телефон">
                    </div>
                </div>
                <c:if test="${!empty errorphone}">
                    <div class="bs-example">
                        <div class="alert alert-danger">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            <strong>Ошибка</strong> ${errorphone}
                        </div>
                    </div>
                </c:if>
                <hr class="hr-xs">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-email"></i></span>
                        <input type="email" value="${email}" class="form-control" name="email"
                               placeholder="Ваш e-mail адрес">
                    </div>
                </div>
                <c:if test="${!empty erroremail}">
                    <div class="bs-example">
                        <div class="alert alert-danger">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            <strong>Ошибка</strong> ${erroremail}
                        </div>
                    </div>
                </c:if>
                <hr class="hr-xs">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-unlock"></i></span>
                        <input class="form-control" value="${password}" name="password"
                               placeholder="Пароль мин. 6 символов" size="30" type="password"/>
                    </div>
                </div>
                <c:if test="${!empty errorpassword}">
                    <div class="bs-example">
                        <div class="alert alert-danger">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            <strong>Ошибка</strong> ${errorpassword}
                        </div>
                    </div>
                </c:if>
                <hr class="hr-xs">
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-unlock"></i></span>
                        <input class="form-control" value="${confirmpassword}" name="confirmpassword"
                               placeholder="Подтв. мин. 6 символов" size="30" type="password"/>
                    </div>
                </div>
                <c:if test="${!empty errorconfirmpassword}">
                    <div class="bs-example">
                        <div class="alert alert-danger">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            <strong>Ошибка</strong> ${errorconfirmpassword}
                        </div>
                    </div>
                </c:if>
                <hr class="hr-xs">
                <button class="btn btn-primary btn-block" type="submit">Зарегистрировать</button>

            </form>
            <div class="login-links">
                <p class="text-center">Уже есть аккаунт? <a class="txt-brand"
                                                            href="${pageContext.request.contextPath}/login"><strong>Войти</strong></a>
                </p>
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
