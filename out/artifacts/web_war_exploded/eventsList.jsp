<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%-- Header --%>
<jsp:include page="header.jsp"/>

<%-- Content --%>
<div class="block1">
    <%
        String role = " ";
        String userId = " ";
        Cookie[] cookies = null;
        cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie: cookies) {
                if (cookie.getName().equals("role")) {
                    role = cookie.getValue();
                }
                if (cookie.getName().equals("userId")) {
                    userId = cookie.getValue();
                }
            }
        }
        int number = Integer.parseInt(userId);
    %>
    <sql:query var="result2" dataSource="jdbc/db">
        SELECT * from students where student_id = <%=number%>
    </sql:query>


    <p>Events List</p><br>
    <input id="myInput1" type="text" placeholder="Search.."><br>
    <table>
        <tr>
            <th>ID: </th>
            <th>Name: </th>
            <th>Action: </th>
        </tr>
        <tbody id="myTable1">
        <c:forEach var="events" items="${eventsList}">
            <tr id="tr${events.event_id}">
                <td>${events.event_id}</td>
                <td>${events.name}</td>
                <td id="td_description ${events.event_id}"><button class="bts" onclick="reveal(${events.event_id})" onmouseover="descrecolor(${events.event_id})" onmouseleave="descdecolor(${events.event_id})">DESCRIPTION</button></td>
            </tr>
            <tr>
                <td colspan="3" id="allshow ${events.event_id}" style="display: none;"><p>Description:<br>${events.description}</p></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    function deleteBook(taskId){
        $.ajax({
                url:"ServletEvents?event_id="+taskId,
                type: "DELETE",
            }
        )
            .done (function(data, textStatus, jqXHR) {
                $('#response').text("SUCCESS: Event was deleted.");
                $('#tr'+taskId).remove();
            })
            .fail (function(jqXHR, textStatus, errorThrown) {
                alert("Error "+textStatus+": "+errorThrown);
            })
    }

    $(document).ready(function(){
        $("#myInput1").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable1 tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>
