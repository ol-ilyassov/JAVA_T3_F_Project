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

    <a class="btnLink" href="clubAdd.jsp?action=add">Create Club</a><br>

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
                <td><a class="btnLink" href="clubAdd.jsp?action=update&club_id=${row.club_id}">UPDATE</a></td>
                <td><button class="btn" onclick="deleteBook(${row.club_id})">DELETE</button></td>
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
