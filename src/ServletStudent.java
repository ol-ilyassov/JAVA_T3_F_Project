import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/ServletStudent")
public class ServletStudent extends HttpServlet {
    StudentJDBC db = new StudentJDBC();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try
        {
            Connection connection = db.getConnection();
            if(connection != null) {
                ArrayList<Student> studentList = db.readStudent(connection);
                connection.close();
                req.setAttribute("studentList", studentList);
            }
        }
        catch (SQLException exception)
        {
            exception.printStackTrace();
        }
        req.getRequestDispatcher("student.jsp").forward(req, resp);
    }
}
