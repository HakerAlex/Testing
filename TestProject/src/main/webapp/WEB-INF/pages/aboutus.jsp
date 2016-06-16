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
        <h1 class="text-center">О нас</h1>
        <p class="lead text-center">Прочитайте эту страницу, чтоб Вы понимали, как мы начинали и кто мы!</p>
    </div>
</header>
<!-- END Site header -->


<!-- Main container -->
<main>



    <!-- About -->
    <section>
        <div class="container">

            <h5>Первый день</h5>
            <p>Мы встретились на курсах в IT-школе компании DataArt, кто-то из нас что-то знал, кто-то что-то знал вообще не то что надо. Но все мы были объединены общей идеей, что нам надо написать проект.
            И мы начали писать придумывая и реализовывая свои мысли.</p>

            <h5>И как же мы решали нашу задачу?</h5>
            <p>Основная идея проекта была сделать что-то необычное. Не такое как у всех, была заложена идея разделяй и властвуй. То есть каждый кто пользуется нашим проектом делает только то что должен.</p>

            <h5>И что же мы получили?</h5>
            <p>Мы получили гибкую систему создания тестов, возможность видеть кто проходил тесты, какие, с каким результатом, и возможностью все это выгрузить во внешний файл.</p>

            <h5>Довольны ли мы результатом?</h5>
            <p>В принципе все что было задумано, было и реализовано, может не идеально, но все же результат достигнут, а это самое главное... </p>
        </div>
    </section>
    <!-- END About -->



    <!-- Team -->
    <section class="bg-alt">
        <div class="container">
            <header class="section-header">
                <span>Кто мы есть</span>
                <h2>"Команда симпатичных профессионалов"</h2>
                <p>Люди объединенные общей целью, для максимального результата</p>
            </header>

            <div class="row equal-team-members">

                <!-- Team member -->
                <div class="col-xs-12 col-sm-6 col-md-4">
                    <div class="team-member">
                        <h5>Кузьменко Александр<small>Mentor & Java Senior in DataArt</small></h5>
                        <img src="${pageContext.request.contextPath}/resources/assets/img/mentor.jpg" alt="avatar">
                        <ul class="social-icons">
                            <li><a class="vkontakte" href="http://vk.com/kuzmenko_alexandr"><i class="fa fa-vk"></i></a></li>
                            <li><a class="linkedin" href="http://www.linkedin.com/in/alexander-kuzmenko-b458166a"><i class="fa fa-linkedin"></i></a></li>
                            <li><a class="facebook" href="http://www.facebook.com/kuzmenkoalexandr"><i class="fa fa-facebook"></i></a></li>
                        </ul>
                        <p>Наш ментор который вел нас как пастор по пустыне кода...</p>
                    </div>
                </div>
                <!-- END Team member -->

                <!-- Team member -->
                <div class="col-xs-12 col-sm-6 col-md-4">
                    <div class="team-member">
                        <h5>Потемкин Алексей<small>Java Developer & Front-end Developer</small></h5>
                        <img src="${pageContext.request.contextPath}/resources/assets/img/alex.jpg" alt="avatar">
                        <ul class="social-icons">
                            <li><a class="vkontakte" href="http://vk.com/leha_odessa"><i class="fa fa-vk"></i></a></li>
                            <li><a class="linkedin" href="http://www.linkedin.com/in/алексей-потемкин-57b14169"><i class="fa fa-linkedin"></i></a></li>
                            <li><a class="twitter" href="http://twitter.com/Leha_Sever"><i class="fa fa-twitter"></i></a></li>
                            <li><a class="facebook" href="http://www.facebook.com/alex.potemkin.7"><i class="fa fa-facebook"></i></a></li>
                        </ul>
                        <p>Наш идейный вдохновитель и разработчик.</p>
                    </div>
                </div>
                <!-- END Team member -->

                <!-- Team member -->
                <div class="col-xs-12 col-sm-6 col-md-4">
                    <div class="team-member">
                        <h5>Крамер Ольга<small>QA</small></h5>
                        <img src="${pageContext.request.contextPath}/resources/assets/img/Kramer.jpg" alt="avatar">
                        <ul class="social-icons">
                            <li><a class="vkontakte" href="http://vk.com/id142740606"><i class="fa fa-vk"></i></a></li>
                            <li><a class="facebook" href="http://www.facebook.com/olga.vasina.543"><i class="fa fa-facebook"></i></a></li>
                          </ul>
                        <p>Скромная девушка которая вложила частичку себя в проект, и в то чтоб он работал.</p>
                    </div>
                </div>
                <!-- END Team member -->
                <div class="col-xs-12 col-sm-6 col-md-4">
                    <div class="team-member">
                        <h5>Ливандовская Алена<small>QA</small></h5>
                        <img src="${pageContext.request.contextPath}/resources/assets/img/Alenka.jpg" alt="avatar">
                        <ul class="social-icons">
                            <li><a class="facebook" href="http://www.facebook.com/helensonce"><i class="fa fa-facebook"></i></a></li>
                            <li><a class="vkontakte" href="http://vk.com/id50980867"><i class="fa fa-vk"></i></a></li>
                        </ul>
                        <p>Девушка в споре с которой рождалась истина, и без которой разработка не была бы такой веселой.</p>
                    </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-4">
                    <div class="team-member">
                        <h5>Личманенко Валентин<small>QA</small></h5>
                        <img src="${pageContext.request.contextPath}/resources/assets/img/Valentin.png" alt="avatar">
                        <ul class="social-icons">
                            <li><a class="facebook" href="http://www.facebook.com/profile.php?id=100009837076142"><i class="fa fa-facebook"></i></a></li>
                            <li><a class="vkontakte" href="http://vk.com/jester85"><i class="fa fa-vk"></i></a></li>
                        </ul>
                        <p>Человек который очень хотел поучаствовать, но в связи с производственной травмой, в виде сломанной ноги не смог. Но не страшно все у него впереди...</p>
                    </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-4">
                    <div class="team-member">
                        <h5>Король Дмитрий<small>?</small></h5>
                        <img src="${pageContext.request.contextPath}/resources/assets/img/Korol.jpg" alt="avatar">
                        <ul class="social-icons">
                            <li><a class="facebook" href="http://www.facebook.com/dmytro.korol.7"><i class="fa fa-facebook"></i></a></li>
                            <li><a class="linkedin" href="http://www.linkedin.com/in/dmytro-korol-37a80455"><i class="fa fa-linkedin"></i></a></li>

                        </ul>
                        <p>Человек системный администратор... И наш младший подован...</p>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <!-- END Team -->



</main>
<!-- END Main container -->
<script src="${pageContext.request.contextPath}/resources/assets/js/app.min.js"></script>
<%@ include file="../pages/template/templatefoot.jsp" %>

</body>
</html>




