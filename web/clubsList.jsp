<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%-- Header --%>
<jsp:include page="header.jsp"/>

<%-- Content --%>
<div class="block1">
    <p>Status of Last Action:</p><br>
    <p id="response">
        <c:choose>
            <c:when test = "${empty response}">
                - NO COMPLETED PROCESSES -
            </c:when>
            <c:when test = "${not empty response}">
                <c:out value="${response}"/>
            </c:when>
        </c:choose>
    </p><br>
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
    <c:forEach items="${result2.rows}" var="row2">
        <a class="btnLink" href="clubAdd.jsp?action=add&author=${row2.fname}">Create Club</a><br>
    </c:forEach>

    <sql:query var="result" dataSource="jdbc/db">
        SELECT * FROM clubs
    </sql:query>
    <p>Clubs List</p>
    <table>
        <tr>
            <th>Id: </th>
            <th>Name: </th>
            <th>Author: </th>
        </tr>
        <c:forEach items="${result.rows}" var="row">
            <tr id="tr${row.club_id}">
                <td>${row.club_id}</td>
                <td>${row.name}</td>
                <td>${row.author}</td>
                <td><a class="btnLink" href="clubAdd.jsp?&club_id=${row.club_id}&role=participant">JOIN</a></td>
            </tr>
        </c:forEach>
    </table>
</div>

<script type="text/javascript">
    function deleteBook(taskId){
        $.ajax({
                url:"ServletClubs?club_id="+taskId,
                type: "DELETE",
            }
        )
            .done (function(data, textStatus, jqXHR) {
                $('#response').text("SUCCESS: Club was deleted.");
                $('#tr'+taskId).remove();
            })
            .fail (function(jqXHR, textStatus, errorThrown) {
                alert("Error "+textStatus+": "+errorThrown);
            })
    }
</script>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>
