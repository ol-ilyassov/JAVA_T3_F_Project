public class Club extends Eve{
    protected int club_id;

    public Club(String name, String description, int student_id, int club_id) {
        super(name, description, student_id);
        this.club_id = club_id;
    }

    protected Club(String[] clubsFields) {
        super(clubsFields[1], clubsFields[2], Integer.parseInt(clubsFields[3]));
        this.club_id = Integer.parseInt(clubsFields[0]);
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