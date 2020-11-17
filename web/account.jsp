<%@ page import="java.sql.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="Javaclass.User" %>
<%@ page import="Javaclass.Student" %><%-- Header --%>
<jsp:include page="header.jsp"/>


<%-- Content --%>
<div class="block1">
    <table>
        <tr>
            <th>Id: </th>
            <th>First Name: </th>
            <th>Last Name: </th>
            <th>Email: </th>
            <th>Group: </th>
            <th>Major: </th>
            <th>Year: </th>
        </tr>
<%
    ArrayList<Student> account = (ArrayList<Student>) request.getSession(false).getAttribute("studentList");
    Cookie[] cookies = request.getCookies();
    String cookieName = "userId";
    int id=0;
    for ( int i=0; i<cookies.length; i++) {
        Cookie cookie = cookies[i];
        if (cookieName.equals(cookie.getName()))
            id=Integer.parseInt(cookie.getValue());
    }
    Student user;
    for (int i=0;i<account.size();i++){
        if (account.get(i).getId()==id){
            user=account.get(i);
            request.setAttribute("user",user);
        }
    }
%>
<c:set var="user" value="${user}"/>
        <tr>
            <td>${user.id}</td>
            <td>${user.fname}</td>
            <td>${user.lname}</td>
            <td>${user.email}</td>
            <td>${user.groups}</td>
            <td>${user.major}</td>
            <td>${user.year}</td>
        </tr>
    </table><br>
    <sql:query var="result" dataSource="jdbc/db">
        SELECT student_id, CONCAT(fname, " ", lname) fullName, club_id, name, role FROM clubstudent JOIN students USING (student_id) JOIN clubs USING (club_id) WHERE student_id = ${user.id}
    </sql:query>
    <p>List of my clubs:</p><br>
    <table>
        <tr>
            <th>Student: </th>
            <th>Club: </th>
            <th>Role: </th>
        </tr>
        <c:forEach items="${result.rows}" var="row">
            <tr id="tr${row.id}">
                <td>${row.fullName}</td>
                <td>${row.name}</td>
                <td>${row.role}</td>
                <c:set value="${row.role}" var="member"/>
                <c:if test="${member.equals('moderator') || member.equals('creator')}">
                <td id="td_update ${row.id}"><a class="btnLink" href="eventsAdd.jsp?action=add&author=${user.id}" onmouseover="updrecolor(${row.id})" onmouseleave="upddecolor(${row.id})">Add event</a></td>
                <td id="td_delete ${row.id}"><a class="btnLink" href="newsAdd.jsp?action=add&author=${user.id}" onmouseover="delrecolor(${row.id})" onmouseleave="deldecolor(${row.id})">Add news</a></td>
                </c:if>
            </tr>
        </c:forEach>
    </table><br>
    <sql:query var="result1" dataSource="jdbc/db">
        SELECT * FROM events WHERE author = ${user.id}
    </sql:query>
    <c:if test="${member.equals('moderator') || member.equals('creator')}">
    <p>List of my events:</p><br>
    <table>
        <tr>
            <th>Event id: </th>
            <th>Name: </th>
            <th>Description: </th>
            <th colspan="2">Actions: </th>
        </tr>
        <c:forEach items="${result1.rows}" var="row">
            <tr id="trevent${row.event_id}">
                <td>${row.event_id}</td>
                <td>${row.name}</td>
                <td>${row.description}</td>
                <td id="td_update ${row.event_id}"><a class="btnLink" href="eventsAdd.jsp?action=update&event_id=${row.event_id}&author=${user.id}" onmouseover="updrecolor(${row.event_id})" onmouseleave="upddecolor(${row.event_id})">UPDATE</a></td>
                <td id="td_delete ${row.event_id}"><button class="btn" onclick="deleteEvent(${row.event_id})" onmouseover="delrecolor(${row.event_id})" onmouseleave="deldecolor(${row.event_id})">DELETE</button></td>
            </tr>
        </c:forEach>
    </table><br>
    <sql:query var="result2" dataSource="jdbc/db">
        SELECT * FROM news WHERE author = ${user.id}
    </sql:query>
    <p>List of my news:</p><br>
    <table>
        <tr>
            <th>News id: </th>
            <th>Name: </th>
            <th>Description: </th>
            <th colspan="2">Actions: </th>
        </tr>
        <c:forEach items="${result2.rows}" var="row">
            <tr id="trnews${row.news_id}">
                <td>${row.news_id}</td>
                <td>${row.name}</td>
                <td>${row.description}</td>
                <td id="td_update ${row.news_id}"><a class="btnLink" href="newsAdd.jsp?action=update&news_id=${row.news_id}&author=${user.id}" onmouseover="updrecolor(${row.news_id})" onmouseleave="upddecolor(${row.news_id})">UPDATE</a></td>
                <td id="td_delete ${row.news_id}"><button class="btn" onclick="deleteNews(${row.news_id})" onmouseover="delrecolor(${row.news_id})" onmouseleave="deldecolor(${row.news_id})">DELETE</button></td>
            </tr>
        </c:forEach>
    </table>
    </c:if>
</div>

<script type="text/javascript">
    function deleteEvent(taskId){
        $.ajax({
                url:"ServletEvents?event_id="+taskId,
                type: "DELETE",
            }
        )
            .done (function(data, textStatus, jqXHR) {
                $('#trevent'+taskId).remove();
            })
            .fail (function(jqXHR, textStatus, errorThrown) {
                alert("Error "+textStatus+": "+errorThrown);
            })
    }

    function deleteNews(taskId){
        $.ajax({
                url:"ServletNews?news_id="+taskId,
                type: "DELETE",
            }
        )
            .done (function(data, textStatus, jqXHR) {
                $('#trnews'+taskId).remove();
            })
            .fail (function(jqXHR, textStatus, errorThrown) {
                alert("Error "+textStatus+": "+errorThrown);
            })
    }
</script>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>