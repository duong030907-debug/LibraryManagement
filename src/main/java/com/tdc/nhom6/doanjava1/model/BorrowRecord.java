package com.tdc.nhom6.doanjava1.model;
import java.time.LocalDateTime;
public class BorrowRecord {
 private Long id; private Long accountId; private Long bookId; private String accountName; private String bookTitle; private LocalDateTime borrowedAt; private LocalDateTime returnedAt;
 public Long getId(){return id;} public void setId(Long id){this.id=id;}
 public Long getAccountId(){return accountId;} public void setAccountId(Long accountId){this.accountId=accountId;}
 public Long getBookId(){return bookId;} public void setBookId(Long bookId){this.bookId=bookId;}
 public String getAccountName(){return accountName;} public void setAccountName(String accountName){this.accountName=accountName;}
 public String getBookTitle(){return bookTitle;} public void setBookTitle(String bookTitle){this.bookTitle=bookTitle;}
 public LocalDateTime getBorrowedAt(){return borrowedAt;} public void setBorrowedAt(LocalDateTime borrowedAt){this.borrowedAt=borrowedAt;}
 public LocalDateTime getReturnedAt(){return returnedAt;} public void setReturnedAt(LocalDateTime returnedAt){this.returnedAt=returnedAt;}
 public boolean isReturned(){return returnedAt!=null;}
}
