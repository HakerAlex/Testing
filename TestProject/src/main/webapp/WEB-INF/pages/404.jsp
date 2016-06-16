<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>Ошибка 404 - Страница не найдена</title>
    <meta name="robots" content="noindex" />
    <style type="text/css">
        html {height: 100%;}
        body {height:100%;margin:0; padding:0;background:#FFF url('/404.jpg') right bottom no-repeat ;}
        a {color:#27579E;text-decoration:none}
        a:hover {color:#0E1D34;text-decoration:none}
        @media only screen and (max-width: 1000px) {body {background:#FFF !important}}
    </style>
</head>
<body>
<img src="${pageContext.request.contextPath}/resources/assets/img/404.jpg" border="0" alt="" width="480" style="display: block; margin-left: auto; margin-right: auto; margin-top: 60px;">
<p>&nbsp;</p>
<p style="text-align: center;"><a href="${pageContext.request.contextPath}/" title="Вернуться на Главную">Вернуться на Главную</a> </p>
</body>
</html>



