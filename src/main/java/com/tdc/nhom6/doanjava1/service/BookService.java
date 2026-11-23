package com.tdc.nhom6.doanjava1.service;
import com.tdc.nhom6.doanjava1.model.Book;
import org.springframework.stereotype.Service;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;
@Service
public class BookService {
 private final Map<Long,Book> books=new ConcurrentHashMap<>(); private final AtomicLong ids=new AtomicLong();
 public BookService(){
  save(new Book(null,"Dune","Frank Herbert","Science fiction","A science-fiction story set on the desert planet Arrakis.",4));
  save(new Book(null,"The Hobbit","J.R.R. Tolkien","Fantasy","Bilbo Baggins begins an unexpected adventure.",3));
  save(new Book(null,"Clean Code","Robert C. Martin","Programming","A practical guide to writing readable software.",2));
  save(new Book(null,"The Pragmatic Programmer","Andrew Hunt","Programming","Practical ideas for software craftsmanship.",2));
 }
 public List<Book> findAll(){return books.values().stream().sorted(Comparator.comparing(Book::getId)).collect(Collectors.toList());}
 public List<Book> search(String keyword){
  if(keyword==null||keyword.isBlank())return findAll(); String q=keyword.trim().toLowerCase();
  return findAll().stream().filter(b->has(b.getTitle(),q)||has(b.getAuthor(),q)||has(b.getCategory(),q)).collect(Collectors.toList());
 }
 private boolean has(String value,String q){return value!=null&&value.toLowerCase().contains(q);}
 public Book findById(Long id){return books.get(id);}
 public synchronized Book save(Book book){
  if(book.getTitle()==null||book.getTitle().isBlank())throw new IllegalArgumentException("Title is required.");
  if(book.getAuthor()==null||book.getAuthor().isBlank())throw new IllegalArgumentException("Author is required.");
  if(book.getId()==null){book.setId(ids.incrementAndGet());if(book.getTotalCopies()<1)book.setTotalCopies(1);book.setAvailableCopies(book.getTotalCopies());}
  else {Book old=books.get(book.getId());if(old==null)throw new IllegalArgumentException("Book not found.");int borrowed=old.getTotalCopies()-old.getAvailableCopies();if(book.getTotalCopies()<borrowed)throw new IllegalArgumentException("Total copies cannot be less than copies currently borrowed.");book.setAvailableCopies(book.getTotalCopies()-borrowed);}
  books.put(book.getId(),book);return book;
 }
 public void delete(Long id){Book b=books.get(id);if(b==null)return;if(b.getAvailableCopies()!=b.getTotalCopies())throw new IllegalStateException("This book is currently borrowed.");books.remove(id);}
 public synchronized void changeAvailableCopies(Long id,int delta){Book b=books.get(id);if(b==null)throw new IllegalArgumentException("Book not found.");int n=b.getAvailableCopies()+delta;if(n<0||n>b.getTotalCopies())throw new IllegalStateException("No available copies.");b.setAvailableCopies(n);}
}
