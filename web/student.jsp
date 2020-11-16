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
    <p>Student List</p><br>
    <input id="myInput" type="text" placeholder="Search.."><br>
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
        <tbody id="myTable">
        <c:forEach var="student" items="${studentList}">
            <tr>
                <td>${student.id}</td>
                <td>${student.fname}</td>
                <td>${student.lname}</td>
                <td>${student.email}</td>
                <td>${student.groups}</td>
                <td>${student.major}</td>
                <td>${student.year}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script>
    $(document).ready(function(){
        $("#myInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>


<%-- Footer --%>
<jsp:include page="footer.jsp"/>
