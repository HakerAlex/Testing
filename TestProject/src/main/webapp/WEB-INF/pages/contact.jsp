<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>Тестирование</title>


    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/lity.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/resources/assets/css/app.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/custom.css" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-select.css" rel="stylesheet">--%>
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Oswald:100,300,400,500,600,800%7COpen+Sans:300,400,500,600,700,800%7CMontserrat:400,700'
          rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Favicons -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/assets/img/favicon.ico">
</head>

<body class="nav-on-header">

<%@ include file="../pages/template/template.jsp" %>

<!-- Site header -->
<header class="page-header bg-img size-lg" style="background-image: url(${pageContext.request.contextPath}/resources/assets/img/bg-banner2.jpg)">
    <div class="container no-shadow">
        <h1 class="text-center">Наши контакты</h1>
        <p class="lead text-center">Есть вопросы или предложения обращайтесь, мы всегда Вам рады</p>
    </div>
</header>
<!-- END Site header -->


<!-- Main container -->
<main>

    <section>
        <div class="container">

            <div id="contact-map" style="height: 500px"></div>

            <br><br>


                <div class="col-sm-12 col-md-4">
                    <h4>Информация</h4>
                    <div class="highlighted-block">
                        <dl class="icon-holder">
                            <dt><i class="fa fa-map-marker"></i></dt>
                            <dd>65036, Украина, Одесса, Старицкого 20/1 кв.74</dd>

                            <dt><i class="fa fa-phone"></i></dt>
                            <dd>(+38) 096-348-03-07</dd>

                            <dt><i class="fa fa-envelope"></i></dt>
                            <dd><a href="mailto:potemkin_81@ukr.net">potemkin_81@ukr.net</a> </dd>
                        </dl>
                    </div>

                    <br>


                </div>
            </div>

        </div>
    </section>


</main>
<!-- END Main container -->
<script src="${pageContext.request.contextPath}/resources/assets/js/app.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?callback=initMap" async defer></script>
<%@ include file="../pages/template/templatefoot.jsp" %>

</body>
</html>




