package com.tdc.nhom6.doanjava1.service;
import com.tdc.nhom6.doanjava1.model.Account;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.*;import java.util.concurrent.*;import java.util.concurrent.atomic.AtomicLong;
@Service
public class AccountService {
 private final Map<Long,Account> accounts=new ConcurrentHashMap<>();private final AtomicLong ids=new AtomicLong();private final BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
 public AccountService(){Account a=new Account(ids.incrementAndGet(),"admin",encoder.encode("admin123"),"Library Administrator","ADMIN");a.setEmail("admin@library.local");accounts.put(a.getId(),a);}
 public synchronized Account register(String u,String p,String n){return register(u,p,n,null);}
 public synchronized Account register(String u,String p,String n,String email){
  if(u==null||u.trim().length()<3||u.trim().length()>50)throw new IllegalArgumentException("Tên đăng nhập phải từ 3 đến 50 ký tự");
  if(p==null||p.length()<6)throw new IllegalArgumentException("Mật khẩu phải có ít nhất 6 ký tự");
  if(n==null||n.isBlank())throw new IllegalArgumentException("Họ tên không được để trống");
  final String username=u.trim();if(accounts.values().stream().anyMatch(a->a.getUsername().equalsIgnoreCase(username)))throw new IllegalArgumentException("Tên đăng nhập đã tồn tại");
  if(email!=null&&!email.isBlank()&&accounts.values().stream().anyMatch(a->email.equalsIgnoreCase(a.getEmail())))throw new IllegalArgumentException("Email đã được sử dụng");
  Account a=new Account(ids.incrementAndGet(),username,encoder.encode(p),n.trim(),"STUDENT");a.setEmail(email);accounts.put(a.getId(),a);return a;
 }
 public Account authenticate(String u,String p){if(u==null||p==null)return null;return accounts.values().stream().filter(a->a.isActive()&&a.getUsername().equalsIgnoreCase(u.trim())&&encoder.matches(p,a.getPasswordHash())).findFirst().orElse(null);}
 public Account findById(Long id){return accounts.get(id);}public List<Account> findAll(){return accounts.values().stream().sorted(Comparator.comparing(Account::getId)).collect(java.util.stream.Collectors.toList());}
 public synchronized void promote(Long id){Account a=require(id);if(a.isAdmin())throw new IllegalArgumentException("Không thể thay đổi quyền ADMIN");a.setRole("LIBRARIAN");}
 public synchronized void demote(Long id){Account a=require(id);if(a.isAdmin())throw new IllegalArgumentException("Không thể hạ cấp ADMIN");a.setRole("STUDENT");}
 public synchronized void delete(Long id){Account a=require(id);if(a.isAdmin())throw new IllegalArgumentException("Không thể vô hiệu hóa ADMIN");a.setActive(false);}
 public synchronized void activate(Long id){Account a=require(id);a.setActive(true);}
 private Account require(Long id){Account a=findById(id);if(a==null)throw new IllegalArgumentException("Không tìm thấy tài khoản");return a;}
}