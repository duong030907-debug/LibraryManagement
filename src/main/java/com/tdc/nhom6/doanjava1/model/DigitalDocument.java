package com.tdc.nhom6.doanjava1.model;
import java.time.LocalDateTime;
public class DigitalDocument {
 private Long id, fileSize, downloadCount=0L; private String title,author,description,documentType,fileName,contentType;
 private byte[] fileData; private Account uploadedBy; private LocalDateTime uploadedAt=LocalDateTime.now();
 public Long getId(){return id;} public void setId(Long v){id=v;}
 public Long getFileSize(){return fileSize;} public void setFileSize(Long v){fileSize=v;}
 public Long getDownloadCount(){return downloadCount;} public void setDownloadCount(Long v){downloadCount=v;}
 public String getTitle(){return title;} public void setTitle(String v){title=v;}
 public String getAuthor(){return author;} public void setAuthor(String v){author=v;}
 public String getDescription(){return description;} public void setDescription(String v){description=v;}
 public String getDocumentType(){return documentType;} public void setDocumentType(String v){documentType=v;}
 public String getFileName(){return fileName;} public void setFileName(String v){fileName=v;}
 public String getContentType(){return contentType;} public void setContentType(String v){contentType=v;}
 public byte[] getFileData(){return fileData;} public void setFileData(byte[] v){fileData=v;}
 public Account getUploadedBy(){return uploadedBy;} public void setUploadedBy(Account v){uploadedBy=v;}
 public LocalDateTime getUploadedAt(){return uploadedAt;} public void setUploadedAt(LocalDateTime v){uploadedAt=v;}
}