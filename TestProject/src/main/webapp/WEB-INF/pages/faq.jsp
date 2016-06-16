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
<header class="site-header size-lg text-center" style="background-image: url(${pageContext.request.contextPath}/resources/assets/img/bg-banneruser.jpg)">
    <div class="container">
        <div class="col-xs-12">
            <h1>Часто задаваемые вопросы</h1>
            <h5 class="font-alt">Попытайтесь найти ответ здесь. Если не получается обязательно свяжитесь с нами.</h5>
            <br>
            <div id="faq-search" class="form-group">
                <i class="ti-search fa-flip-horizontal1"></i>
                <input type="text" class="form-control" name="search" placeholder="Слова для поиска...">
            </div>
        </div>

    </div>
</header>
<!-- END Site header -->



<!-- Main container -->
<main id="faq-result">
    <section>
        <div class="container">
            <header class="section-header text-left">
                <span>Общие вопросы</span>
                <h2>Основное</h2>
            </header>

            <ul class="faq-items">
                <li>
                    <h5>Что это за сайт?</h5>
                    <p>Этот сайт предназначен для прохождения тестов на определенные темы.</p>
                </li>

                <li>
                    <h5>Кто выбирает этот сайт?</h5>
                    <p>Сайт выбирают те, кто хочет проверить свои знания по определенной тематике.</p>
                </li>

                <li>
                    <h5>Какие преимущества у этого сайта?</h5>
                    <p>Основное преимущество, это быстрый поиск теста на интересующую тематику. Возможность видеть все свои результаты за весь период.</p>
                </li>

                <li>
                    <h5>Нужно ли иметь какие-то специальные знания для прохождения тестов?</h5>
                    <p>Вам нужно иметь знания только по тестируемому материалу, все остальное интуитивно понятно, и система всегда вам подскажет.</p>
                </li>

            </ul>
        </div>
    </section>


    <section class="bg-alt">
        <div class="container">
            <header class="section-header text-left">
                <span>Вопросы по пользованию системой </span>
                <h2>Общие</h2>
            </header>

            <ul class="faq-items">
                <li>
                    <h5>Как начать проходить тесты?</h5>
                    <p>Чтоб начать проходить тесты, Вам необходимо зарегистрироваться в системе и найти свой тест, с помощью поиска или путем выбора понравившейся категории. Выбрать из списка возможных тестов свой и начать его проходить.</p>
                </li>

                <li>
                    <h5>Где я могу посмотреть результат?</h5>
                    <p>После прохождения теста результат будет выведен Вам, чтоб посмотреть его повторно, Вам необходимо зайти в профиль, путем выбора данного пункта меню, и просмотреть результат путем выбора его из таблицы пройденных тестов.</p>
                </li>

                <li>
                    <h5>Как пользоваться поиском?</h5>
                    <p>Просто выберите категорию и введите ключевое слово. Если категория не будет выбрана, поиск будет произведен по всем категориям, если не будет введено ключевое слово будут показаны все тесты из категории или вообще все, если категория не выбрана.</p>
                </li>

                <li>
                    <h5>Что такое ключ теста? И зачем он нужен?</h5>
                    <p>Ключ теста необходим для прохождения скрытых тестов. Если тест создан для определенного пользователя, он может нажать <strong>Открыть с помощью ключа</strong>, и в открывшемся окне ввести ключ, который будет выдан ему.</p>
                </li>
            </ul>
        </div>
    </section>

    <section class="bg-alt">
        <div class="container">
            <header class="section-header text-left">
                <span>Вопросы безопасности</span>
                <h2>Безопасность</h2>
            </header>

            <ul class="faq-items">
                <li>
                    <h5>Может ли кто-то зайти под моей учетной записью?</h5>
                    <p>Под вашей учетной записью никто зайти не может, если Вы не скажите свой e-mail и пароль. На сервере пароль хранится в зашифрованном виде, так что злоумышленник все равно его не узнает.</p>
                </li>

                <li>
                    <h5>Могу ли я узнать когда и откуда заходили под моей учетной записью?</h5>
                    <p>В целях безопасности мы не храним никакой посторонней информации о пользователе. Поэтому эту информацию мы предоставить не можем.</p>
                </li>

                <li>
                    <h5>Кто-то зашел под моей учетной записью что делать?</h5>
                    <p>Вы можете поменять пароль в профиле, или обратиться к нам.</p>
                </li>
            </ul>
        </div>
    </section>


</main>
<!-- END Main container -->
<script src="${pageContext.request.contextPath}/resources/assets/js/app.min.js"></script>
<%@ include file="../pages/template/templatefoot.jsp" %>

</body>
</html>




