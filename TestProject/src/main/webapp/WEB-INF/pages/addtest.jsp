<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta name="http-equiv" content="Content-type: text/html; charset=UTF-8">

    <title>Тестирование-Тест</title>


    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-treeview.css"/>
    <link href="${pageContext.request.contextPath}/resources/assets/css/table.css" rel="stylesheet">
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
        <h3 class="text-center" style="color: white">Тест</h3>
    </div>


    <div class="container" style="border-color: transparent">
        <%----%>


        <div class="col-xs-4">
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="ti-folder"></i></span>
                    <input type="text" value="${categoryfortest}" class="form-control" id="categoryfortest"
                           name="categoryfortest" placeholder="Категория" disabled>
                </div>
            </div>

            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="ti-info"></i></span>
                    <input type="text" class="form-control" id="href"
                           name="href" placeholder="Ссылка на тест" title="Прямая ссылка на тест" disabled >
                </div>
            </div>


            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="ti-agenda"></i></span>
                    <input type="text" class="form-control" id="title"
                           name="title" placeholder="Название теста">
                </div>
            </div>

            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="ti-calendar"></i></span>
                    <input type="date" class="form-control" id="dateopen"
                           name="dateopen" placeholder="Дата открытия" title="Дата когда тест начнет быть доступным">
                </div>
            </div>


            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="ti-power-off"></i></span>
                    <input type="date" class="form-control" id="dateclose"
                           name="dateclose" placeholder="Дата закрытия" title="Дата когда тест перестанет быть доступным">
                </div>
            </div>

            <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-success active">
                    <input type="radio" name="access" id="option1" value="all"> Всем
                </label>

                <label class="btn btn-danger ">
                    <input type="radio" name="access" id="option2" value="only" checked=""> По ссылке
                </label>
            </div>

        </div>


        <div class="col-lg-8">

            <div class="form-group">
                <a href="#myModal" data-toggle="modal"
                   class="btn btn-primary btn-search">Добавить вопросы</a>
            </div>

            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 15px">
            <table id="test" class="table" data-provide="data-table" cellspacing="0" width="100%">

                <thead>
                <tr>
                    <th>Вопрос</th>
                    <th>Удалить</th>
                </tr>
                </thead>

            </table>

        </div>

    </div>

</header>

<main>
    <%--ouranswerID--%>
    <input type="hidden" class="form-control" id="answerid" name="answerid">


    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Вопросы</h4>
                </div>
                <div class="modal-body">

                    <div class="col-lg-6">

                        <div class="form-group">
                            <br>
                            <button class="btn btn-primary btn-search" type="submit" onclick="expand()">Развернуть
                            </button>
                            <button class="btn btn-primary btn-search" type="submit" onclick="collapse()">Свернуть
                            </button>
                        </div>
                        <div id="treeview" style="color: dodgerblue; text-align:left "></div>
                    </div>

                    <div class="col-lg-6">
                        <br>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Закрыть</button>
                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 15px">
                        <table id="question" class="table" data-provide="data-table" cellspacing="0" width="100%">

                            <thead>
                            <tr>
                                <th>Вопрос</th>
                                <th>Добавить</th>
                            </tr>
                            </thead>

                        </table>

                    </div>


                </div>

                <div class="modal-footer">

                </div>
            </div>
        </div>
    </div>


</main>


<%--<%@ include file="../pages/template/templatefoot.jsp" %>--%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-confirm.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-treeview.js"></script>

<script type="text/javascript">
    function getTree() {
        return ${tree};
    }
    $('#treeview').treeview({data: getTree()});
</script>

<script type="text/javascript">
    function expand() {
        $('#treeview').treeview('expandAll', {levels: 100, silent: true});
    }
    function collapse() {
        $('#treeview').treeview('collapseAll', {levels: 100, silent: true});
    }

</script>


<script type="text/javascript" charset="utf-8">
    var parent;
    $('#treeview').on('nodeSelected', function (event, data) {

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/getquestionfortest",
            data: {
                category: data.text,
                context: "${pageContext.request.contextPath}"
            }
        }).done(function (element) {
            $("#question").html(element);

        })

    });
</script>


</body>
</html>




