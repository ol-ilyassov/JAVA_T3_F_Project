import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;

public class EventsJDBC {
    private static EventsJDBC instance = new EventsJDBC();

    public static EventsJDBC getInstance() {
        return instance;
    }

    public EventsJDBC() {}

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

    public Events create(Events event ) {
        String sql = "INSERT INTO events ( name,description,author) VALUES ( ?,?,?)";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, event.getName());
            ps.setString(2, event.getDescription());
            ps.setInt(3, event.getAuthor_id());
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

    public void update(int event_id, String name, String description, int author){
        System.out.println("Update:"+event_id);
        String sql = "UPDATE events SET name=?,description=?,author=? WHERE event_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, author);
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

    public ArrayList<Events> readEvents(Connection connection)
    {
        ArrayList<Events> eventList = new ArrayList<>();
        try
        {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM events");
            ResultSetMetaData metaData = resultSet.getMetaData();
            int numberOfColumns = metaData.getColumnCount();
            Events events;
            while (resultSet.next())
            {
                String[] eventsFields = new String[numberOfColumns];
                for(int a=1; a<=numberOfColumns; a++)
                {
                    eventsFields[a-1] = resultSet.getObject(a).toString();
                }
                events = new Events(eventsFields);
                eventList.add(events);
            }
            resultSet.close();
            connection.close();
            statement.close();
        }
        catch (SQLException sqlException)
        {
            sqlException.printStackTrace();
        }
        return eventList;
    }
}
