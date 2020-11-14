import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ServletClubs")
public class ServletClubs extends HttpServlet {
    /*Answer to post method*/
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        int club_id = Integer.parseInt(req.getParameter("club_id"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String author = req.getParameter("author");
        String responseText = "";
        Clubs club = new Clubs(club_id,name,description,author);
        if (action.equals("add")) {
            int number = ClubsJDBC.getInstance().checkForID(club);
            if(number == 0) {
                ClubsJDBC.getInstance().create(club);
                responseText = "SUCCESS: Club was created";
            }else {
                responseText = "ERROR: Club with the same ID is exist";
            }
        } else if (action.equals("update")){
            ClubsJDBC.getInstance().update(club_id,name,description,author);
            responseText = "SUCCESS: Club details was updated!";
        }
        req.setAttribute("response",responseText);
        req.getRequestDispatcher("clubs.jsp").forward(req,resp);


    }
    /*Answer to delete method*/
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int club_id = req.getParameter("club_id") != null ? Integer.parseInt(req.getParameter("club_id")) : 0;
        ClubsJDBC.getInstance().delete(club_id);

    }
}
