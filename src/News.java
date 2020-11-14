public class News {
    private int news_id;
    private String name;
    private String description;
    private String author;

    public News(int news_id,String name,String description,String author){
        setNews_id(news_id);
        setName(name);
        setDescription(description);
        setAuthor(author);
    }

    public int getNews_id() {
        return news_id;
    }
    public void setNews_id(int news_id) {
        this.news_id = news_id;
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
