<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta name="http-equiv" content="Content-type: text/html; charset=UTF-8">

    <title>Тестирование-Дерево тестов</title>


    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-treeview.css" rel="stylesheet"/>
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
        <h3 class="text-center" style="color: white">Дерево тестов</h3>
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
                <%--<a href="#upModal" data-toggle="modal"--%>
                   <%--class="btn btn-primary btn-search">Редак.</a>--%>
                <%--<a href="#del" data-toggle="modal"--%>
                   <%--class="btn btn-primary btn-danger">Удалить</a>--%>

                <button class="btn btn-primary btn-search" type="submit" onclick="openedit()">Редак.</button>
                <button class="btn btn-primary btn-danger" type="submit" onclick="opendel()">Удалить</button>
            </div>

            <div id="treeview" style="color: dodgerblue; text-align:left "></div>

        </div>


        <div class="col-xs-8">

            <form id="addtest" class="addtest" method="post"
                  action="${pageContext.request.contextPath}/addtest" commandName="addtest">
                <input type="hidden" value="" class="form-control" id="categoryfortest" name="categoryfortest">
                <input type="hidden" value="" class="form-control" id="categoryfortestid" name="categoryfortestid">
                <button type="button" class="btn btn-primary btn-search" id="addnewtest">Добавить тест</button>
            </form>

            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 15px">
            <table id="tests" class="table" data-provide="data-table" cellspacing="0" width="100%">

                <thead>
                <tr>
                    <th>Тест</th>
                    <th>Редактировать</th>
                    <th>Скопировать</th>
                    <th>Удалить</th>
                </tr>
                </thead>

            </table>

        </div>

    </div>

</header>
<!-- END Site header -->

<main>


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
                            <span class="input-group-addon"><i class="ti-info"></i></span>
                            <input type="text" value="" class="form-control" name="description" id="description"
                                   placeholder="Описание категории">
                        </div>
                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="ti-folder"></i></span>
                            <input type="hidden" id="categoryid" name="categoryid">
                            <input type="text" id="category" value="" class="form-control" name="name"
                                   placeholder="Родитель" disabled>
                        </div>

                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">

                        <div class="input-group">
                            <input type="hidden" id="pimg" name="pimg"/>
                            <span class="input-group-addon"><i class="ti-paint-bucket"></i></span>
                            <input id="uploadImage" type="file" accept="image/*" title="Выберите файл картинки"
                                   name="image" data-filename-placement="inside"/>
                        </div>

                        <img id="uploadPreview" style="display:none; align-content: center; width:20%;"/>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" onclick="clearParent()">Очистить родителя
                            </button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="clearElements()">
                                Отмена
                            </button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="addcategory">Добавить
                            </button>
                        </div>
                    </div><!-- /.modal-content -->
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade" id="upModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
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
                        <input type="hidden" id="oldcategoryid" name="oldcategoryid">
                        <input type="hidden" id="oldcategory" value="" class="form-control" name="parent"
                               placeholder="Старое значение" disabled>

                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">

                        <div class="input-group">
                            <span class="input-group-addon"><i class="ti-info"></i></span>
                            <input type="text" value="" class="form-control" name="description" id="descr"
                                   placeholder="Описание категории">
                        </div>
                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">

                        <div class="input-group">
                            <span class="input-group-addon"><i class="ti-folder"></i></span>
                            <input type="hidden" id="parentid" name="parentid">
                            <input type="text" id="parent" value="" class="form-control" name="parent"
                                   placeholder="Родитель" disabled>
                        </div>

                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">

                        <div class="input-group">
                            <input type="hidden" id="pimg2" name="pimg2"/>
                            <span class="input-group-addon"><i class="ti-paint-bucket"></i></span>
                            <input id="uploadIm" type="file" accept="image/*" title="Выберите файл картинки"
                                   name="image" data-filename-placement="inside"/>
                        </div>

                        <img id="uploadPr" style="display:none; align-content: center; width:20%;"/>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="openParent()">Изменить родителя</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="updatecategory">
                        Изменить
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <div class="modal fade" id="del" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
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
                            <input type="hidden" id="delcategoryid"  name="delcategoryid">
                            <input type="text" id="delcategory" value="" class="form-control" name="delcategory"
                                   placeholder="Значение" disabled>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal" id="deletecategory">
                        Удалить
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <div class="modal fade" id="treeparent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Изменить родителя</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <button class="btn btn-primary btn-search" type="submit" onclick="expandparent()" style="margin-left: 20px">Развернуть</button>
                        <button class="btn btn-primary btn-search" type="submit" onclick="collapseparent()">Свернуть</button>
                        <button class="btn btn-primary btn-danger" type="submit" onclick="clearParent()">Очистить родителя</button>
                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
                    </div>

                    <div id="treeforparent" style="color: dodgerblue; text-align:left; margin-right: 20px "></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Отмена</button>
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
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.file-input.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-confirm.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-treeview.js"></script>

