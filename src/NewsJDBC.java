import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;

public class NewsJDBC {
    private static NewsJDBC instance = new NewsJDBC();

    public static NewsJDBC getInstance() {
        return instance;
    }

    public NewsJDBC() {}

    public Connection getConnection()
    {
        Context initialContext;
        Connection connection = null;
        try
        {
            initialContext = new InitialContext();
            Context envCtx = (Context)initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/db");
            connection = ds.getConnection();
        }
        catch (NamingException | SQLException e)
        {
            e.printStackTrace();
        }
        return connection;
    }

    public News create(News news ) {
        String sql = "INSERT INTO news ( name,description,author) VALUES ( ?,?,?)";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, news.getName());
            ps.setString(2, news.getDescription());
            ps.setInt(3, news.getAuthor_id());
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return news;
    }

    public void delete(int news_id) {
        System.out.println("Delete:"+news_id);
        String sql = "DELETE FROM news WHERE news_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, news_id);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(int news_id,String name,String description,int author){
        System.out.println("Update:"+news_id);
        String sql = "UPDATE news SET name=?,description=?,author=? WHERE news_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, author);
            ps.setInt(4,news_id);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int checkForID(News news) {
        int counter = 0;
        String sql = "SELECT name FROM news WHERE news_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, news.getNews_id());
            ResultSet rs = ps.executeQuery();
            while ( rs.next() ) {
                counter++;
            }
            ps.close();
            rs.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counter;
    }

    public ArrayList<News> readNews(Connection connection)
    {
        ArrayList<News> newsList = new ArrayList<>();
        try
        {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM news");
            ResultSetMetaData metaData = resultSet.getMetaData();
            int numberOfColumns = metaData.getColumnCount();
            News news;
            while (resultSet.next())
            {
                String[] newsFields = new String[numberOfColumns];
                for(int a=1; a<=numberOfColumns; a++)
                {
                    newsFields[a-1] = resultSet.getObject(a).toString();
                }
                news = new News(newsFields);
                newsList.add(news);
            }
            resultSet.close();
            connection.close();
            statement.close();
        }
        catch (SQLException sqlException)
        {
            sqlException.printStackTrace();
        }
        return newsList;
    }
}
