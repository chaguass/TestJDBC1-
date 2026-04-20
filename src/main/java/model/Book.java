package model;

public class Book {
    private Integer bookId;
    private String title;
    private String author;
    private String publisher;
    private Integer publishYear;
    private Integer stock;
    private Integer totalCopies;

    // 无参构造（JavaBean必须）
    public Book() {}

    // get/set 方法
    public Integer getBookId() {return bookId;}
    public void setBookId(Integer bookId) {this.bookId = bookId;}
    public String getTitle() {return title;}
    public void setTitle(String title) {this.title = title;}
    public String getAuthor() {return author;}
    public void setAuthor(String author) {this.author = author;}
    public String getPublisher() {return publisher;}
    public void setPublisher(String publisher) {this.publisher = publisher;}
    public Integer getPublishYear() {return publishYear;}
    public void setPublishYear(Integer publishYear) {this.publishYear = publishYear;}
    public Integer getStock() {return stock;}
    public void setStock(Integer stock) {this.stock = stock;}
    public Integer getTotalCopies() {return totalCopies;}
    public void setTotalCopies(Integer totalCopies) {this.totalCopies = totalCopies;}
}