<script type="text/javascript">

    $('input[type=file]').bootstrapFileInput();

    function getTree() {
        return ${tree};
    }
    $('#treeview').treeview({data: getTree()});
    $('#treeforparent').treeview({data: getTree()});
    function expand() {
        $('#treeview').treeview('expandAll', {levels: 100, silent: true});
    }
    function collapse() {
        $('#treeview').treeview('collapseAll', {levels: 100, silent: true});
    }

    function expandparent() {
        $('#treeforparent').treeview('expandAll', {levels: 100, silent: true});
    }
    function collapseparent() {
        $('#treeforparent').treeview('collapseAll', {levels: 100, silent: true});
    }

    function clearElements() {
        $('#namecategory').val("");
        $('#description').val("");
        $('#category').val("");
        $('#categoryid').val("");
        $('#pimg').val("");
        $('#uploadImage').siblings('span').html('Выберите файл картинки').attr('title', 'Выберите файл картинки').show();
        $("#uploadPreview").hide();
    }

    function openParent() {
        $("#treeparent").modal('show');
    }

    function opendel() {
        if ($('#delcategoryid').val() == "") {
            $.confirm({
                title: 'Внимание',
                titleIcon: 'glyphicon glyphicon-warning-sign',
                template: 'warning',
                templateOk: 'warning',
                message: 'Выберите категорию!',
                labelOk: 'ОК',
                buttonCancel: false,
                onOk: function () {
                }
            });
        } else {
            $("#del").modal('show');
        }

    }

    function openedit() {
        if ($('#upcategory').val() == "") {
            $.confirm({
                title: 'Внимание',
                titleIcon: 'glyphicon glyphicon-warning-sign',
                template: 'warning',
                templateOk: 'warning',
                message: 'Выберите категорию!',
                labelOk: 'ОК',
                buttonCancel: false,
                onOk: function () {
                }
            });
        } else {

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/getparenttest",
                data: {
                    category: $('#oldcategoryid').val()
                }
            }).done(function (element) {
                pardesc = JSON.parse(element);
                $('#parent').val(pardesc.parent);
                $('#parentid').val(pardesc.parentid);
                $('#descr').val(pardesc.desc);
            });

            $("#upModal").modal('show');
        }

    }
</script>


