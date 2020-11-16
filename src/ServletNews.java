import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ServletNews")
public class ServletNews extends HttpServlet {
    /*Answer to post method*/
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        int author = Integer.parseInt(req.getParameter("author"));
        String responseText = "";
        News news = new News(name,description,author);
        if (action.equals("add")) {
            int number = NewsJDBC.getInstance().checkForID(news);
            if(number == 0) {
                NewsJDBC.getInstance().create(news);
                responseText = "SUCCESS: News was created";
            }else {
                responseText = "ERROR: News with the same ID is exist";
            }
        } else if (action.equals("update")){
            int news_id = Integer.parseInt(req.getParameter("news_id"));
            NewsJDBC.getInstance().update(news_id,name,description,author);
            responseText = "SUCCESS: News details was updated!";
        }
        req.setAttribute("response",responseText);
        req.getRequestDispatcher("news.jsp").forward(req,resp);

    }
    /*Answer to delete method*/
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int news_id = req.getParameter("news_id") != null ? Integer.parseInt(req.getParameter("news_id")) : 0;
        NewsJDBC.getInstance().delete(news_id);

    }
}
