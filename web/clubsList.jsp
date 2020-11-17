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
        request.setAttribute("userId",userId);

    }
    }
    }
    int number = Integer.parseInt(userId);
    %>
    <sql:query var="result2" dataSource="jdbc/db">
        SELECT * from students where student_id = <%=number%>
    </sql:query>
    <sql:query var="clubstudent" dataSource="jdbc/db">
        SELECT student_id, CONCAT(fname, " ", lname) fullName, club_id, name, role FROM clubstudent JOIN students USING (student_id) JOIN clubs USING (club_id) WHERE student_id = ${userId}
    </sql:query>
    <c:forEach items="${result2.rows}" var="row2">
        <a class="create" href="clubAdd.jsp?action=add&author=${row2.student_id}">Create Club</a><br>

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
            <c:set var="flag" value="1" />

            <c:forEach items= "${clubstudent.rows}" var="temp">
                <c:if test = "${temp.club_id==clubs.club_id}">
                    <c:set var="flag" value="0" />

                </c:if>
            </c:forEach>
            <c:if test = "${flag==1}">
                <form action="ServletJoin" method="post">
                    <tr>
                        <td>${clubs.club_id}</td>
                        <td>${clubs.name}</td>
                        <td><input type="submit" name="submitBtn" value="JOIN"></td>
                        <input type="text" name="student_id" value="${row2.student_id}"hidden>
                        <input type="text" name="club_id" value="${clubs.club_id}"hidden>
                    </tr>
                </form>
            </c:if>
        </c:forEach>
        </tbody>
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
