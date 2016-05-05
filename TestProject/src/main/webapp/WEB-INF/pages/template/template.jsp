<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- Navigation bar -->
<nav class="navbar">
    <div class="container">
        <sec:authorize access="isAnonymous()">
            <div class="pull-right user-login">
                <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/login">Войти</a> или <a
                    href="${pageContext.request.contextPath}/register">регистрация</a>
            </div>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <div class="pull-right">
                <div class="dropdown user-account">
                    <a class="dropdown-toggle" href="#" data-toggle="dropdown">
                        <img src="${pageContext.request.contextPath}/resources/assets/img/logo-envato.png" alt="avatar">
                    </a>

                    <ul class="dropdown-menu dropdown-menu-right">
                        <li><a href="${pageContext.request.contextPath}/profile"> Профиль </a></li>
                        <li><a href="${pageContext.request.contextPath}/j_spring_security_logout"> Выйти </a></li>
                    </ul>
                </div>
            </div>
        </sec:authorize>

        <!-- Navigation menu -->
        <ul class="nav-menu">
            <li>
                <a class="active" href="${pageContext.request.contextPath}/">Главная</a>
            </li>
            <sec:authorize access="isAuthenticated()">
                <sec:authorize access="hasRole('admin')">
                <li>
                    <a href="#">Администирование</a>
                    <ul>

                            <li><a href="${pageContext.request.contextPath}/question">Вопросы</a></li>
                            <li><a href="${pageContext.request.contextPath}/tests">Тесты</a></li>
                            <li><a href="${pageContext.request.contextPath}/tableuser">Пользователи</a></li>

                    </ul>
                </li>
                </sec:authorize>
            </sec:authorize>
            <li>
                <a href="#">Общая</a>
                <ul>
                    <li><a href="page-about.html">О нас</a></li>
                    <li><a href="page-contact.html">Контакты</a></li>
                    <li><a href="page-faq.html">FAQ</a></li>
                </ul>
            </li>
        </ul>
        <!-- END Navigation menu -->

    </div>
</nav>
<!-- END Navigation bar -->







