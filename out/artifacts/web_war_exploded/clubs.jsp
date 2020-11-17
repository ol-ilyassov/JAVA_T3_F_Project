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
        <a class="create" href="clubAdd.jsp?action=add&author=${row2.id}">Create Club</a><br>

        <sql:query var="result" dataSource="jdbc/db">
        SELECT * FROM clubs
    </sql:query>
    <p>Clubs List</p><br>
    <table>
        <tr>
            <th>Name: </th>
            <th>Author: </th>
            <th colspan="3">Actions: </th>
        </tr>
        <c:forEach items="${result.rows}" var="row">
            <tr id="tr${row.club_id}">
                <td>${row.name}</td>
                <td>${row.author}</td>
                <td id="td_update ${row.club_id}"><a class="btnLink" href="clubAdd.jsp?action=update&club_id=${row.club_id}&author=${row2.id}" onmouseover="updrecolor(${row.club_id})" onmouseleave="upddecolor(${row.club_id})">UPDATE</a></td>
                <td id="td_delete ${row.club_id}"><button class="btn" onclick="deleteBook(${row.club_id})" onmouseover="delrecolor(${row.club_id})" onmouseleave="deldecolor(${row.club_id})">DELETE</button></td>
                <td id="td_description ${row.club_id}"><button class="bts" onclick="reveal(${row.club_id})" onmouseover="descrecolor(${row.club_id})" onmouseleave="descdecolor(${row.club_id})">DESCRIPTION</button></td>
            </tr>
            <tr>
                <td colspan="6" id="allshow ${row.club_id}" style="display: none;"><p>Description:<br>${row.description}</p></td>
            </tr>
        </c:forEach>
    </table>
    </c:forEach>
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
