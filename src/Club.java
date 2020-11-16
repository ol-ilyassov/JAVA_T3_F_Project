public class Club extends eve{
    protected int club_id;

    public Club(String name, String description, int student_id, int club_id) {
        super(name, description, student_id);
        this.club_id = club_id;
    }

    public Club(String name, String description, int student_id) {
        super(name, description, student_id);
    }

    public int getClub_id() {
        return club_id;
    }

    public void setClub_id(int club_id) {
        this.club_id = club_id;
    }

}