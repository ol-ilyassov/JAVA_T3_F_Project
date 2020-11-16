public class Events extends eve {

    protected int event_id;

    protected Events(String[] eventsFields) {
        super(eventsFields[1], eventsFields[2], Integer.parseInt(eventsFields[3]));
        this.event_id = Integer.parseInt(eventsFields[0]);
    }

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
