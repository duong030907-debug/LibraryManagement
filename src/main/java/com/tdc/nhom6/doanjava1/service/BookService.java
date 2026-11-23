package com.tdc.nhom6.doanjava1.service;
import com.tdc.nhom6.doanjava1.model.Book;import org.springframework.stereotype.Service;import org.springframework.web.multipart.MultipartFile;
import java.util.*;import java.util.concurrent.*;import java.util.concurrent.atomic.AtomicLong;import java.util.stream.Collectors;
@Service
public class BookService {
 private final Map<Long,Book> books=new ConcurrentHashMap<>();private final AtomicLong ids=new AtomicLong();private volatile BorrowService borrowService;
 public BookService(){seed("Đắc Nhân Tâm","Dale Carnegie","Kỹ năng","Những nguyên tắc giao tiếp và xây dựng quan hệ.",8);seed("Nhà Giả Kim","Paulo Coelho","Tiểu thuyết","Hành trình theo đuổi ước mơ.",6);seed("Clean Code","Robert C. Martin","Lập trình","A handbook of agile software craftsmanship.",4);seed("Lược Sử Thời Gian","Stephen Hawking","Khoa học","Khám phá vũ trụ và thời gian.",3);seed("Sapiens","Yuval Noah Harari","Lịch sử","Lịch sử ngắn gọn về loài người.",5);}
 private void seed(String t,String a,String c,String d,int n){Book b=new Book(null,t,a,c,d,n);b.setPublisher("NXB Tổng hợp");save(b);}
 public void setBorrowService(BorrowService s){borrowService=s;}
 public List<Book> findAll(){return books.values().stream().sorted(Comparator.comparing(Book::getId)).collect(Collectors.toList());}
 public List<Book> search(String q){return findAll().stream().filter(b->q==null||q.isBlank()||contains(b.getTitle(),q)||contains(b.getAuthor(),q)||contains(b.getCategory(),q)).collect(Collectors.toList());}
 private boolean contains(String s,String q){return s!=null&&s.toLowerCase().contains(q.toLowerCase().trim());}
 public List<Book> findByCategory(String c){return findAll().stream().filter(b->c.equalsIgnoreCase(b.getCategory())).collect(Collectors.toList());}
 public List<Book> findAvailable(){return findAll().stream().filter(Book::isAvailable).collect(Collectors.toList());}
 public Book findById(Long id){return books.get(id);}
 public synchronized Book save(Book b){if(b.getTitle()==null||b.getTitle().isBlank()||b.getAuthor()==null||b.getAuthor().isBlank())throw new IllegalArgumentException("Tiêu đề và tác giả không được để trống");
  if(b.getId()==null){b.setId(ids.incrementAndGet());if(b.getTotalCopies()==null||b.getTotalCopies()<1)b.setTotalCopies(1);b.setAvailableCopies(b.getTotalCopies());}
  else{Book old=books.get(b.getId());if(old==null)throw new IllegalArgumentException("Không tìm thấy sách");int borrowed=old.getTotalCopies()-old.getAvailableCopies();if(b.getTotalCopies()==null||b.getTotalCopies()<borrowed)throw new IllegalArgumentException("Số lượng bản không thể nhỏ hơn số bản đang được mượn");b.setAvailableCopies(b.getTotalCopies()-borrowed);if(b.getCoverImage()==null){b.setCoverImage(old.getCoverImage());b.setCoverType(old.getCoverType());}}
  books.put(b.getId(),b);return b;
 }
 public void update(Long id,Book b){b.setId(id);save(b);}
 public synchronized void delete(Long id){Book b=books.get(id);if(b==null)throw new IllegalArgumentException("Không tìm thấy sách");if(b.getAvailableCopies()!=b.getTotalCopies()||(borrowService!=null&&borrowService.hasHistory(id)))throw new IllegalStateException("Không thể xóa sách đã có lịch sử mượn trả");books.remove(id);}
 public void uploadCover(Long id,MultipartFile f)throws java.io.IOException{Book b=findById(id);if(b==null)throw new IllegalArgumentException("Không tìm thấy sách");b.setCoverImage(f.getBytes());b.setCoverType(f.getContentType());}
 public synchronized void changeAvailableCopies(Long id,int delta){Book b=findById(id);if(b==null)throw new IllegalArgumentException("Không tìm thấy sách");int n=b.getAvailableCopies()+delta;if(n<0||n>b.getTotalCopies())throw new IllegalStateException("Không còn bản sách khả dụng");b.setAvailableCopies(n);}
}