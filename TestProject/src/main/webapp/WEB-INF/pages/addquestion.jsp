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
            <div class="input-group">
                <span class="input-group-addon"><i class="ti-folder"></i></span>
                <input type="text" value="${category}" class="form-control" id="category" name="category" disabled>
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
            <div class="input-group">
                <%--<div class="form-group">--%>
                <textarea cols="80" id="editorCk" name="question" rows="30"
                          style="height: 90%">${questiontext}</textarea>
                <%--</div>--%>
            </div>
        </div>

        <div class="col-xs-6">
            <h3 class="text-center" style="color: white">Список ответов</h3>
            <table id="question" class="table" data-provide="data-table" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>Код</th>
                    <th>Ответ</th>
                    <th>Флаг ответа</th>
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
                            <input type="radio" name="typeanswer" id="flaganswer" value="2" checked=""> Неправильный
                        </label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="writeanswer">Записать
                    </button>
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
                                <input type="text" class="form-control" id="answertext" name="answertext" placeholder="Текст ответа">
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="writeanswer">Записать
                    </button>
                </div>
            </div>
        </div>
    </div>


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
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-confirm.js"></script>

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
    $(document).ready(function () {
        $("#addanswer").click(function () {

            if (document.getElementById('code').value == '') {
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
                if ($("input[name='typequestion']:checked").val() < 3) {
                    $("#myModalRadioChecked").modal('show');
                }
                else{
                    $("#myModalText").modal('show');
                }
            }
        })
    });
</script>

<script type="text/javascript">
    function strip(html) {
        var tmp = document.createElement("DIV");
        tmp.innerHTML = html;
        return tmp.textContent || tmp.innerText;
    }
</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#writeanswer").click(function () {
            if ($("input[name='typeanswer']:checked").val()==3) {

                if (document.getElementById('answertext').value==''){
                    $.ajax({
                        type: "POST",
                        url: "${pageContext.request.contextPath}/writeanswer",
                        data: {
                            answer: document.getElementById('answertext').value,
                            codequestion: document.getElementById('code').value,
                            flag: 1,
                            typeq: $("input[name='typequestion']:checked").val(),
                            answerid: document.getElementById('answerid').value
                        },
                        dataType: "text",
                        success: {
                            function (codeQ) {},
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
//                    document.getElementById('code').value = codeQ; //обновить таблицу ответов
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
            else {
                if (strip(CKEDITOR.instances.editorAn.getData()).trim()!=''){

                    $.ajax({
                        type: "POST",
                        url: "${pageContext.request.contextPath}/writeanswer",
                        data: {
                            answer: CKEDITOR.instances.editorAn.getData(),
                            codequestion: document.getElementById('code').value,
                            flag: $("input[name='typeanswer']:checked").val(),
                            typeq: $("input[name='typequestion']:checked").val(),
                            answerid: document.getElementById('answerid').value
                        },
                        dataType: "text",
                        success: {
                            function (codeQ) {},
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
//                    document.getElementById('code').value = codeQ; //обновить таблицу ответов
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
        });
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#writequestion").click(function () {


            if (strip(CKEDITOR.instances.editorCk.getData()).trim()!=''){

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/writequestion",
                data: {
                    category: document.getElementById('category').value,
                    question: CKEDITOR.instances.editorCk.getData(),
                    code: document.getElementById('code').value,
                    typeq: $("input[name='typequestion']:checked").val()
                },
                dataType: "text",
                success: {
                    function (codeQ) {
                        document.getElementById('code').value = codeQ;
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
                document.getElementById('code').value = codeQ;

                $.confirm({
                    title: 'Информация',
                    titleIcon: 'glyphicon glyphicon-info-sign',
                    template: 'info',
                    templateOk: 'info',
                    message: 'Добавлен/обновлен вопрос в базу',
                    labelOk: 'ОК',
                    buttonCancel: false,
                    onOk: function () {
                    }
                });


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
        });
    });
</script>

</body>
</html>




