import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/ServletClubs")
public class ServletClubs extends HttpServlet {
    ClubsJDBC db = new ClubsJDBC();
    /*Answer to post method*/
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        int author = Integer.parseInt(req.getParameter("author"));
        String responseText = "";
        Club club = new Club(name,description,author);
        if (action.equals("add")) {
            int number = ClubsJDBC.getInstance().checkForID(club);
            if(number == 0) {
                club=ClubsJDBC.getInstance().create(club);
                System.out.println(club.club_id);
                ClubsJDBC.getInstance().insertAsCreator(club);

                responseText = "SUCCESS: Club was created";
            }else {
                responseText = "ERROR: Club with the same ID is exist";
            }
        } else if (action.equals("update")){
            int club_id = Integer.parseInt(req.getParameter("club_id"));
            ClubsJDBC.getInstance().update(club_id,name,description,author);
            responseText = "SUCCESS: Club details was updated!";
        }
        req.setAttribute("response",responseText);
        Cookie[] cookies = req.getCookies();
        String cookieName = "role";
        String role="";
        for ( int i=0; i<cookies.length; i++) {
            Cookie cookie = cookies[i];
            if (cookieName.equals(cookie.getName()))
                role=(cookie.getValue());
        }
        if (role.equals("Javaclass.Student")){
            req.getRequestDispatcher("index.jsp").forward(req,resp);
        } else {
            req.getRequestDispatcher("index.jsp").forward(req,resp);        }


    }
    /*Answer to delete method*/
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int club_id = req.getParameter("club_id") != null ? Integer.parseInt(req.getParameter("club_id")) : 0;
        ClubsJDBC.getInstance().delete(club_id);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try
        {
            Connection connection = db.getConnection();
            if(connection != null) {
                ArrayList<Club> clubsList = db.readEvents(connection);
                connection.close();
                HttpSession session = req.getSession(true);
                session.setAttribute("clubsList", clubsList);
            }
        }
        catch (SQLException exception)
        {
            exception.printStackTrace();
        }
        req.getRequestDispatcher("clubsList.jsp").forward(req, resp);
    }
}
