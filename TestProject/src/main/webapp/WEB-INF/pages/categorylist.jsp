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
            <div class="form-group">
                <button class="btn btn-primary btn-search" type="submit" onclick="expand()">Развернуть</button>
                <button class="btn btn-primary btn-search" type="submit" onclick="collapse()">Свернуть</button>
            </div>
            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
            <div id="treeview" style="color: dodgerblue; text-align:left "></div>

        </div>
        <div class="col-xs-8">
            <h3>Список тестов</h3>
            <div class="list-group" id="listtest">
                ${list}
            </div>
        </div>
    </div>

    <form id="opentest" class="opentest" method="post"
          action="${pageContext.request.contextPath}/opentest">
        <input type="hidden" id="testnumber" name="testnumber">
    </form>


    <sec:authorize access="isAuthenticated()">
        <input type="hidden" value="active" id="activeuser">
    </sec:authorize>
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
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-treeview.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-confirm.js"></script>

<script type="text/javascript">

    function getTree() {
        return ${tree};
    }
    $('#treeview').treeview({data: getTree(), levels:100});

    function expand() {
        $('#treeview').treeview('expandAll', {levels: 100, silent: true});
    }
    function collapse() {
        $('#treeview').treeview('collapseAll', {levels: 100, silent: true});
    }



    $('#treeview').on('nodeSelected', function (event, data) {

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/getlisttest",
            data: {
                category: data.href
            }
        }).done(function (element) {
            $('#listtest').html(element);
        });
    });

    function opentest(codetest){
        if ($('#activeuser').val()=='active')
        {
            $.confirm({
                template: 'primary',
                templateOk: 'primary',
                message: 'Вы уверены что хотите пройти тест?',
                onOk: function() {
                    $('#testnumber').val(codetest);
                    $('#opentest').submit();
                }
            });

        }
        else{
            $.confirm({
                        title: 'Информация',
                        titleIcon: 'glyphicon glyphicon-info-sign',
                        template: 'info',
                        templateOk: 'info',
                        message: 'Необходимо войти в систему для прохождения тестов!!!',
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function () {
                        }
                    }
            )
        }
    }

</script>

</body>
</html>




