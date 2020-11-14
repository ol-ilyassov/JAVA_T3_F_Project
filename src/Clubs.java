public class Clubs {
      private int club_id;
      private String name;
      private String description;
      private String author;

      public Clubs(int club_id,String name,String description,String author){
          setClub_id(club_id);
          setName(name);
          setDescription(description);
          setAuthor(author);
      }

    public int getClub_id() {
        return club_id;
    }
    public void setClub_id(int club_id) {
        this.club_id = club_id;
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