<script type="text/javascript">
    $(document).ready(function () {
                $("#addnewtest").click(function () {
                            if ($('#categoryfortest').val() == '') {
                                $.confirm({
                                    title: 'Внимание',
                                    titleIcon: 'glyphicon glyphicon-warning-sign',
                                    template: 'warning',
                                    templateOk: 'warning',
                                    message: "Выберите категорию для добавления теста.",
                                    labelOk: 'ОК',
                                    buttonCancel: false,
                                    onOk: function () {
                                    }
                                });

                            } else {
                                $('#addtest').submit();
                            }
                        }
                );

                $("#deletecategory").click(function () {
                    $.ajax({
                        type: "POST",
                        url: "${pageContext.request.contextPath}/delcategorytest",
                        data: {
                            namecategory: $('#delcategoryid').val()
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
                                onOk: function () {
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
                                onOk: function () {
                                    location.reload();
                                }
                            });

                        }
                    });
                });

                $("#addcategory").click(function () {
                    if ($('#namecategory').val() != '') {
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/addcategorytest",
                            data: {
                                namecategory: $('#namecategory').val(),
                                parent: $('#categoryid').val(),
                                description: $('#description').val(),
                                picture: $('#pimg').val()
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
                                onOk: function () {
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
                            message: 'Нельзя создавать пустую категорию.',
                            labelOk: 'ОК',
                            buttonCancel: false,
                            onOk: function () {
                            }
                        });
                    }
                });
                $("#updatecategory").click(function () {

                            if ($('#upcategory').val() != '') {
                                $.ajax({
                                    type: "POST",
                                    url: "${pageContext.request.contextPath}/updatecategorytest",
                                    data: {
                                        namecategory: $('#upcategory').val(),
                                        oldcategory: $('#oldcategoryid').val(),
                                        parent: $('#parentid').val(),
                                        description: $('#descr').val(),
                                        picture: $('#pimg2').val()
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
                                        onOk: function () {
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
                                    onOk: function () {
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
        $('#category').val("");
        $('#categoryid').val(0);
        $('#parent').val("");
        $('#parentid').val(0);
        $('#treeparent').modal('hide');
    }
    var parent;

    $('#treeforparent').on('nodeSelected', function (event, data) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/getchecktestcategory",
            data: {
                categorycheck: data.href,
                ourcategory:$('#oldcategoryid').val()
            }
        }).done(function (element) {
            if (element=='ok') {
                $.confirm({
                    template: 'primary',
                    templateOk: 'primary',
                    message: 'Вы уверены что хотите изменить родителя?',
                    onOk: function() {
                        $('#parent').val(data.text);
                        $('#parentid').val(data.href);
                        $("#treeparent").modal('hide');
                    }

                });

            } else{
                $.confirm({
                    title: 'Внимание',
                    titleIcon: 'glyphicon glyphicon-warning-sign',
                    template: 'warning',
                    templateOk: 'warning',
                    message: 'Нельзя выбирать вложенную категорию',
                    labelOk: 'ОК',
                    buttonCancel: false,
                    onOk: function () {
                    }
                });
            }
        });
    });


    $('#treeview').on('nodeSelected', function (event, data) {

        $('#upcategory').val(data.text);
        $('#oldcategory').val(data.text);
        $('#oldcategoryid').val(data.href);
        $('#category').val(data.text);
        $('#categoryid').val(data.href);
        $('#delcategory').val(data.text);
        $('#delcategoryid').val(data.href);
        $('#parent').val("");
        $('#parentid').val("");
        $('#categoryfortest').val(data.text);
        $('#categoryfortestid').val(data.href);

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/getparenttest",
            data: {
                category: data.href
            }
        }).done(function (element) {

            pardesc = JSON.parse(element);

            $('#parent').val(pardesc.parent);
            $('#parentid').val(pardesc.parentid);
            $('#descr').val(pardesc.desc);

        });


        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/getpicture",
            data: {
                category: data.href
            }
        }).done(function (element) {

            $('#pimg2').val("");
            $('#uploadIm').siblings('span').html('Выберите файл картинки').attr('title', 'Выберите файл картинки').show();
            $("#uploadPr").hide();

            if (element != "") {
                var uploadPreview = $("#uploadPr");
                uploadPreview.attr('src', element).show();
                $("#pimg2").val(element);
                $("#uploadIm").change(function () {
                    var img = new Image();
                    img.onload = function () {
                        pic_width = this.width;
                        pic_height = this.height;
                    };
                    img.src = element;

                });
            }
        });

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/gettest",
            data: {
                category: data.href,
                context: "${pageContext.request.contextPath}"
            }
        }).done(function (element) {
            $("#tests").html(element);

        })

    });

    function fundeltest(idtest) {
        var cont;
        if (${pageContext.request.contextPath==""}) {
            cont = "empty";
        }
        else {
            cont = "${pageContext.request.contextPath}"
        }

        $.confirm({
            template: 'primary',
            templateOk: 'primary',
            message: 'Вы уверены что хотите удалить тест?',
            onOk: function () {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/deltest",
                    data: {
                        id: idtest,
                        context: cont,
                        category: $('#categoryid').val()
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
                            message: 'Нельзя удалить тест есть связанные элементы!',
                            labelOk: 'ОК',
                            buttonCancel: false,
                            onOk: function () {
                            }
                        });

                    }
                    else {
                        $.confirm({
                            title: 'Информация',
                            titleIcon: 'glyphicon glyphicon-info-sign',
                            template: 'info',
                            templateOk: 'info',
                            message: 'Тест удален.',
                            labelOk: 'ОК',
                            buttonCancel: false,
                            onOk: function () {
                                $("#tests").html(element);
                            }
                        });

                    }
                });
            },
            onCancel: function () {
            }
        });
    }


    function funcopytest(idtest) {
        var cont;
        if (${pageContext.request.contextPath==""}) {
            cont = "empty";
        }
        else {
            cont = "${pageContext.request.contextPath}"
        }

        $.confirm({
            template: 'primary',
            templateOk: 'primary',
            message: 'Вы уверены что хотите скопировать тест?',
            onOk: function () {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/copytest",
                    data: {
                        id: idtest,
                        context: cont,
                        category: $('#categoryid').val()
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
                    $.confirm({
                        title: 'Информация',
                        titleIcon: 'glyphicon glyphicon-info-sign',
                        template: 'info',
                        templateOk: 'info',
                        message: 'Тест скопирован',
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function () {
                            $("#tests").html(element);
                        }
                    });
                });
            },
            onCancel: function () {
            }
        });
    }
</script>


<script type="text/javascript">
    $(document).ready(function () {
        var uploadPreview = $("#uploadPreview");
        var pic_width, pic_height;
        var uploadPr = $("#uploadPr");

        $("#uploadImage").change(function () {
            if (typeof  jcrop_api != 'undefined') {
                jcrop_api.destroy();
            }
            var oFReader = new FileReader();
            oFReader.readAsDataURL(document.getElementById("uploadImage").files[0]);
            oFReader.onload = function (oFREvent) {
                uploadPreview.attr('src', oFREvent.target.result).show();
                $("#pimg").val(oFREvent.target.result);
                var img = new Image();
                img.onload = function () {
                    pic_width = this.width;
                    pic_height = this.height;
                };
                img.src = oFREvent.target.result;

            };

        });

        $("#uploadIm").change(function () {
            if (typeof  jcrop_api != 'undefined') {
                jcrop_api.destroy();
            }
            var oFReader = new FileReader();
            oFReader.readAsDataURL(document.getElementById("uploadIm").files[0]);
            oFReader.onload = function (oFREvent) {
                uploadPr.attr('src', oFREvent.target.result).show();
                $("#pimg2").val(oFREvent.target.result);
                var img = new Image();
                img.onload = function () {
                    pic_width = this.width;
                    pic_height = this.height;
                };
                img.src = oFREvent.target.result;

            };

        });
    });

</script>
<%@ include file="../pages/template/templatefoot.jsp" %>
</body>
</html>




