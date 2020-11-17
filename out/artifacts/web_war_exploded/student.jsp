<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%-- Header --%>
<jsp:include page="header.jsp"/>
<%-- Content --%>
<div class="block1">
    <p>Student List</p><br>

    <input type="number" id="id" class="search-key" placeholder="id" style="display: none">
    <input type="text" id="fname" class="search-key" placeholder="fname">
    <input type="text" id="lname" class="search-key" placeholder="lname">
    <input type="text" id="email" class="search-key" placeholder="email">
    <div id="selection">
        <select id="groups" class="search-key">
        <option value="">Group</option>
        <option value="1901">1901</option>
        <option value="1902">1902</option>
        <option value="1903">1903</option>
        <option value="1905">1905</option>
    </select>
    <select id="major" class="search-key">
        <option value="">Major</option>
        <option value="SE">SE</option>
        <option value="CS">CS</option>
        <option value="MT">MT</option>
    </select>
    <select id="year" class="search-key">
        <option value="">Year</option>
        <option value="2019">2019</option>
        <option value="2020">2020</option>
    </select>
    </div><br>

    <table id="filtering">
        <tr>
            <th>Id: </th>
            <th>First Name: </th>
            <th>Last Name: </th>
            <th>Email: </th>
            <th>Group: </th>
            <th>Major: </th>
            <th>Year: </th>
        </tr>
        <c:forEach var="student" items="${studentList}">
            <tr>
                <td data-input="id">${student.id}</td>
                <td data-input="fname">${student.fname}</td>
                <td data-input="lname">${student.lname}</td>
                <td data-input="email">${student.email}</td>
                <td data-input="groups">${student.groups}</td>
                <td data-input="major">${student.major}</td>
                <td data-input="year">${student.year}</td>
            </tr>
        </c:forEach>
    </table>
</div>
<script>
    var $filterableRows = $('#filtering').find('tr').not(':first'),
        $inputs = $('.search-key');

    $inputs.on('input', function() {

        $filterableRows.hide().filter(function() {
            return $(this).find('td').filter(function() {

                var tdText = $(this).text().toLowerCase(),
                    inputValue = $('#' + $(this).data('input')).val().toLowerCase();

                return tdText.indexOf(inputValue) !== -1;

            }).length === $(this).find('td').length;
        }).show();

    });
</script>


<%-- Footer --%>
<jsp:include page="footer.jsp"/>
