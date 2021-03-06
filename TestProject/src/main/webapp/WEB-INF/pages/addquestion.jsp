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

    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/table.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/switch.css" rel="stylesheet">


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
        <div class="col-xs-6">
            <h3 class="text-center" style="color: white">Вопрос</h3>
            <button type="button" class="btn btn-primary btn-success" id="addnewquestion">Создать новый вопрос</button>
            <button type="button" class="btn btn-primary btn-black" id="turnongod">Режим "Бога"</button>
            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
            <div class="input-group">
                <span class="input-group-addon"><i class="ti-folder"></i></span>
                <input type="text" value="${category}" class="form-control" id="category" name="category" disabled>
                <span class="input-group-addon"><a href="javascript:changedirectory()">...</a></span>
                <input type="hidden" value="${categoryid}" id="categoryid" name="categoryid" disabled>

            </div>
            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
            <div class="input-group">
                <span class="input-group-addon"><i class="ti-key"></i></span>
                <input type="text" value="${code}" class="form-control" id="code" name="code" placeholder="Код вопроса"
                       disabled>
            </div>
            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">

            <div class="form-group">
                <button type="button" class="btn btn-primary btn-warning" id="writequestion">Записать вопрос</button>
                <button type="button" class="btn btn-primary btn-search" id="addanswer">Добавить ответ</button>
            </div>

            <div class="btn-group" data-toggle="buttons">

                <c:if test="${questiontype==1}">
                    <label class="btn btn-success active">
                        <input type="radio" name="typequestion" id="option1" value="1" checked=""> Один
                    </label>
                    <label class="btn btn-warning">
                        <input type="radio" name="typequestion" id="option2" value="2"> Несколько
                    </label>
                    <label class="btn btn-primary">
                        <input type="radio" name="typequestion" id="option3" value="3"> Поле ввода
                    </label>
                </c:if>

                <c:if test="${questiontype==2}">
                    <label class="btn btn-success">
                        <input type="radio" name="typequestion" id="option1" value="1"> Один
                    </label>
                    <label class="btn btn-warning active">
                        <input type="radio" name="typequestion" id="option2" value="2" checked=""> Несколько
                    </label>
                    <label class="btn btn-primary">
                        <input type="radio" name="typequestion" id="option3" value="3"> Поле ввода
                    </label>
                </c:if>

                <c:if test="${questiontype==3}">
                    <label class="btn btn-success">
                        <input type="radio" name="typequestion" id="option1" value="1"> Один
                    </label>
                    <label class="btn btn-warning">
                        <input type="radio" name="typequestion" id="option2" value="2"> Несколько
                    </label>
                    <label class="btn btn-primary active">
                        <input type="radio" name="typequestion" id="option3" value="3" checked=""> Поле ввода
                    </label>
                </c:if>

            </div>

            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
            <form id="formpicture">
                <input id="addpic" type="file" accept="image/*" title="Добавить картинку"
                       name="image" data-filename-placement="inside"/>
            </form>


            <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
            <div class="input-group">
                <%--<div class="form-group">--%>
                <textarea cols="80" id="editorCk" name="question" rows="30"
                          style="height: 90%">${questiontext}</textarea>
                <%--</div>--%>
            </div>
        </div>

        <div class="col-xs-6">
            <h3 class="text-center" style="color: white">Список ответов</h3>
            <table id="answers" class="table" data-provide="data-table" cellspacing="0" width="100%">
                ${table}
            </table>

        </div>
    </div>

