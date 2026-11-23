package com.tdc.nhom6.doanjava1.model;

public class Book {
    private Long id;
    private String title, author, category, publisher, description, coverType;
    private Integer publishYear, totalCopies=1, availableCopies=1;
    private byte[] coverImage;
    public Book() {}
    public Book(Long id,String title,String author,String category,String description,int totalCopies) {
        this.id=id;this.title=title;this.author=author;this.category=category;this.description=description;
        this.totalCopies=totalCopies;this.availableCopies=totalCopies;
    }
    public boolean isAvailable(){return availableCopies!=null&&availableCopies>0;}
    public boolean isHasCover(){return coverImage!=null&&coverImage.length>0;}
    public Long getId(){return id;} public void setId(Long v){id=v;}
    public String getTitle(){return title;} public void setTitle(String v){title=v;}
    public String getAuthor(){return author;} public void setAuthor(String v){author=v;}
    public String getCategory(){return category;} public void setCategory(String v){category=v;}
    public String getPublisher(){return publisher;} public void setPublisher(String v){publisher=v;}
    public Integer getPublishYear(){return publishYear;} public void setPublishYear(Integer v){publishYear=v;}
    public String getDescription(){return description;} public void setDescription(String v){description=v;}
    public Integer getTotalCopies(){return totalCopies;} public void setTotalCopies(Integer v){totalCopies=v;}
    public Integer getAvailableCopies(){return availableCopies;} public void setAvailableCopies(Integer v){availableCopies=v;}
    public byte[] getCoverImage(){return coverImage;} public void setCoverImage(byte[] v){coverImage=v;}
    public String getCoverType(){return coverType;} public void setCoverType(String v){coverType=v;}
}