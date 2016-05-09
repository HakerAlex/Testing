<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>Тестирование-Добавление вопроса</title>

    <!-- Styles -->

    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/app.min.css" rel="stylesheet">--%>


    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">

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
        <h3 class="text-center" style="color: white">Вопрос</h3>
    </div>


    <div class="container">
        <div class="col-xs-6">
            <div class="input-group">
                <span class="input-group-addon"><i class="ti-folder"></i></span>
                <input type="text" value="${category}" class="form-control" id="category" name="category" disabled>
            </div>
                <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
            <div class="input-group">
                <%--<div class="form-group">--%>
                    <textarea cols="80" id="editorCk" name="article" rows="30" style="height: 90%"></textarea>
                <%--</div>--%>
            </div>
        </div>
    </div>

</header>
<!-- END Site header -->


<!-- END Main container -->
<!-- Back to top button -->
<%@ include file="../pages/template/templatefoot.jsp" %>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
<%--<script type="text/javascript"--%>
<%--src="${pageContext.request.contextPath}/resources/assets/js/dataTables.bootstrap.min.js"></script>--%>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/datatables.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
    // Call CkEditor
    CKEDITOR.replace('editorCk', {
        removePlugins: 'sourcearea',
        entities: false,
        language: 'ru',
        height: 200,
        startupFocus: false,
        uiColor: '#FFFFFF'
    });
</script>

</body>
</html>