</header>
<!-- END Site header -->
<main>
    <%--ouranswerID--%>
    <input type="hidden" class="form-control" id="answerid" name="answerid">


    <div class="modal fade" id="myModalRadioChecked" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Ответ</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">

                        <div class="input-group">

                <textarea cols="80" id="editorAn" name="answer" rows="30"
                          style="height: 90%"></textarea>

                        </div>

                    </div>
                </div>
                <div class="container">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-success">
                            <input type="radio" name="typeanswer" id="flaganswer" value="1"> Правильный
                        </label>
                        <label class="btn btn-warning active">
                            <input type="radio" name="typeanswer" id="flaganswer" value="0" checked=""> Неправильный
                        </label>
                    </div>
                </div>
                <div class="modal-footer">
                    <form id="modalpicture">
                        <input id="addpicture" type="file" accept="image/*" title="Добавить картинку"
                               name="image" data-filename-placement="inside"/>

                        <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="writeanswer">Записать
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="myModalText" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Ответ</h4>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="ti-agenda"></i></span>
                            <input type="text" class="form-control" id="answertext" name="answertext"
                                   placeholder="Текст ответа">
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="writean">Записать
                    </button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="treeparent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Изменить категорию</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <button class="btn btn-primary btn-search" type="submit" onclick="expandparent()"
                                style="margin-left: 20px">Развернуть
                        </button>
                        <button class="btn btn-primary btn-search" type="submit" onclick="collapseparent()">Свернуть
                        </button>
                        <hr class="hr-xs" style="height: 5px; margin-bottom: 5px; margin-top: 5px">
                    </div>

                    <div id="treeforparent" style="color: dodgerblue; text-align:left; margin-right: 20px "></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

        <div class="modal fade" id="keyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Введите пароль для включения режима "БОГА"</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="ti-key"></i></span>
                                <input type="password" id="idgod" value="" class="form-control" name="idgod"
                                       placeholder="Значение">
                                <input type="hidden" id="passwordgod" value="">
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-danger" data-dismiss="modal">Отмена</button>
                        <button type="button" class="btn btn-success" data-dismiss="modal" id="opengodregime">Включить
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
</main>

<!-- END Main container -->
<!-- Back to top button -->
<%--<%@ include file="../pages/template/templatefoot.jsp" %>--%>
<%--<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/ckeditor/ckeditor.js"></script>

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
    $('#treeforparent').treeview({data: getTree()});

    function expandparent() {
        $('#treeforparent').treeview('expandAll', {levels: 100, silent: true});
    }
    function collapseparent() {
        $('#treeforparent').treeview('collapseAll', {levels: 100, silent: true});
    }

    function changedirectory() {
        $('#treeparent').modal('show');
    }

    var parent;
    $('#treeforparent').on('nodeSelected', function (event, data) {
        $.confirm({
            template: 'primary',
            templateOk: 'primary',
            message: 'Вы уверены что хотите изменить категорию?',
            onOk: function () {
                $('#category').val(data.text);
                $('#categoryid').val(data.href);
                $("#treeparent").modal('hide');
            }
        });
    });

</script>


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

    CKEDITOR.replace('editorAn', {
        removePlugins: 'sourcearea',
        entities: false,
        language: 'ru',
        width: 565,
        startupFocus: true,
        uiColor: '#FFFFFF'
    });


    jQuery.fn.modal.Constructor.prototype.enforceFocus = function () {
        modal_this = this
        jQuery(document).on('focusin.modal', function (e) {
            if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
                    && !jQuery(e.target.parentNode).hasClass('cke_dialog_ui_input_select')
                    && !jQuery(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
                modal_this.$element.focus()
            }
        })
    };
</script>


