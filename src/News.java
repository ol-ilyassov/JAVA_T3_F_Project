public class News extends Eve {

    protected int news_id;

    protected News(String[] newsFields) {
        super(newsFields[1], newsFields[2], Integer.parseInt(newsFields[3]));
        this.news_id = Integer.parseInt(newsFields[0]);
    }

    public News(String name, String description, int author_id, int news_id) {
        super(name, description, author_id);
        this.news_id = news_id;
    }

    public News(String name, String description, int author_id) {
        super(name, description, author_id);
    }

    public int getNews_id() {
        return news_id;
    }

    public void setNews_id(int news_id) {
        this.news_id = news_id;
    }
}
