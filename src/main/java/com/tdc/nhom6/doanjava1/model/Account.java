package com.tdc.nhom6.doanjava1.model;
import java.time.LocalDateTime;
public class Account {
 private Long id;private String username,passwordHash,fullName,email,role="STUDENT";private boolean active=true;private LocalDateTime createdAt=LocalDateTime.now();
 public Account(){}public Account(Long id,String username,String passwordHash,String fullName,String role){this.id=id;this.username=username;this.passwordHash=passwordHash;this.fullName=fullName;this.role=role;}
 public boolean isAdmin(){return "ADMIN".equals(role);}public boolean isLibrarian(){return "LIBRARIAN".equals(role);}public boolean canManage(){return isAdmin()||isLibrarian();}
 public Long getId(){return id;}public void setId(Long v){id=v;}public String getUsername(){return username;}public void setUsername(String v){username=v;}
 public String getPasswordHash(){return passwordHash;}public void setPasswordHash(String v){passwordHash=v;}public String getFullName(){return fullName;}public void setFullName(String v){fullName=v;}
 public String getEmail(){return email;}public void setEmail(String v){email=v;}public String getRole(){return role;}public void setRole(String v){role=v;}
 public boolean isActive(){return active;}public void setActive(boolean v){active=v;}public LocalDateTime getCreatedAt(){return createdAt;}public void setCreatedAt(LocalDateTime v){createdAt=v;}
}