<script type="text/javascript">
    function clearForNewQuestion() {
        $("input[name='typequestion']:checked").val(1);
        CKEDITOR.instances.editorAn.setData('');
        CKEDITOR.instances.editorCk.setData('');
        $("#code").val('');
        $("#answers").html('');
    }


    function writeAfterCheck(flag) {
        if (strip(CKEDITOR.instances.editorCk.getData()).trim() != '') {

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/writequestion",
                data: {
                    category: $('#categoryid').val(),
                    question: CKEDITOR.instances.editorCk.getData(),
                    code: $('#code').val(),
                    typeq: $("input[name='typequestion']:checked").val()
                },
                dataType: "text",
                success: {
                    function (codeQ) {
                        $('#code').val(codeQ);
                    },
                    error: {
                        function (codeQ) {
                            $.confirm({
                                title: 'Внимание',
                                titleIcon: 'glyphicon glyphicon-warning-sign',
                                template: 'warning',
                                templateOk: 'warning',
                                message: 'Ошибка! Добавления/обновления',
                                labelOk: 'ОК',
                                buttonCancel: false,
                                onOk: function () {
                                }
                            });

                        }
                    }

                }
            }).done(function (codeQ) {

                if (codeQ == "Не может быть несколько ответов при таком типе вопроса" || codeQ == "Ошибка! Проверьте тип вопроса и кол-во ответов" || codeQ == "Ошибка! Проверьте тип вопроса и кол-во правильных ответов") {
                    $.confirm({
                        title: 'Внимание',
                        titleIcon: 'glyphicon glyphicon-warning-sign',
                        template: 'warning',
                        templateOk: 'warning',
                        message: codeQ,
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function () {
                        }
                    });
                } else {
                    if (flag == 1) {
                        $('#code').val(codeQ);
                    }

                    $.confirm({
                        title: 'Информация',
                        titleIcon: 'glyphicon glyphicon-info-sign',
                        template: 'info',
                        templateOk: 'info',
                        message: 'Добавлен/обновлен вопрос в базу',
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function () {
                            if (flag == 1) {
                                $.ajax({
                                    type: "POST",
                                    url: "${pageContext.request.contextPath}/createtree",
                                    data: {
                                        code: $('#code').val(),
                                        context: "${pageContext.request.contextPath}"
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
                                }).done(function (codeQ) {
                                    if (flag == 1) {
                                        $("#answers").html(codeQ);
                                    }
                                })
                            } else {

                                clearForNewQuestion();
                            }

                        }
                    });

                }
            });
        }
        else    $.confirm({
            title: 'Информация',
            titleIcon: 'glyphicon glyphicon-info-sign',
            template: 'info',
            templateOk: 'info',
            message: 'Нельзя добавлять пустой вопрос',
            labelOk: 'ОК',
            buttonCancel: false,
            onOk: function () {
            }
        });
    }


    function writeQuestionDB(flag) {

        if ($('#code').val().trim() != "") {
            //проверка
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/checkquestion",
                data: {
                    idquestion: $('#code').val(),
                    idkey: $('#passwordgod').val()
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
                if (element == "error") {
                    $.confirm({
                        title: 'Внимание',
                        titleIcon: 'glyphicon glyphicon-warning-sign',
                        template: 'warning',
                        templateOk: 'warning',
                        message: 'Ошибка! Нельзя исправлять вопрос так как есть уже пройденные тесты с этим вопросом',
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function () {
                            return;
                        }
                    });

                }
                else {

                    writeAfterCheck(flag);

                }
            });


        } else {
            writeAfterCheck(flag);
        }


    }

    $(document).ready(function () {
        $("#turnongod").click(function () {
                $("#keyModal").modal('show');

        });

        $("#opengodregime").click(function () {
            $("#passwordgod").val($("#idgod").val());

        });

        $("#addnewquestion").click(function () {

            $.confirm({
                template: 'primary',
                templateOk: 'primary',
                message: 'Вы уверены что хотите ввести новый вопрос?',
                onOk: function () {
                    $.confirm({
                        template: 'primary',
                        templateOk: 'primary',
                        message: 'Записать в базу текущий вопрос?',
                        onOk: function () {
                            writeQuestionDB(0);

                        },
                        onCancel: function () {
                            clearForNewQuestion();
                        }
                    });
                }
            });

        });


        $("#addanswer").click(function () {

            if ($('#code').val().trim() == '') {
                $.confirm({
                            title: 'Информация',
                            titleIcon: 'glyphicon glyphicon-info-sign',
                            template: 'info',
                            templateOk: 'info',
                            message: 'Необходимо записать вопрос, перед добавлением ответов',
                            labelOk: 'ОК',
                            buttonCancel: false,
                            onOk: function () {
                            }
                        }
                )
            }
            else {

                //проверка
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/checkquestion",
                    data: {
                        idquestion: $('#code').val(),
                        idkey: $('#passwordgod').val()
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
                    if (element == "ok") {
                        $('#answerid').val('');
                        $('#answertext').val('');
                        CKEDITOR.instances.editorAn.setData('');

                        if ($("input[name='typequestion']:checked").val() < 3) {
                            $("#myModalRadioChecked").modal('show');
                        }
                        else {
                            $("#myModalText").modal('show');
                        }
                    }
                    else {
                        $.confirm({
                            title: 'Внимание',
                            titleIcon: 'glyphicon glyphicon-warning-sign',
                            template: 'warning',
                            templateOk: 'warning',
                            message: 'Ошибка! Нельзя добавить ответ так как есть уже пройденные тесты с этим вопросом',
                            labelOk: 'ОК',
                            buttonCancel: false,
                            onOk: function () {
                            }
                        });
                    }

                });


            }
        });


        $("#writean").click(function () {

            //проверка
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/checkquestion",
                data: {
                    idquestion: $('#code').val(),
                    idkey: $('#passwordgod').val()
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
                if (element == "ok") {


                    if ($("input[name='typequestion']:checked").val() == 3) {
                        if ($('#answertext').val().trim() != '') {
                            $.ajax({
                                type: "POST",
                                url: "${pageContext.request.contextPath}/writeanswer",
                                data: {
                                    answer: $('#answertext').val(),
                                    codequestion: $('#code').val(),
                                    flag: 1,
                                    typeq: $("input[name='typequestion']:checked").val(),
                                    answerid: $('#answerid').val(),
                                    context: "${pageContext.request.contextPath}"
                                },
                                dataType: "text",
                                success: {
                                    function (codeQ) {
                                    },
                                    error: {
                                        function (codeQ) {
                                            $.confirm({
                                                title: 'Внимание',
                                                titleIcon: 'glyphicon glyphicon-warning-sign',
                                                template: 'warning',
                                                templateOk: 'warning',
                                                message: 'Ошибка! Добавления/обновления ответа',
                                                labelOk: 'ОК',
                                                buttonCancel: false,
                                                onOk: function () {
                                                }
                                            });

                                        }
                                    }
                                }
                            }).done(function (codeQ) {
                                if (codeQ == "Не может быть несколько ответов при таком типе вопроса" || codeQ == "Ошибка! Проверьте тип вопроса и кол-во ответов" || codeQ == "Ошибка! Проверьте тип вопроса и кол-во правильных ответов") {
                                    $.confirm({
                                        title: 'Внимание',
                                        titleIcon: 'glyphicon glyphicon-warning-sign',
                                        template: 'warning',
                                        templateOk: 'warning',
                                        message: codeQ,
                                        labelOk: 'ОК',
                                        buttonCancel: false,
                                        onOk: function () {
                                        }
                                    });
                                } else {
                                    $("#answers").html(codeQ);
                                    $.confirm({
                                        title: 'Информация',
                                        titleIcon: 'glyphicon glyphicon-info-sign',
                                        template: 'info',
                                        templateOk: 'info',
                                        message: 'Добавлен/обновлен ответ в базу',
                                        labelOk: 'ОК',
                                        buttonCancel: false,
                                        onOk: function () {
                                        }
                                    });
                                }
                            });
                        }
                        else {
                            $.confirm({
                                title: 'Информация',
                                titleIcon: 'glyphicon glyphicon-info-sign',
                                template: 'info',
                                templateOk: 'info',
                                message: 'Нельзя добавлять пустой ответ',
                                labelOk: 'ОК',
                                buttonCancel: false,
                                onOk: function () {
                                }
                            });
                        }
                    }


                }
                else {
                    $.confirm({
                        title: 'Внимание',
                        titleIcon: 'glyphicon glyphicon-warning-sign',
                        template: 'warning',
                        templateOk: 'warning',
                        message: 'Ошибка! Нельзя добавить ответ так как есть уже пройденные тесты с этим вопросом',
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function () {
                        }
                    });
                }

            });


        });


        $("#writeanswer").click(function () {

            //проверка
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/checkquestion",
                data: {
                    idquestion: $('#code').val(),
                    idkey: $('#passwordgod').val()
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
                if (element == "ok") {

                    if ($("input[name='typequestion']:checked").val() < 3) {
                        if (strip(CKEDITOR.instances.editorAn.getData()).trim() != '') {

                            $.ajax({
                                type: "POST",
                                url: "${pageContext.request.contextPath}/writeanswer",
                                data: {
                                    answer: CKEDITOR.instances.editorAn.getData(),
                                    codequestion: $('#code').val(),
                                    flag: $("input[name='typeanswer']:checked").val(),
                                    typeq: $("input[name='typequestion']:checked").val(),
                                    answerid: $('#answerid').val(),
                                    context: "${pageContext.request.contextPath}"
                                },
                                dataType: "text",
                                success: {
                                    function (codeQ) {
                                    },
                                    error: {
                                        function (codeQ) {
                                            $.confirm({
                                                title: 'Внимание',
                                                titleIcon: 'glyphicon glyphicon-warning-sign',
                                                template: 'warning',
                                                templateOk: 'warning',
                                                message: 'Ошибка! Добавления/обновления ответа',
                                                labelOk: 'ОК',
                                                buttonCancel: false,
                                                onOk: function () {
                                                }
                                            });

                                        }
                                    }
                                }
                            }).done(function (codeQ) {
                                if (codeQ == "Не может быть несколько ответов при таком типе вопроса" || codeQ == "Ошибка! Проверьте тип вопроса и кол-во ответов" || codeQ == "Ошибка! Проверьте тип вопроса и кол-во правильных ответов") {
                                    $.confirm({
                                        title: 'Внимание',
                                        titleIcon: 'glyphicon glyphicon-warning-sign',
                                        template: 'warning',
                                        templateOk: 'warning',
                                        message: codeQ,
                                        labelOk: 'ОК',
                                        buttonCancel: false,
                                        onOk: function () {
                                        }
                                    });
                                } else {
                                    $("#answers").html(codeQ);
                                    $.confirm({
                                        title: 'Информация',
                                        titleIcon: 'glyphicon glyphicon-info-sign',
                                        template: 'info',
                                        templateOk: 'info',
                                        message: 'Добавлен/обновлен ответ в базу',
                                        labelOk: 'ОК',
                                        buttonCancel: false,
                                        onOk: function () {
                                        }
                                    });
                                }
                            });
                        }
                        else    $.confirm({
                            title: 'Информация',
                            titleIcon: 'glyphicon glyphicon-info-sign',
                            template: 'info',
                            templateOk: 'info',
                            message: 'Нельзя добавлять пустой ответ',
                            labelOk: 'ОК',
                            buttonCancel: false,
                            onOk: function () {
                            }
                        });
                    }
                }
                else {
                    $.confirm({
                        title: 'Внимание',
                        titleIcon: 'glyphicon glyphicon-warning-sign',
                        template: 'warning',
                        templateOk: 'warning',
                        message: 'Ошибка! Нельзя исправить ответ так как есть уже пройденные тесты с этим вопросом',
                        labelOk: 'ОК',
                        buttonCancel: false,
                        onOk: function () {
                        }
                    });
                }
            });

        });


        $("#writequestion").click(function () {
            writeQuestionDB(1);
        });


        $("#addpicture").change(function () {
            if (typeof  jcrop_api != 'undefined') {
                jcrop_api.destroy();
            }
            var oFReader = new FileReader();
            oFReader.readAsDataURL(document.getElementById('addpicture').files[0]);
            oFReader.onload = function (oFREvent) {
                $('#addpicture').siblings('span').html('Добавить картинку').attr('title', 'Добавить картинку').show();
                document.getElementById('modalpicture').reset();
                CKEDITOR.instances.editorAn.setData(CKEDITOR.instances.editorAn.getData() + ' <img src="' + oFREvent.target.result + '" />');
            };

        });


        $("#addpic").change(function () {
            if (typeof  jcrop_api != 'undefined') {
                jcrop_api.destroy();
            }
            var oFReader = new FileReader();
            oFReader.readAsDataURL(document.getElementById('addpic').files[0]);
            oFReader.onload = function (oFREvent) {
                $('#addpic').siblings('span').html('Добавить картинку').attr('title', 'Добавить картинку').show();
                document.getElementById('formpicture').reset();
                CKEDITOR.instances.editorCk.setData(CKEDITOR.instances.editorCk.getData() + ' <img src="' + oFREvent.target.result + '" />');
            };

        });


    });

