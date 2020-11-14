public class Events {
    private int event_id;
    private String name;
    private String description;
    private String author;

    public Events(int event_id,String name,String description,String author){
        setEvent_id(event_id);
        setName(name);
        setDescription(description);
        setAuthor(author);
    }

    public int getEvent_id() {
        return event_id;
    }
    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
}
