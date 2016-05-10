<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>Тестирование-Таблица пользователей</title>

    <!-- Styles -->

    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/app.min.css" rel="stylesheet">--%>

    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/table.css" rel="stylesheet">
    <%--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/t/zf-5.5.2/jq-2.2.0,dt-1.10.11,b-1.1.2,b-colvis-1.1.2,b-html5-1.1.2/datatables.min.css"/>--%>
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Oswald:100,300,400,500,600,800%7COpen+Sans:300,400,500,600,700,800%7CMontserrat:400,700'
          rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <%--<!-- Favicons -->--%>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/assets/img/favicon.ico">
</head>

<body class="nav-on-header">

<%@ include file="../pages/template/template.jsp" %>
<header class="site-header size-lg text-center "
        style="background-image: url(${pageContext.request.contextPath}/resources/assets/img/bg-banneruser.jpg);">
    <!-- Site header -->
    <div class="container">
        <h3 class="text-center" style="color: white">Список пользователей</h3>
    </div>


    <div class="container">
        <table id="users" class="table" cellspacing="0" width="100%">
            <thead>
            <tr>
                <th>Фамилия</th>
                <th>Имя</th>
                <th>E-mail</th>
                <th>Телефон</th>
                <th>Статус</th>
                <th style="align-content: center">Права</th>
                <th>Действия</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user[0].surname}</td>
                    <td>${user[0].name}</td>
                    <td>${user[0].email}</td>
                    <td>${user[0].phone}</td>
                    <td align="middle">
                        <c:if test="${user[0].status==1}">
                            <span class="label bg-success" style="background: #00cc00">Активный</span>
                        </c:if>
                        <c:if test="${user[0].status==0}">
                            <span class="label bg-danger" style="background: #bb0000">Отключен</span>
                        </c:if>
                    </td>
                    <td align="middle">${user[1].namerule}</td>

                    <td align="center">
                                        <span class="tooltip-area">
                                            <a href="${pageContext.request.contextPath}/edituser/${user[0].id}"
                                               class="label btn-info"><i
                                                    class="fa fa-pencil"> Редактировать</i></a></span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</header>
<!-- END Site header -->


<!-- END Main container -->
<!-- Back to top button -->
<%--<%@ include file="../pages/template/templatefoot.jsp" %>--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
<script type="text/javascript"
src="${pageContext.request.contextPath}/resources/assets/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/datatables.min.js"></script>


<script type="text/javascript">

    $(document).ready(function () {

        var default_options = {
            "sScrollY": 400,

            "sScrollX": "100%",

            "sScrollXInner": "100%",

            "bJQueryUI": true,

            "sPaginationType": "simple_numbers",

            "oLanguage": {

                "sLengthMenu": "Отображено _MENU_ записей на страницу",

                "sSearch": "Поиск:",

                "sZeroRecords": "Ничего не найдено - извините",

                "sInfo": "Показано с _START_ по _END_ из _TOTAL_ записей",

                "sInfoEmpty": "Показано с 0 по 0 из 0 записей",

                "sInfoFiltered": "(filtered from _MAX_ total records)",

                "oPaginate": {

                    "sFirst": "Первая",

                    "sLast": "Посл.",

                    "sNext": "След.",

                    "sPrevious": "Пред."

                }

            },

            "bProcessing": true


        };

        $('#users').dataTable(default_options);
        $('table[data-provide="data-table"]').dataTable();
    });
</script>


</body>
</html>




