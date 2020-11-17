public class Eve {

    protected String name;
    protected String description;
    protected int author_id;

    public Eve(String name, String description, int author_id) {
        this.name = name;
        this.description = description;
        this.author_id = author_id;
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

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }
}
