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
    <c:forEach items="${result2.rows}" var="row2">
        <a class="create" href="clubAdd.jsp?action=add&author=${row2.student_id}">Create Club</a><br>
    </c:forEach>

    <p>Clubs List</p><br>
    <input id="myInput2" type="text" placeholder="Search.."><br>
    <table>
        <tr>
            <th>ID: </th>
            <th>Name: </th>
            <th colspan="2">Actions: </th>
        </tr>
        <tbody id="myTable2">
        <c:forEach items="${clubsList}" var="clubs">
            <tr>
                <td>${clubs.club_id}</td>
                <td>${clubs.name}</td>
                <td><a class="btnLink" href="clubAdd.jsp?&club_id=${row.club_id}&role=participant">JOIN</a></td>
            </tr>
        </c:forEach>
        </tbody>
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

    $(document).ready(function(){
        $("#myInput2").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable2 tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>
