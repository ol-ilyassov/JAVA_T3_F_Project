import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/ServletEvents")
public class ServletEvents extends HttpServlet {
    EventsJDBC db = new EventsJDBC();
    /*Answer to post method*/
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        int author = Integer.parseInt(req.getParameter("author"));
        String responseText = "";
        Events event = new Events(name,description,author);
        if (action.equals("add")) {
            int number = EventsJDBC.getInstance().checkForID(event);
            if(number == 0) {
                EventsJDBC.getInstance().create(event);
                responseText = "SUCCESS: Events was created";
            }else {
                responseText = "ERROR: Events with the same ID is exist";
            }
        } else if (action.equals("update")){
            int event_id = Integer.parseInt(req.getParameter("event_id"));
            EventsJDBC.getInstance().update(event_id,name,description,author);
            responseText = "SUCCESS: Events details was updated!";
        }
        req.setAttribute("response",responseText);
        req.getRequestDispatcher("events.jsp").forward(req,resp);


    }
    /*Answer to delete method*/
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int event_id = req.getParameter("event_id") != null ? Integer.parseInt(req.getParameter("event_id")) : 0;
        EventsJDBC.getInstance().delete(event_id);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try
        {
            Connection connection = db.getConnection();
            if(connection != null) {
                ArrayList<Events> eventsList = db.readEvents(connection);
                connection.close();
                HttpSession session = req.getSession(true);
                session.setAttribute("eventsList", eventsList);
            }
        }
        catch (SQLException exception)
        {
            exception.printStackTrace();
        }
        req.getRequestDispatcher("eventsList.jsp").forward(req, resp);
    }
}
