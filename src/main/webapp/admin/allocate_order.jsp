<%--
  Created by IntelliJ IDEA.
  User: ME495
  Date: 2018/6/13
  Time: 21:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>分配订单</title>
</head>
<body>
<%@include file="navbar.jspf"%>
<div class="container">
    <div class="text-center">
        <ul id="pagination" class="pagination pagination4"></ul>
    </div>
    <table class="table table-striped table-condensed">
        <thead>
        <tr>
            <th>订单号</th>
            <th>下单人</th>
            <th>地址</th>
            <th>下单时间</th>
            <th>金额</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="info" class="alert alert-warning hidden">
        此页没有为分配的订单！
    </div>
</div>
</body>
<script src="../js/url_utils.js"></script>
<script src="../js/jqPaginator.js"></script>
<script type="application/javascript">
    var element;
    function show_data(data) {
        $("tbody").empty();
        $("#info").attr("class", "alert alert-warning hidden");
        $.each(data, function (i, value) {
            var $e = $("<tr></tr>");
            $e.append("<td>" + value.orderId + "</td>");
            $e.append("<td>" + value.userName + "</td>");
            $e.append("<td>" + value.address + "</td>");
            $e.append("<td>" + value.orderTime + "</td>");
            $e.append("<td>" + value.money + "</td>");
            $e.append("<td><span class='allocate btn btn-primary' title='"+ value.orderId +"'>分配订单</span></td>");
            $("tbody").append($e);
        });
        $(".allocate").click(function () {
            var order_id = $(this).attr("title");
            element = $(this);
            $.post("./allocate_order.do", {"order_id": order_id}, function (data, status) {
                if (status == "success") {
                    console.log(data + order_id);
                    if (data.status == "success") {
                        element.parent().html("<span class='btn btn-default' disabled='disabled'>分配成功</span>");
                    } else {
                        alert("分配失败！");
                    }
                }
            });
            $(this).html("已分配");
        });
    }

    function query(json) {
        $.post("./order_query.do", json, function (data, status) {
            console.log(data);
            if (status == "success") {
                if (data.status == "fail") {
                    alert("查询失败！");
                    location.href = "./query_order.jsp";
                } else if (data.message.length > 0) {
                    show_data(data.message);
                } else {
                    $("tbody").empty();
                    $("#info").attr("class", "alert alert-warning");
                }
            }
        });
    }

    $(document).ready(function () {
        var index = 0;
        var size = 20;
        var json = JSON.parse("{}");
        json["status0"] = "true";
        json["status1"] = "false";
        json["status2"] = "false";
        json["index"] = index;
        json["size"] = size;
        // query(json);

        $("#pagination").jqPaginator({
            totalPages: 100,
            currentPage: 1,

            prev: '<li class="prev"><a href="javascript:void(0);">上一页</a></li>',
            next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
            page: '<li class="page"><a href="javascript:void(0);">{{page}}</a></li>',
            onPageChange: function (num) {
                index = (num-1) * size;
                json["index"] = index;
                query(json);
            }
        });
    });
</script>
</html>
