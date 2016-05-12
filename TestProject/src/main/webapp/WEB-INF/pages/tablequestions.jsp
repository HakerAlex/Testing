<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta name="http-equiv" content="Content-type: text/html; charset=UTF-8">

    <title>Тестирование-Дерево вопросов</title>


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
        <h3 class="text-center" style="color: white">Дерево вопросов</h3>
    </div>


    <div class="container" style="border-color: transparent">
        <%----%>
        <div class="col-xs-4">
            <div class="form-group">
                <button class="btn btn-primary btn-search" type="submit" onclick="expand()">Развернуть</button>
                <button class="btn btn-primary btn-search" type="submit" onclick="collapse()">Свернуть</button>
            </div>
            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
            <div class="form-group">
                <a href="#myModal" data-toggle="modal"
                   class="btn btn-primary btn-search">+</a>
                <a href="#upModal" data-toggle="modal"
                   class="btn btn-primary btn-search">Редак.</a>
                <a href="#del" data-toggle="modal"
                   class="btn btn-primary btn-danger">Удалить</a>
            </div>

            <div id="treeview" style="color: dodgerblue; text-align:left "></div>
        </div>


        <div class="col-xs-8">

            <form id="addquestion" class="addquestion" method="post"
                  action="${pageContext.request.contextPath}/addquestion" commandName="addquestion">
                <input type="hidden" value="" class="form-control" id="categoryforquestion" name="categoryforquestion">
                <button type="button" class="btn btn-primary btn-search" id="addnewquestion">Добавить вопрос</button>
                <%--<button class="btn btn-primary btn-search" type="submit">Добавить вопрос</button>--%>
            </form>

            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 15px">
            <table id="question" class="table" data-provide="data-table" cellspacing="0" width="100%">

                <thead>
                <tr>
                    <th>Код</th>
                    <th>Вопрос</th>
                    <th>Тип вопроса</th>
                    <th>Редактировать</th>
                    <th>Удалить</th>
                </tr>
                </thead>

            </table>

        </div>

    </div>

</header>
<!-- END Site header -->

<main>


    <!-- Modal -->

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Добавить категорию</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">

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
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="clearParent()">Очистить родителя</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="addcategory">Добавить
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <div class="modal fade" id="upModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Обновить категорию</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">

                        <div class="input-group">
                            <span class="input-group-addon"><i class="ti-folder"></i></span>
                            <input type="text" value="" class="form-control" name="upcategory" id="upcategory"
                                   placeholder="Новое значение">
                        </div>
                        <div class="input-group">

                            <input type="hidden" id="oldcategory" value="" class="form-control" name="parent"
                                   placeholder="Старое значение" disabled>
                        </div>
                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="ti-folder"></i></span>
                            <input type="text" id="parent" value="" class="form-control" name="parent"
                                   placeholder="Родитель" disabled>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="clearParent()">Очистить родителя</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="updatecategory">Изменить
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <div class="modal fade" id="del" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Удалить категорию</h4>
                    <h6 class="modal-title">Внимание! Можно удалить только если нет связанных элементов</h6>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="ti-folder"></i></span>
                            <input type="text" id="delcategory" value="" class="form-control" name="delcategory"
                                   placeholder="Значение" disabled>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal" id="deletecategory">Удалить
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


</main>
<!-- END Main container -->
<!-- Back to top button -->
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


<script type="text/javascript">
    $(document).ready(function () {
        $("#addnewquestion").click(function () {

            if (document.getElementById('categoryforquestion').value=='') {

                $.confirm({
                    title: 'Внимание',
                    titleIcon: 'glyphicon glyphicon-warning-sign',
                    template: 'warning',
                    templateOk: 'warning',
                    message: "Выберите категорию для добавления вопроса.",
                    labelOk: 'ОК',
                    buttonCancel: false,
                    onOk: function() {
                    }
                });

            }else {
                $('#addquestion').submit();
            }
          }
        )}
    );
</script>


