package com.tdc.nhom6.doanjava1.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BorrowRecord {
    private Long id;
    private Account account;
    private Book book;
    private LocalDate borrowDate, dueDate, returnDate;
    private String status="ACTIVE", notes;
    private BigDecimal fineAmount=BigDecimal.ZERO;
    private boolean finePaid;
    public Long getId(){return id;} public void setId(Long v){id=v;}
    public Account getAccount(){return account;} public void setAccount(Account v){account=v;}
    public Book getBook(){return book;} public void setBook(Book v){book=v;}
    public Long getAccountId(){return account==null?null:account.getId();}
    public Long getBookId(){return book==null?null:book.getId();}
    public String getAccountName(){return account==null?"":account.getFullName();}
    public String getBookTitle(){return book==null?"":book.getTitle();}
    public LocalDate getBorrowDate(){return borrowDate;} public void setBorrowDate(LocalDate v){borrowDate=v;}
    public LocalDate getDueDate(){return dueDate;} public void setDueDate(LocalDate v){dueDate=v;}
    public LocalDate getReturnDate(){return returnDate;} public void setReturnDate(LocalDate v){returnDate=v;}
    public String getStatus(){return status;} public void setStatus(String v){status=v;}
    public String getNotes(){return notes;} public void setNotes(String v){notes=v;}
    public BigDecimal getFineAmount(){return fineAmount;} public void setFineAmount(BigDecimal v){fineAmount=v==null?BigDecimal.ZERO:v;}
    public boolean isFinePaid(){return finePaid;} public void setFinePaid(boolean v){finePaid=v;}
    public boolean isReturned(){return returnDate!=null;}
    public boolean isOverdue(){return "ACTIVE".equals(status)&&dueDate!=null&&LocalDate.now().isAfter(dueDate);}
    public long getOverdueDays(){return isOverdue()?ChronoUnit.DAYS.between(dueDate,LocalDate.now()):0;}
}