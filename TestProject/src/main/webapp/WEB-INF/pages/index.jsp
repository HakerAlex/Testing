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
                    <select class="form-control" id="category">
                        <option value="0">Все категории</option>
                        <c:forEach items="${allcategories}" var="categ">
                            <option value="${categ.id}">${categ.category}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="input-location">
                    <input type="text" class="form-control" id="key" placeholder="Ключевое слово">
                </div>

                <div class="btn-search">
                    <button class="btn btn-primary" type="submit"id="searchbutton">Поиск теста</button>
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
            <c:forEach items="${categories}" var="categ">

                    <a href="${pageContext.request.contextPath}/open/${categ.id}">
                        <i><img src="${categ.picture}" class="img-circle"></i>
                        <h6>${categ.category}</h6>
                        <p>${categ.description}</p>
                    </a>

            </c:forEach>
            </div>

        </div>
    </section>


    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
                    <h4 class="modal-title">Результаты поиска</h4>
                </div>
                <div class="modal-body">
                        <div class="list-group" id="listtest">
                        </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Закрыть</button>
                </div>
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
</main>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-confirm.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
    $("#searchbutton").click(function( event ) {
        event.preventDefault();

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/search",
            data: {
                category: $("#category").val(),
                search:$("#key").val()
            },
            success: {
                function (codeQ) {
                }
            },
            error: {
                function (codeQ) {
                }
            }
        }).done(function (element) {
            $("#listtest").html(element);
            $("#myModal").modal('show');

        });

    });
    });

    function opentest(codetest){
        if ($('#activeuser').val()=='active')
        {
            $('#testnumber').val(codetest);
            $('#opentest').submit();
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

<%@ include file="../pages/template/templatefoot.jsp" %>

</body>
</html>




