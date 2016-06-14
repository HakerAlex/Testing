<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>Тестирование-Профиль</title>

    <!-- Styles -->

    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/app.min.css" rel="stylesheet">--%>

    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/1.2.1/css/buttons.dataTables.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/table.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/smoke.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/t/zf-5.5.2/jq-2.2.0,dt-1.10.11,b-1.1.2,b-colvis-1.1.2,b-html5-1.1.2/datatables.min.css"/>
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
        <div class="panel panel-info">
            <div class="form-group">
                <h8>Фамилия: <span  id="spanSurname" style="color: dodgerblue">${user.surname}</span> Имя: <span
                        id="spanName" style="color: dodgerblue">${user.name}</span>
                    Телефон: <span id="spanPhone" style="color: dodgerblue">${user.phone}</span> E-mail: <span id="spanEmail"
                            style="color: dodgerblue">${user.email}</span></h8>
                <label class="label btn-primary" onclick="openModal()">Редактировать профиль</label>

                <input type="hidden" id="etalonName" value="${user.name}">
                <input type="hidden" id="etalonSurname" value="${user.surname}">
                <input type="hidden" id="etalonPhone" value="${user.phone}">
                <input type="hidden" id="etalonEmail" value="${user.email}">
                <input type="hidden" id="etalonPassword" value="${user.password}">
            </div>
        </div>
    </div>
    <div class="container">
        <h3 class="text-center" style="color: white">Список пройденных тестов</h3>
    </div>
    <div class="container">

        <table id="tests" class="display nowrap">
            <thead>
            <tr>
                <th>Категория</th>
                <th>Название</th>
                <th>Дата начала</th>
                <th>Дата окончания</th>
                <th>Общее</th>
                <th>Прав.</th>
                <th>Неправ.</th>
                <th>Подробно</th>
            </tr>
            </thead>

            <tfoot>
            <tr>
                <th>Категория</th>
                <th>Название</th>
                <th>Дата начала</th>
                <th>Дата окончания</th>
                <th>Общее</th>
                <th>Прав.</th>
                <th>Неправ.</th>
                <th>Подробно</th>
            </tr>
            </tfoot>

            <tbody>
            <c:forEach items="${table}" var="row">
                <tr>
                    <td>${row[2].category}</td>
                    <td>${row[1].testname}</td>
                    <td>${row[0].datestart}</td>
                    <td>${row[0].datefinish}</td>
                    <td style="text-align: center">${row[0].quantityQuestion}</td>
                    <td style="text-align: center">${row[0].correctQuestion}</td>
                    <td style="text-align: center">${row[0].quantityQuestion-row[0].correctQuestion}</td>

                    <td align="center">
                                        <span class="tooltip-area">
                                            <a href="javascript:getUserResult(${row[0].id})"
                                               class="label btn-info"><i
                                                    class="fa fa-pencil"> Просмотреть</i></a></span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</header>
<!-- END Site header -->
<main>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Тест подробно</h4>
                </div>
                <div class="modal-body">
                    <ul id="ourTest" class="list-group" style="text-align: center; margin-right: 25px">
                    </ul>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Закрыть</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="myModalEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <%--<div class="modal-header">--%>
                <%--<h4 class="modal-title">Редактирование профиля</h4>--%>
                <%--</div>--%>
                <div class="modal-body">
                    <form id="edit_user" method="post">

                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="ti-user"></i></span>
                                <input type="text" value="${user.name}" class="form-control" name="name" id="name"
                                       minlength="4" placeholder="Ваше имя">

                            </div>
                        </div>

                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="ti-user"></i></span>
                                <input type="text" value="${user.surname}" class="form-control"
                                       minlength="4" name="surname" id="surname"
                                       placeholder="Ваша фамилия">

                            </div>
                        </div>

                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="ti-mobile"></i></span>
                                <input type="tel" value="${user.phone}" class="form-control" name="phone" id="phone"
                                       placeholder="Ваш телефон" required>
                            </div>

                        </div>

                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="ti-email"></i></span>
                                <input type="email" value="${user.email}" class="form-control" name="email" id="email"
                                       placeholder="Ваш e-mail адрес" required>
                            </div>
                        </div>

                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="ti-unlock"></i></span>
                                <input class="form-control" value="${user.password}" name="password" id="password"
                                       placeholder="Пароль мин. 6 символов" size="30"  minlength="6" type="password" required/>
                            </div>
                        </div>

                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="ti-unlock"></i></span>
                                <input class="form-control" value="${user.password}" name="confirmpassword"
                                       id="confirmpassword"
                                       placeholder="Подтв. мин. 6 символов" size="30" minlength="6" type="password" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-primary" onclick="validateform()">Записать</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Отмена</button>
                        </div>
                    </form>
                </div>

                <%--<div class="modal-footer">--%>
                <%--<button class="btn btn-primary btn-block" type="submit">Сохранить</button>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
</main>

<!-- END Main container -->
<!-- Back to top button -->

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/datatables.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/assets/js/smoke.min.js"></script>
<!-- language -->
<script src="${pageContext.request.contextPath}/resources/assets/js/ru.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-confirm.js"></script>
<script type="text/javascript"
        src="https://cdn.datatables.net/buttons/1.2.1/js/dataTables.buttons.min.js"></script>

<script type="text/javascript"
        src="https://cdn.datatables.net/buttons/1.2.1/js/buttons.flash.min.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>

