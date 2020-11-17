import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ServletJoin")
public class ServletJoin extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int student_id = Integer.parseInt(request.getParameter("student_id"));
        int club_id = Integer.parseInt(request.getParameter("club_id"));
        String responseText = "";
        StudentJDBC.getInstance().join(student_id,club_id);
        request.setAttribute("response", responseText);
        request.getRequestDispatcher("clubsList.jsp").forward(request, response);
    }
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int student_id = req.getParameter("student_id") != null ? Integer.parseInt(req.getParameter("student_id")) : 0;
        int club_id = req.getParameter("club_id") != null ? Integer.parseInt(req.getParameter("club_id")) : 0;
        StudentJDBC.getInstance().leave(student_id,club_id);
    }
}
