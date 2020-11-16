import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClubsJDBC {
    private static ClubsJDBC instance = new ClubsJDBC();

    public static ClubsJDBC getInstance() {
        return instance;
    }

    private ClubsJDBC() {}

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

    public Club create(Club club ) {
        String sql = "INSERT INTO clubs ( club_id,name,description,author) VALUES ( ?,?,?,?)";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, club.getClub_id());
            ps.setString(2, club.getName());
            ps.setString(3, club.getDescription());
            ps.setInt(4, club.getAuthor_id());
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return club;
    }

    public void delete(int club_id) {
        System.out.println("Delete:"+club_id);
        String sql = "DELETE FROM clubs WHERE club_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, club_id);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(int club_id, String name, String description, int author){
        System.out.println("Update:"+club_id);
        String sql = "UPDATE clubs SET name=?,description=?,author=? WHERE club_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, author);
            ps.setInt(4,club_id);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int checkForID(Club club) {
        int counter = 0;
        String sql = "SELECT name FROM clubs WHERE club_id = ?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, club.getClub_id());
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
