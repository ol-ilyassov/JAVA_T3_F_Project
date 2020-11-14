import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EventsJDBC {
    private static EventsJDBC instance = new EventsJDBC();

    public static EventsJDBC getInstance() {
        return instance;
    }

    private EventsJDBC() {}

    private Connection getConnection()
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

    public Events create(Events event ) {
        String sql = "INSERT INTO events ( event_id,name,description,author) VALUES ( ?,?,?,?)";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, event.getEvent_id());
            ps.setString(2, event.getName());
            ps.setString(3, event.getDescription());
            ps.setString(4, event.getAuthor());
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return event;
    }

    public void delete(int event_id) {
        System.out.println("Delete:"+event_id);
        String sql = "DELETE FROM events WHERE event_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, event_id);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(int event_id,String name,String description,String author){
        System.out.println("Update:"+event_id);
        String sql = "UPDATE events SET name=?,description=?,author=? WHERE event_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, author);
            ps.setInt(4,event_id);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int checkForID(Events event) {
        int counter = 0;
        String sql = "SELECT name FROM evets WHERE event_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, event.getEvent_id());
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
}
