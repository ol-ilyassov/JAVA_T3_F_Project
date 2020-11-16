public class Events extends eve {

    protected int event_id;

    public Events(String name, String description, int author_id, int event_id) {
        super(name, description, author_id);
        this.event_id = event_id;
    }

    public Events(String name, String description, int author_id) {
        super(name, description, author_id);
    }

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }
}
