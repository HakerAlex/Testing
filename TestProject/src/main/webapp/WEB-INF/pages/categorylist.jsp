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

    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/app.min.css" rel="stylesheet">--%>
    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/custom.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">

    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Oswald:100,300,400,500,600,800%7COpen+Sans:300,400,500,600,700,800%7CMontserrat:400,700'
          rel='stylesheet' type='text/css'>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">--%>
    <!-- Favicons -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/assets/img/favicon.ico">


</head>

<body class="nav-on-header">

<%@ include file="../pages/template/template.jsp" %>

<header class="site-header size-lg text-center "
        style="background-image: url(${pageContext.request.contextPath}/resources/assets/img/bg-banneruser.jpg);">
    <div class="container" style="border-color: transparent">
        <div class="col-xs-4">

            <div class="panel panel-info" style="background: transparent">
                <br>
                <div class="form-group">
                    <img class="logo" src="${picture}" alt="" style="width: 60px; height: 60px">
                    <div class="hgroup">
                        <h3>${category}</h3>
                        <h6>${description}</h6>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-8">
            <div class="panel panel-info" style="background: transparent; text-align:left">
                ${tree}

                    <ul class="nav nav-list">
                        <li>First item</li>
                        <ul>
                            <li>First item</li>
                            <li>Second item</li>
                            <ul>
                                <li>First item</li>
                                <li>Second item</li>
                                <ul>
                                    <li> <i class="ti-write"></i>First item</li>
                                    <li>Second item</li>
                                    <li>Third item</li>
                                </ul>
                                <li>Third item</li>
                            </ul>
                            <li>Third item</li>
                        </ul>
                        <li>Second item</li>
                        <li>Third item</li>
                    </ul>

            </div>
        </div>
    </div>
</header>


<!-- Site header -->

<!-- END Site header -->


<!-- Main container -->
<main>

</main>
<!-- END Main container -->
<!-- Back to top button -->
<%--<%@ include file="../pages/template/templatefoot.jsp" %>--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
</body>
</html>




