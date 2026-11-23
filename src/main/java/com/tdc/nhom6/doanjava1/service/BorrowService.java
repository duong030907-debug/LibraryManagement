package com.tdc.nhom6.doanjava1.service;
import com.tdc.nhom6.doanjava1.model.*;import org.springframework.stereotype.Service;
import java.time.*;import java.time.temporal.ChronoUnit;import java.math.BigDecimal;import java.util.*;import java.util.stream.Collectors;
@Service
public class BorrowService {
 private final List<BorrowRecord> records=new ArrayList<>();private long nextId=1;private final BookService books;private final AccountService accounts;
 public BorrowService(BookService b,AccountService a){books=b;accounts=a;b.setBorrowService(this);}
 public synchronized BorrowRecord requestBorrow(Long aid,Long bid,String notes){Account a=accounts.findById(aid);Book b=books.findById(bid);if(a==null||!a.isActive())throw new IllegalArgumentException("Không tìm thấy tài khoản");if(b==null)throw new IllegalArgumentException("Không tìm thấy sách");if(b.getAvailableCopies()<=0)throw new IllegalStateException("Sách hiện không còn bản để mượn");if(records.stream().anyMatch(r->r.getAccountId().equals(aid)&&r.getBookId().equals(bid)&&"ACTIVE".equals(r.getStatus())))throw new IllegalStateException("Bạn đang mượn cuốn sách này rồi");books.changeAvailableCopies(bid,-1);BorrowRecord r=new BorrowRecord();r.setId(nextId++);r.setAccount(a);r.setBook(b);r.setBorrowDate(LocalDate.now());r.setDueDate(LocalDate.now().plusDays(14));r.setNotes(notes);records.add(r);return r;}
 public synchronized BorrowRecord borrow(Book b,Account a){return requestBorrow(a.getId(),b.getId(),null);}
 public synchronized BorrowRecord returnBook(Long id){BorrowRecord r=require(id);if(!"ACTIVE".equals(r.getStatus()))throw new IllegalStateException("Phiếu mượn này đã được đóng");LocalDate today=LocalDate.now();r.setReturnDate(today);long days=Math.max(0,ChronoUnit.DAYS.between(r.getDueDate(),today));r.setFineAmount(new BigDecimal("2000").multiply(BigDecimal.valueOf(days)));r.setStatus(days>0?"RETURNED_LATE":"RETURNED");r.setFinePaid(days==0);books.changeAvailableCopies(r.getBookId(),1);return r;}
 public synchronized void returnBook(Long id,Long aid){BorrowRecord r=require(id);Account a=accounts.findById(aid);if(a==null||(!r.getAccountId().equals(aid)&&!a.canManage()))throw new IllegalStateException("Bạn không có quyền trả sách này");returnBook(id);}
 public synchronized void payFine(Long id){BorrowRecord r=require(id);if(r.isFinePaid()||r.getFineAmount().signum()==0)throw new IllegalStateException("Không có khoản phạt cần thanh toán");r.setFinePaid(true);}
 public synchronized BorrowRecord findById(Long id){return records.stream().filter(r->r.getId().equals(id)).findFirst().orElse(null);}
 private BorrowRecord require(Long id){BorrowRecord r=findById(id);if(r==null)throw new IllegalArgumentException("Không tìm thấy phiếu mượn");return r;}
 public synchronized boolean hasHistory(Long id){return records.stream().anyMatch(r->r.getBookId().equals(id));}
 public synchronized List<BorrowRecord> findAll(){return records.stream().sorted(Comparator.comparing(BorrowRecord::getBorrowDate).reversed()).collect(Collectors.toList());}
 public synchronized List<BorrowRecord> findActive(){return findAll().stream().filter(r->"ACTIVE".equals(r.getStatus())).collect(Collectors.toList());}
 public synchronized List<BorrowRecord> findActiveByAccount(Long id){return findActive().stream().filter(r->r.getAccountId().equals(id)).collect(Collectors.toList());}
 public synchronized List<BorrowRecord> findByAccount(Long id){return findAll().stream().filter(r->r.getAccountId().equals(id)).collect(Collectors.toList());}
 public synchronized List<BorrowRecord> findOverdue(){return findActive().stream().filter(BorrowRecord::isOverdue).collect(Collectors.toList());}
 public synchronized Set<Long> findActiveBookIds(Long id){return findActiveByAccount(id).stream().map(BorrowRecord::getBookId).collect(Collectors.toSet());}
 public synchronized List<Map<String,Object>> mostBorrowed(int n){Map<Long,Long> counts=findAll().stream().collect(Collectors.groupingBy(BorrowRecord::getBookId,Collectors.counting()));return counts.entrySet().stream().sorted(Map.Entry.<Long,Long>comparingByValue().reversed()).limit(n).map(e->{Book b=books.findById(e.getKey());Map<String,Object> m=new HashMap<>();m.put("bookId",e.getKey());m.put("title",b.getTitle());m.put("author",b.getAuthor());m.put("borrowCount",e.getValue());return m;}).collect(Collectors.toList());}
 public synchronized long countBorrowedThisMonth(){return findAll().stream().filter(r->YearMonth.from(r.getBorrowDate()).equals(YearMonth.now())).count();}
 public synchronized long countReturnedThisMonth(){return findAll().stream().filter(r->r.getReturnDate()!=null&&YearMonth.from(r.getReturnDate()).equals(YearMonth.now())).count();}
 public synchronized BigDecimal finesCollected(){return records.stream().filter(BorrowRecord::isFinePaid).map(BorrowRecord::getFineAmount).reduce(BigDecimal.ZERO,BigDecimal::add);}
}