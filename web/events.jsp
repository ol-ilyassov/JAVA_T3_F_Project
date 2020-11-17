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
        SELECT * from admins where id = <%=number%>
    </sql:query>
    <c:forEach items="${result2.rows}" var="row2">
        <a class="create" href="eventsAdd.jsp?action=add&author=${row2.id}">Create Event</a><br>

        <sql:query var="result" dataSource="jdbc/db">
        SELECT * FROM events
    </sql:query>
    <p>Events List</p><br>
    <table>
        <tr>
            <th>Name: </th>
            <th>Author: </th>
            <th colspan="3">Actions: </th>
        </tr>
        <c:forEach items="${result.rows}" var="row">
            <tr id="tr${row.event_id}">
                <td>${row.name}</td>
                <td>${row.author}</td>
                <td id="td_update ${row.event_id}"><a class="btnLink" href="eventsAdd.jsp?action=update&event_id=${row.event_id}&author=${row2.id}" onmouseover="updrecolor(${row.event_id})" onmouseleave="upddecolor(${row.event_id})">UPDATE</a></td>
                <td id="td_delete ${row.event_id}"><button class="btn" onclick="deleteBook(${row.event_id})" onmouseover="delrecolor(${row.event_id})" onmouseleave="deldecolor(${row.event_id})">DELETE</button></td>
                <td id="td_description ${row.event_id}"><button class="bts" onclick="reveal(${row.event_id})" onmouseover="descrecolor(${row.event_id})" onmouseleave="descdecolor(${row.event_id})">DESCRIPTION</button></td>
            </tr>
            <tr>
                <td colspan="6" id="allshow ${row.event_id}" style="display: none;"><p>Description:<br>${row.description}</p></td>
            </tr>
        </c:forEach>
    </table>
    </c:forEach>
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
</script>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>