</script>


<script type="text/javascript" charset="utf-8">

    function strip(html) {
        return html.replace(/</g, "").replace(/>/g, "");
    }

    function fundelanswer(idanswer, idquestion) {

        //проверка
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/checkquestion",
            data: {
                idquestion: $('#code').val(),
                idkey: $('#passwordgod').val()
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
            if (element == "ok") {
                $.confirm({
                    template: 'primary',
                    templateOk: 'primary',
                    message: 'Вы уверены что хотите удалить ответ?',
                    onOk: function () {
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/delanswer",
                            data: {
                                idquestion: idquestion,
                                context: "${pageContext.request.contextPath}",
                                idanswer: idanswer
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
                                    message: 'Нельзя удалить ответ есть пройденные тесты с этим вопросом!',
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
                                    message: 'Ответ удален.',
                                    labelOk: 'ОК',
                                    buttonCancel: false,
                                    onOk: function () {
                                        $("#answers").html(element);
                                    }
                                });

                            }
                        });
                    },
                    onCancel: function () {
                    }
                });
            }else{
                $.confirm({
                    title: 'Внимание',
                    titleIcon: 'glyphicon glyphicon-warning-sign',
                    template: 'warning',
                    templateOk: 'warning',
                    message: 'Ошибка! Нельзя удалить ответ так как есть уже пройденные тесты с этим вопросом',
                    labelOk: 'ОК',
                    buttonCancel: false,
                    onOk: function () {
                    }
                });
            }
        })
    }

    function funeditanswer(idanswer) {
        //проверка
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/checkquestion",
            data: {
                idquestion: $('#code').val(),
                idkey: $('#passwordgod').val()
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
            if (element == "ok") {


                $('#answerid').val(idanswer);
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/editanswer",
                    data: {
                        idanswer: idanswer
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

                    if ($("input[name='typequestion']:checked").val() < 3) {

                        CKEDITOR.instances.editorAn.setData(element);

                        $("#myModalRadioChecked").modal('show');
                    }
                    else {
                        $('#answertext').val(element);
                        $("#myModalText").modal('show');
                    }

                })
            } else {
                $.confirm({
                    title: 'Внимание',
                    titleIcon: 'glyphicon glyphicon-warning-sign',
                    template: 'warning',
                    templateOk: 'warning',
                    message: 'Ошибка! Нельзя исправить ответ так как есть уже пройденные тесты с этим вопросом',
                    labelOk: 'ОК',
                    buttonCancel: false,
                    onOk: function () {
                    }
                });
            }
        })
    }
</script>
<%@ include file="../pages/template/templatefoot.jsp" %>
</body>
</html>




