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

    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">--%>
    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">--%>
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
<header class="site-header size-lg text-center "
        style="background-image: url(${pageContext.request.contextPath}/resources/assets/img/bg-banneruser.jpg);">
    <div class="container">
        <div class="col-xs-12">
            <br><br>
            <h2>Мы предлагаем
                <mark>${count}</mark>
                тестов прямо сейчас
            </h2>
            <h5 class="font-alt">Найдите свой тест за минуту</h5>
            <br><br><br>
            <form class="header-job-search">
                <div class="input-keyword">
                    <select class="form-control">
                        <option>Все категории</option>
                        <c:forEach items="${allcategories}" var="categ">
                            <option value="${categ.id}">${categ.category}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="input-location">
                    <input type="text" class="form-control" placeholder="Ключевое слово">
                </div>

                <div class="btn-search">
                    <button class="btn btn-primary" type="submit">Поиск теста</button>
                </div>
            </form>
        </div>

    </div>



</header>
<!-- END Site header -->


<!-- Main container -->
<main>


    <!-- Categories -->
    <section class="bg-alt">
        <div class="container">
            <header class="section-header">
                <h2>Категории</h2>
            </header>
            <div class="category-grid">
            <c:forEach items="${allcategories}" var="categ">

                    <a href="${pageContext.request.contextPath}/open/${categ.id}">
                        <i><img src="${categ.picture}" class="img-circle"></i>
                        <h6>${categ.category}</h6>
                        <p>${categ.description}</p>
                    </a>

            </c:forEach>
            </div>

        </div>
    </section>
    <!-- END Categories -->

</main>
<!-- END Main container -->
<!-- Back to top button -->
<%@ include file="../pages/template/templatefoot.jsp" %>

</body>
</html>




