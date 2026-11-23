package com.tdc.nhom6.doanjava1.service;
import com.tdc.nhom6.doanjava1.model.*;import org.springframework.stereotype.Service;import org.springframework.web.multipart.MultipartFile;import java.util.*;import java.util.concurrent.atomic.AtomicLong;
@Service
public class DocumentService {
 private final Map<Long,DigitalDocument> docs=new LinkedHashMap<>();private final AtomicLong ids=new AtomicLong();
 public synchronized DigitalDocument upload(MultipartFile f,String title,String author,String description,String type,Long uploader)throws java.io.IOException{if(f==null||f.isEmpty())throw new IllegalArgumentException("Vui lòng chọn file");if(f.getSize()>50L*1024*1024)throw new IllegalArgumentException("File vượt quá 50MB");String name=f.getOriginalFilename()==null?"document":f.getOriginalFilename();String low=name.toLowerCase();if(!(low.endsWith(".pdf")||low.endsWith(".doc")||low.endsWith(".docx")))throw new IllegalArgumentException("Chỉ hỗ trợ PDF, DOC, DOCX");DigitalDocument d=new DigitalDocument();d.setId(ids.incrementAndGet());d.setTitle(title);d.setAuthor(author);d.setDescription(description);d.setDocumentType(type==null?"OTHER":type);d.setFileName(name);d.setFileData(f.getBytes());d.setContentType(f.getContentType());d.setFileSize(f.getSize());d.setDownloadCount(0L);docs.put(d.getId(),d);return d;}
 public synchronized List<DigitalDocument> findAll(){return new ArrayList<>(docs.values());}
 public synchronized DigitalDocument findById(Long id){return docs.get(id);}
 public synchronized void delete(Long id){docs.remove(id);}
 public synchronized void incrementDownload(Long id){DigitalDocument d=docs.get(id);if(d!=null)d.setDownloadCount(d.getDownloadCount()+1);}
}