<script type="text/javascript"
        src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
<script type="text/javascript"
        src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
<script type="text/javascript"
        src="https://cdn.datatables.net/buttons/1.2.1/js/buttons.html5.min.js"></script>
<script type="text/javascript"
        src="https://cdn.datatables.net/buttons/1.2.1/js/buttons.print.min.js"></script>
<script type="text/javascript">
    function openModal() {
        $("#name").val($("#etalonName").val());
        $("#surname").val($("#etalonSurname").val());
        $("#phone").val($("#etalonPhone").val());
        $("#email").val($("#etalonEmail").val());
        $("#password").val($("#etalonPassword").val());
        $("#confirmpassword").val($("#etalonPassword").val());
        $("#myModalEdit").modal('show');
    }

    function validateform() {
        if ($('#edit_user').smkValidate()) {
           if ($.smkEqualPass('#password', '#confirmpassword')){
               $.confirm({
                   template: 'primary',
                   templateOk: 'primary',
                   message: 'Вы уверены что хотите изменить данные пользователя?',
                   onOk: function () {
                       $("#myModalEdit").modal('hide');
                       $.ajax({
                           type: "POST",
                           url: "${pageContext.request.contextPath}/edituserprofile",
                           data: {
                               name: $('#name').val(),
                               surname: $('#surname').val(),
                               phone: $('#phone').val(),
                               email:$('#email').val(),
                               password:$('#password').val()
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
                           //update all elements
                           pardesc = JSON.parse(element);
                           $('#etalonName').val(pardesc.name);
                           $('#etalonSurname').val(pardesc.surname);
                           $('#etalonPhone').val(pardesc.phone);
                           $('#etalonEmail').val(pardesc.email);
                           $('#etalonPassword').val(pardesc.password);
                           document.getElementById('spanName').textContent=pardesc.name;
                           document.getElementById('spanSurname').textContent=pardesc.surname;
                           document.getElementById('spanPhone').textContent=pardesc.phone;
                           document.getElementById('spanEmail').textContent=pardesc.email;
                           $.confirm({
                               title: 'Информация',
                               titleIcon: 'glyphicon glyphicon-info-sign',
                               template: 'info',
                               templateOk: 'info',
                               message: 'Профиль обновлен',
                               labelOk: 'ОК',
                               buttonCancel: false,
                               onOk: function () {
                                                                 }
                           });
                       });
                   }
               });
           }
    }}
    function getUserResult(testid) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/getuserresult",
            data: {
                testid: testid
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
            $("#ourTest").html(element);

            $(function () {
                $("#myModal").modal('show');
            });
        });
    }

    $(document).ready(function () {
        $('#tests tfoot th').each(function () {
            var title = $(this).text();
            if (title == 'Дата начала' || title == 'Дата окончания') {
                $(this).html('<input type="date"/>');
            } else if (title == 'Подробно') {
                $(this).html('<label/>')
            }

            else if (isNaN(title)) {
                $(this).html('<input type="text" placeholder="' + title + '" />');
            }

            else $(this).html('<label/>');
        });

        var default_options = {
            "scrollX": true,

            "scrollY": 407,

            "sScrollXInner": "100%",

            "bJQueryUI": true,

            "sPaginationType": "simple_numbers",

            "oLanguage": {

                "sLengthMenu": "Отображено _MENU_ записей на страницу",

                "sSearch": "Поиск:",

                "sZeroRecords": "Ничего не найдено - извините",

                "sInfo": "Показано с _START_ по _END_ из _TOTAL_ записей",

                "sInfoEmpty": "Показано с 0 по 0 из 0 записей",

                "sInfoFiltered": "(отфильтровано из _MAX_ записей)",

                "oPaginate": {

                    "sFirst": "Первая",

                    "sLast": "Посл.",

                    "sNext": "След.",

                    "sPrevious": "Пред."

                }

            },

            "bProcessing": true,
            dom: 'Bfrtip',
            buttons: [
                'copy', 'csv', 'excel'
            ],
            lengthChange: false,
            "initComplete": function () {
                this.api().columns().every(function () {
                    var that = this;

                    $('input', this.footer()).on('keyup change', function () {
                        if (that.search() !== this.value) {
                            that
                                    .search(this.value)
                                    .draw();
                        }
                    });
                });
            },
            "columnDefs": [
                {"visible": false, "targets": 0}
            ],
            "order": [[0, 'asc']],
            "displayLength": 10,
            "drawCallback": function (settings) {
                var api = this.api();
                var rows = api.rows({page: 'current'}).nodes();
                var last = null;

                api.column(0, {page: 'current'}).data().each(function (group, i) {
                    if (last !== group) {
                        $(rows).eq(i).before(
                                '<tr class="group" style="background-color: dodgerblue; font-weight: bold;"><td colspan="7">' + group + '</td></tr>'
                        );

                        last = group;
                    }
                });
            }


        };

        $('#tests').dataTable(default_options);
//        $('table[data-provide="data-table"]').dataTable();

        $('#tests tbody').on('click', 'tr.group', function () {
            var currentOrder = table.order()[0];
            if (currentOrder[0] === 0 && currentOrder[1] === 'asc') {
                table.order([0, 'desc']).draw();
            }
            else {
                table.order([0, 'asc']).draw();
            }
        });


    });


</script>


<%@ include file="../pages/template/templatefoot.jsp" %>
</body>
</html>




