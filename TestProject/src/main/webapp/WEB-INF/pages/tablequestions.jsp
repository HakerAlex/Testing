<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>Тестирование-Дерево вопросов</title>

    <!-- Styles -->

    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/app.min.css" rel="stylesheet">--%>


    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-treeview.min.css" rel="stylesheet">

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
        <h3 class="text-center" style="color: white">Дерево вопросов</h3>
    </div>


    <div class="container" style="border-color: transparent">

        <div class="col-xs-5">

            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="ti-folder"></i></span>
                    <input type="text" id="category" value="" class="form-control" name="name" placeholder="Категория" disabled>
                </div>

            </div>

            <div id="treeview" class="treeview" style="color: darkblue; text-align: left;"></div>

        </div>
    </div>

</header>
<!-- END Site header -->


<!-- END Main container -->
<!-- Back to top button -->
<%@ include file="../pages/template/templatefoot.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>


<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-treeview.min.js"></script>

<script type="text/javascript">
    function getTree() {
        var tree =${tree}
        return tree;
    }


    $('#treeview').treeview({data: getTree()});
    $('#treeview').treeview('expandAll', { levels: 5, silent: true });


</script>
<script type="text/javascript">
    var parent;
    $('#treeview').on('nodeSelected', function(event, data) {
        document.getElementById('category').value = data.text
    })
</script>

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