<script type="text/javascript">
    $(document).ready(function () {
        $("#deletecategory").click(function () {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/delcategory",
                data: {
                    namecategory: document.getElementById('delcategory').value
                }
            }).done(function (msg) {
                if (msg != "") {

                    $.confirm({
                        title: 'Внимание',
                        titleIcon: 'glyphicon glyphicon-warning-sign',
                        template: 'warning',
                        templateOk: 'warning',
                        message: msg,
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function() {
                             }
                    });

                }
                else {

                    $.confirm({
                        title: 'Информация',
                        titleIcon: 'glyphicon glyphicon-info-sign',
                        template: 'info',
                        templateOk: 'info',
                        message: 'Категория удалена.',
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function() {
                            location.reload();
                        }
                    });

                }
                ;
            });
        });
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {

        $("#addcategory").click(function () {
            if (document.getElementById('namecategory').value!=''){
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/addcategory",
                data: {
                    namecategory: document.getElementById('namecategory').value,
                    parent: document.getElementById('category').value
                }
            }).done(function (tree) {
                $.confirm({
                    title: 'Информация',
                    titleIcon: 'glyphicon glyphicon-info-sign',
                    template: 'info',
                    templateOk: 'info',
                    message: 'Категория добавлена.',
                    labelOk: 'ОК',
                    buttonCancel: false,
                    onOk: function() {
                        location.reload();
                    }
                });
            });
        }
        else{
            $.confirm({
                title: 'Внимание',
                titleIcon: 'glyphicon glyphicon-warning-sign',
                template: 'warning',
                templateOk: 'warning',
                message: 'Нельзя создавать пустую категорию.',
                labelOk: 'ОК',
                buttonCancel: false,
                onOk: function() {
                }
            });
        }
    })
    });
</script>


<script type="text/javascript">
    $(document).ready(function () {
        $("#updatecategory").click(function () {

            if (document.getElementById('upcategory').value!=''){
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/updatecategory",
                    data: {
                        namecategory: document.getElementById('upcategory').value,
                        oldcategory: document.getElementById('oldcategory').value,
                        parent: document.getElementById('parent').value
                    }
                }).done(function (tree) {

                    $.confirm({
                        title: 'Информация',
                        titleIcon: 'glyphicon glyphicon-info-sign',
                        template: 'info',
                        templateOk: 'info',
                        message: 'Категория обновлена.',
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function() {
                            location.reload();
                        }
                    });
                });
            }
            else {
                $.confirm({
                    title: 'Внимание',
                    titleIcon: 'glyphicon glyphicon-warning-sign',
                    template: 'warning',
                    templateOk: 'warning',
                    message: 'Нельзя исправлять на пустую категорию.',
                    labelOk: 'ОК',
                    buttonCancel: false,
                    onOk: function() {
                    }
                });
            }
        }
    )
    }
    );
</script>

<script type="text/javascript">
    function clearParent() {
        document.getElementById('category').value = ""
        document.getElementById('parent').value = ""
    }
</script>


<script type="text/javascript" charset="utf-8">
    var parent;
    $('#treeview').on('nodeSelected', function (event, data) {

        var cat=data.text.trim();
        var n = cat.search(" ");
        var s=cat.substring(n+1,cat.length);

        document.getElementById('upcategory').value =s;
        document.getElementById('oldcategory').value = data.text;
        document.getElementById('category').value = data.text;
        document.getElementById('delcategory').value = data.text;
        document.getElementById('parent').value = "";
        document.getElementById('categoryforquestion').value = data.text;
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/getparent",
            data: {
                category: data.text
            }
        }).done(function (element) {
            document.getElementById('parent').value = element;

        });


        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/getquestion",
            data: {
                category: data.text,
                context: "${pageContext.request.contextPath}"
            }
        }).done(function (element) {
            $("#question").html(element);

        })

    });
</script>

<script type="text/javascript" charset="utf-8">
    function fundelquestion(idquestion) {
        $.confirm({
            template: 'primary',
            templateOk: 'primary',
            message: 'Вы уверены что хотите удалить вопрос?',
            onOk: function() {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/delquestion",
                    data: {
                        id: idquestion,
                        context: "${pageContext.request.contextPath}",
                        category: document.getElementById('category').value
                    },
                    dataType: "text",
                    success: {
                        function () {
                        },
                        error: {
                            function () {
                            }
                        }
                    }
                }).done(function (element) {

                    if (element == 'error') {

                        $.confirm({
                            title: 'Внимание',
                            titleIcon: 'glyphicon glyphicon-warning-sign',
                            template: 'warning',
                            templateOk: 'warning',
                            message: 'Нельзя удалить вопрос есть связанные элементы!',
                            labelOk: 'ОК',
                            buttonCancel: false,
                            onOk: function() {
                            }
                        });

                    }
                    else {
                        $.confirm({
                            title: 'Информация',
                            titleIcon: 'glyphicon glyphicon-info-sign',
                            template: 'info',
                            templateOk: 'info',
                            message: 'Вопрос удален.',
                            labelOk: 'ОК',
                            buttonCancel: false,
                            onOk: function() {
                                $("#question").html(element);
                            }
                        });

                    }
                });
            },
            onCancel: function() {
            }
        });
    }
    ;
</script>



</body>
</html>




