import Javaclass.Student;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;

public class StudentJDBC {

    private static StudentJDBC instance = new StudentJDBC();

    public static StudentJDBC getInstance() {
        return instance;
    }

    public StudentJDBC() {}

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

    public ArrayList<Student> readStudent(Connection connection)
    {
        ArrayList<Student> studentList = new ArrayList<>();
        try
        {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM students");
            ResultSetMetaData metaData = resultSet.getMetaData();
            int numberOfColumns = metaData.getColumnCount();
            Student student;
            while (resultSet.next())
            {
                String[] studentFields = new String[numberOfColumns];
                for(int a=1; a<=numberOfColumns; a++)
                {
                    studentFields[a-1] = resultSet.getObject(a).toString();
                }
                student = new Student(studentFields);
                studentList.add(student);
            }
            resultSet.close();
            connection.close();
            statement.close();
        }
        catch (SQLException sqlException)
        {
            sqlException.printStackTrace();
        }
        return studentList;
    }

    public void join(int student,int club){
    String sql = "INSERT INTO clubstudent(student_id,club_id,role) values(?,?,\"member\")";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, student);
            ps.setInt(2, club);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void leave(int student,int club){
        String sql = "DELETE FROM clubstudent WHERE student_id=? AND club_id=?";
        try {
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, student);
            ps.setInt(2,club);
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
