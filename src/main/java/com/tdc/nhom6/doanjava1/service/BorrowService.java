package com.tdc.nhom6.doanjava1.service;
import com.tdc.nhom6.doanjava1.model.*;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;
@Service
public class BorrowService {
 private final List<BorrowRecord> records=new ArrayList<>(); private long nextId=1; private final BookService books;
 public BorrowService(BookService books){this.books=books;}
 public synchronized BorrowRecord borrow(Book book,Account account){
  if(book==null)throw new IllegalArgumentException("Book not found.");if(account==null)throw new IllegalArgumentException("Please sign in first.");
  books.changeAvailableCopies(book.getId(),-1);BorrowRecord r=new BorrowRecord();r.setId(nextId++);r.setBookId(book.getId());r.setAccountId(account.getId());r.setBookTitle(book.getTitle());r.setAccountName(account.getFullName());r.setBorrowedAt(LocalDateTime.now());records.add(r);return r;
 }
 public synchronized void returnBook(Long recordId,Long accountId){
  BorrowRecord r=records.stream().filter(x->x.getId().equals(recordId)).findFirst().orElseThrow(()->new IllegalArgumentException("Borrow record not found."));
  if(!r.getAccountId().equals(accountId))throw new IllegalStateException("You cannot return another user's book.");if(r.isReturned())throw new IllegalStateException("This book was already returned.");
  r.setReturnedAt(LocalDateTime.now());books.changeAvailableCopies(r.getBookId(),1);
 }
 public synchronized List<BorrowRecord> findByAccount(Long accountId){return records.stream().filter(r->r.getAccountId().equals(accountId)).sorted(Comparator.comparing(BorrowRecord::getBorrowedAt).reversed()).collect(Collectors.toList());}
}
