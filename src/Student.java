public class Student extends User {

    protected String groups;
    protected String major;
    protected int year;


    protected Student(String[] studentFields) {
        super(Integer.parseInt(studentFields[0]), studentFields[1], studentFields[2], studentFields[3], studentFields[4], studentFields[5]);
        this.groups = studentFields[6];
        this.major = studentFields[7];
        this.year =  Integer.parseInt(studentFields[8]);

    }

    public String getGroups() {
        return groups;
    }

    public void setGroups(String groups) {
        this.groups = groups;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
}
