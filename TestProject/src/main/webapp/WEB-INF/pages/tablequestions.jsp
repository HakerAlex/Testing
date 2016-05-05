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
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-gtreetable.css" rel="stylesheet">

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

        <div class="col-xs-6">
            <div class="form-group">
                <%--<form id="add_category" class="add_category" method="post"--%>
                      <%--action="${pageContext.request.contextPath}/addcategory" commandName="addcategory">--%>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-folder"></i></span>
                        <input type="text" value="" class="form-control" name="name" id="namecategory"
                               placeholder="Категория">
                    </div>
                    <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="ti-folder"></i></span>
                        <input type="text" id="category" value="" class="form-control" name="name"
                               placeholder="Родитель" disabled>
                    </div>
                    <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
                    <button class="btn btn-primary btn-block" type="submit" id="addcategory">Добавить категорию</button>



                <%--</form>--%>
                <button class="btn btn-primary btn-block" type="submit" onclick="clearParent()">Очистить родителя</button>
                <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
                <button class="btn btn-primary btn-search" type="submit" onclick="expand()">Развернуть все</button>
                <button class="btn btn-primary btn-search" type="submit" onclick="collapse()">Свернуть все</button>
                <button class="btn btn-primary btn-search" type="button" id="updatetree">Обновить дерево</button>
            </div>

            <table class="table gtreetable" id="gtreetable"><thead><tr><th>Category</th></tr></thead></table>

        </div>
    </div>

</header>
<!-- END Site header -->


<!-- END Main container -->
<!-- Back to top button -->
<%@ include file="../pages/template/templatefoot.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-gtreetable.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-gtreetable.ru.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.browser.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/URI.js"></script>

<script type="text/javascript">
    /*<![CDATA[*/
    jQuery(function($) {
        jQuery('#gtreetable').gtreetable({'source':function (id) {
            return URI('${pageContext.request.contextPath}/nodeChildren').addSearch({'id':id});
        },'onSave':function (oNode) {
            return jQuery.ajax({
                type: 'POST',
                url: !oNode.isSaved() ? '${pageContext.request.contextPath}/nodeCreate' : URI('${pageContext.request.contextPath}/nodeUpdate').addSearch({'id':oNode.getId()}),
                data: {
                    parent: oNode.getParent(),
                    name: oNode.getName(),
                    position: oNode.getInsertPosition(),
                    related: oNode.getRelatedNodeId()
                },
                dataType: 'json',
                error: function(XMLHttpRequest) {
                    alert(XMLHttpRequest.status+': '+XMLHttpRequest.responseText);
                }
            });
        },'onDelete':function(oNode) {
            return jQuery.ajax({
                type: 'POST',
                url: URI('${pageContext.request.contextPath}/nodeDelete').addSearch({'id':oNode.getId()}),
                dataType: 'json',
                error: function(XMLHttpRequest) {
                    alert(XMLHttpRequest.status+': '+XMLHttpRequest.responseText);
                }
            });
        },'onMove':function(oSource, oDestination, position) {
            return jQuery.ajax({
                type: 'POST',
                url: URI('${pageContext.request.contextPath}/nodeMove').addSearch({'id':oSource.getId()}),
                data: {
                    related: oDestination.getId(),
                    position: position
                },
                dataType: 'json',
                error: function(XMLHttpRequest) {
                    alert(XMLHttpRequest.status+': '+XMLHttpRequest.responseText);
                }
            });
        },'draggable':true,'showExpandIconOnEmpty':true,'manyroots':true});
    });


<%--<script type="text/javascript">--%>
    <%--function getTree() {--%>
            <%--return ${tree};--%>
    <%--}--%>
    <%--$('#treeview').treeview({data: getTree()});--%>
<%--</script>--%>

<%--<script type="text/javascript">--%>
    <%--function expand() {--%>
        <%--$('#treeview').treeview('expandAll', { levels: 5, silent: true });--%>
    <%--}--%>
    <%--function collapse() {--%>
        <%--$('#treeview').treeview('collapseAll', { levels: 5, silent: true });--%>
    <%--}--%>
<%--</script>--%>

<%--<script type="text/javascript">--%>
    <%--$(document).ready(function() {--%>
        <%--$("#updatetree").click(function(){--%>
            <%--$.get("${pageContext.request.contextPath}/updatetree",function(ourtree){--%>
                <%--$('#treeview').treeview({data: ourtree});--%>
            <%--});--%>
        <%--});--%>
    <%--});--%>
<%--</script>--%>


<%--<script type="text/javascript">--%>
    <%--$(document).ready(function() {--%>
        <%--$("#addcategory").click(function(){--%>
            <%--$.ajax({--%>
            <%--type: "POST",--%>
            <%--url: "${pageContext.request.contextPath}/addcategory",--%>
            <%--data: { namecategory: document.getElementById('namecategory').value, parent: document.getElementById('category').value }--%>
        <%--}).done(function(tree) {--%>
                <%--$('#treeview').treeview({data: tree});--%>
            <%--});--%>
        <%--});--%>
    <%--});--%>
<%--</script>--%>

<%--<script type="text/javascript">--%>
    <%--function clearParent() {--%>
        <%--document.getElementById('category').value = ""--%>
        <%--}--%>
<%--</script>--%>


<%--<script type="text/javascript">--%>
    <%--var parent;--%>
    <%--$('#treeview').on('nodeSelected', function(event, data) {--%>
        <%--document.getElementById('category').value = data.text--%>
    <%--})--%>
<%--</script>--%>

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




