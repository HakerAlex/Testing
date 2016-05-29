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
    <link href="${pageContext.request.contextPath}/resources/assets/css/table.css" rel="stylesheet">


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
        <div class="col-xs-12">
            <div class="panel panel-info">
                <div class="form-group">
                    <h4>Фамилия: <span style="color: dodgerblue">${surname}</span> Имя: <span style="color: dodgerblue">${name}</span></h4>
                    <hr class="hr-xs">
                    <h5>Телефон: <span style="color: dodgerblue">${phone}</span> E-mail: <span style="color: dodgerblue">${email}</span> </h5>
                    <input type="hidden" id="datebegin" value="${datestart}">
                </div>
            </div>
            <div class="panel panel-info">
            <input type="hidden" id="testid" value="${testid}">
            <h3>${description}</h3>
            <form>
               <ul id="ourTest" class="list-group">
                ${list}
            </ul>
             <c:if test="${count!=0}">
            <button class="btn btn-primary btn-block" id="button" type="submit" >Закончить тест</button>
             </c:if>
            </form>
            </div>
        </div>
    </div>


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
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-confirm.js"></script>


<script type="text/javascript">

    $( "form" ).submit(function( event ) {
        event.preventDefault();

        var data = JSON.stringify($(this).serializeArray());

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/writetestuser",
            data: {
                ourResult: data,
                datebegin: $("#datebegin").val(),
                testid:$("#testid").val()
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
            $("#button").hide();
            $("#ourTest").html(element);

        });

    });

</script>



<%--<%@ include file="../pages/template/templatefoot.jsp" %>--%>
</body>
</html>




