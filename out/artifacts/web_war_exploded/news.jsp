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
        SELECT * from admins where id = <%=number%>
    </sql:query>
    <c:forEach items="${result2.rows}" var="row2">
        <a class="create" href="newsAdd.jsp?action=add&author=${row2.id}">Create News</a><br>
    </c:forEach>

    <sql:query var="result" dataSource="jdbc/db">
        SELECT * FROM news
    </sql:query>
    <p>News List</p>
    <table>
        <tr>
            <th>Name: </th>
            <th>Author: </th>
            <th colspan="3">Actions: </th>
        </tr>
        <c:forEach items="${result.rows}" var="row">
            <tr id="tr${row.news_id}">
                <td>${row.name}</td>
                <td>${row.author}</td>
                <td id="td_update ${row.news_id}"><a class="btnLink" href="newsAdd.jsp?action=update&news_id=${row.news_id}" onmouseover="updrecolor(${row.news_id})" onmouseleave="upddecolor(${row.news_id})">UPDATE</a></td>
                <td id="td_delete ${row.news_id}"><button class="btn" onclick="deleteBook(${row.news_id})" onmouseover="delrecolor(${row.news_id})" onmouseleave="deldecolor(${row.news_id})">DELETE</button></td>
                <td id="td_description ${row.news_id}"><button class="bts" onclick="reveal(${row.news_id})" onmouseover="descrecolor(${row.news_id})" onmouseleave="descdecolor(${row.news_id})">DESCRIPTION</button></td>
            </tr>
            <tr>
                <td colspan="6" id="allshow ${row.news_id}" style="display: none;"><p>Description:<br>${row.description}</p></td>
            </tr>
        </c:forEach>
    </table>
</div>

<script type="text/javascript">
    function deleteBook(taskId){
        $.ajax({
                url:"ServletNews?news_id="+taskId,
                type: "DELETE",
            }
        )
            .done (function(data, textStatus, jqXHR) {
                $('#response').text("SUCCESS: News was deleted.");
                $('#tr'+taskId).remove();
            })
            .fail (function(jqXHR, textStatus, errorThrown) {
                alert("Error "+textStatus+": "+errorThrown);
            })
    }
</script>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>
