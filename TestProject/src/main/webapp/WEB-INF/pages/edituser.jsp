<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <title>Тестирование - Редактирование пользователя</title>
    <!-- Styles -->

    <link href="${pageContext.request.contextPath}/resources/assets/css/lity.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/dropify.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/custom.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/switch.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-select.css" rel="stylesheet">
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
    <div class="container">
        <h3 class="text-center">Данные об аккаунте</h3>
    </div>
    <div class="logcontainer">
        <div class="login-block">

            <form id="new_user" class="new_user" method="post"
                  action="${pageContext.request.contextPath}/updateuser" commandName="updateuser">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-user"></i></span>
                        <input type="text" value="${user.name}" class="form-control" name="name" placeholder="Ваше имя">
                    </div>

                </div>

                <hr class="hr-xs">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-user"></i></span>
                        <input type="text" value="${user.surname}" class="form-control" name="surname"
                               placeholder="Ваша фамилия">
                    </div>
                </div>

                <hr class="hr-xs">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-mobile"></i></span>
                        <input type="text" value="${user.phone}" class="form-control" name="phone"
                               placeholder="Ваш телефон">
                    </div>
                </div>

                <hr class="hr-xs">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-email"></i></span>
                        <input type="email" value="${user.email}" class="form-control" name="email"
                               placeholder="Ваш e-mail адрес">
                    </div>
                </div>

                <hr class="hr-xs">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-unlock"></i></span>
                        <input class="form-control" value="${user.password}" name="password"
                               placeholder="Пароль мин. 6 символов" size="30" type="password"/>
                    </div>
                </div>
                <hr class="hr-xs">

                <div class="btn-group" data-toggle="buttons">


                    <c:if test="${rule.namerule=='admin'}">
                        <label class="btn btn-primary active">
                            <input type="radio" name="rule" id="option1" value="admin" checked=""> администратор
                        </label>


                        <label class="btn btn-primary">
                            <input type="radio" name="rule" id="option2" value="user"> пользователь
                        </label>
                    </c:if>

                    <c:if test="${rule.namerule=='user'}">
                        <label class="btn btn-primary">
                            <input type="radio" name="rule" id="option1" value="admin"> администратор
                        </label>


                        <label class="btn btn-primary active">
                            <input type="radio" name="rule" id="option2" value="user" checked=""> пользователь
                        </label>
                    </c:if>

                </div>
                <hr class="hr-xs">
                <div class="btn-group" data-toggle="buttons">

                    <c:if test="${user.status=='1'}">
                        <label class="btn btn-success active">
                            <input type="radio" name="status" id="option1" value="1" checked=""> Активен
                        </label>
                        <label class="btn btn-danger">
                            <input type="radio" name="status" id="option2" value="0"> Отключен
                        </label>
                    </c:if>

                    <c:if test="${user.status=='0'}">
                        <label class="btn btn-success">
                            <input type="radio" name="status" id="option1" value="1"> Активен
                        </label>
                        <label class="btn btn-danger active">
                            <input type="radio" name="status" id="option2" value="0" checked=""> Отключен
                        </label>
                    </c:if>

                </div>
                <hr class="hr-xs">
                <button class="btn btn-primary btn-block" type="submit">Обновить</button>
                <input type="text" value="${user.id}" name="id" style="visibility: hidden">

            </form>

        </div>
    </div>


</header>
<%@ include file="../pages/template/templatefoot.jsp" %>
<!-- Scripts -->
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-select.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/custom.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/parsley.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $('#new_user').parsley({
            successClass: 'has-success',
            errorClass: 'has-error',
            errors: {
                classHandler: function (el) {
                    return $(el).closest('.input-group');
                },
                errorsWrapper: '<span class=\"help-block\"></span>',
                errorElem: '<span></span>'
            }
        });
    });
</script>

</body>
</html>
