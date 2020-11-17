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
        SELECT * FROM clubstudent WHERE student_id = ${user.id}
    </sql:query>
    <p>List of clubs:</p><br>
    <table>
        <tr>
            <th>Student id: </th>
            <th>Club id: </th>
            <th>Role: </th>
            <th colspan="2">Actions: </th>
        </tr>
        <c:forEach items="${result.rows}" var="row">
            <tr id="tr${row.id}">
                <td>${row.student_id}</td>
                <td>${row.club_id}</td>
                <td>${row.role}</td>
                <td id="td_update ${row.id}"><a class="btnLink" href="eventsAdd.jsp?action=update&event_id=${row.id}" onmouseover="updrecolor(${row.id})" onmouseleave="upddecolor(${row.id})">Add event</a></td>
                <td id="td_delete ${row.id}"><a class="btnLink" href="newsAdd.jsp?action=update&event_id=${row.id}" onmouseover="delrecolor(${row.id})" onmouseleave="deldecolor(${row.id})">Add news</a></td>
            </tr>
        </c:forEach>
    </table>

</div>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>