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


    <p>News List</p><br>
    <input id="myInput" type="text" placeholder="Search.."><br>
    <table>
        <tr>
            <th>ID: </th>
            <th>Name: </th>
            <th>Action: </th>
        </tr>
        <tbody id="myTable">
        <c:forEach var="news" items="${newsList}">
            <tr>
                <td>${news.news_id}</td>
                <td>${news.name}</td>
                <td id="td_description ${news.news_id}"><button class="bts" onclick="reveal(${news.news_id})" onmouseover="descrecolor(${news.news_id})" onmouseleave="descdecolor(${news.news_id})">DESCRIPTION</button></td>
            </tr>
            <tr>
                <td colspan="3" id="allshow ${news.news_id}" style="display: none;"><p>Description:<br>${news.description}</p></td>
            </tr>
        </c:forEach>
        </tbody>
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
