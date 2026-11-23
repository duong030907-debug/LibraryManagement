package com.tdc.nhom6.doanjava1.service;
import com.tdc.nhom6.doanjava1.model.Account;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;
@Service
public class AccountService {
 private final Map<Long,Account> accounts=new ConcurrentHashMap<>(); private final AtomicLong ids=new AtomicLong(); private final BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
 public AccountService(){Account a=new Account(ids.incrementAndGet(),"admin",encoder.encode("admin123"),"Library Administrator","ADMIN");accounts.put(a.getId(),a);}
 public synchronized Account register(String username,String password,String fullName){
  if(username==null||username.trim().length()<3)throw new IllegalArgumentException("Username must contain at least 3 characters.");
  if(password==null||password.length()<6)throw new IllegalArgumentException("Password must contain at least 6 characters.");
  if(fullName==null||fullName.isBlank())throw new IllegalArgumentException("Full name is required.");
  if(accounts.values().stream().anyMatch(a->a.getUsername().equalsIgnoreCase(username.trim())))throw new IllegalArgumentException("Username already exists.");
  Account a=new Account(ids.incrementAndGet(),username.trim(),encoder.encode(password),fullName.trim(),"STUDENT");accounts.put(a.getId(),a);return a;
 }
 public Account authenticate(String username,String password){
  if(username==null||password==null)return null;
  return accounts.values().stream().filter(a->a.getUsername().equalsIgnoreCase(username.trim())).filter(a->encoder.matches(password,a.getPasswordHash())).findFirst().orElse(null);
 }
}
