package com.tdc.nhom6.doanjava1.controller;
import com.tdc.nhom6.doanjava1.model.*;
import com.tdc.nhom6.doanjava1.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;
@Controller
public class BorrowController {
 private final BookService books;private final BorrowService borrows;
 public BorrowController(BookService books,BorrowService borrows){this.books=books;this.borrows=borrows;}
 @PostMapping("/borrow/{bookId}") public String borrow(@PathVariable Long bookId,HttpSession s,RedirectAttributes ra){Account a=(Account)s.getAttribute("currentUser");if(a==null)return "redirect:/login";try{borrows.borrow(books.findById(bookId),a);ra.addFlashAttribute("success","Book borrowed.");}catch(RuntimeException e){ra.addFlashAttribute("error",e.getMessage());}return "redirect:/books";}
 @GetMapping("/borrow/history") public String history(HttpSession s,Model m){Account a=(Account)s.getAttribute("currentUser");if(a==null)return "redirect:/login";m.addAttribute("account",a);m.addAttribute("records",borrows.findByAccount(a.getId()));return "borrow/history";}
 @PostMapping("/borrow/{recordId}/return") public String returnBook(@PathVariable Long recordId,HttpSession s,RedirectAttributes ra){Account a=(Account)s.getAttribute("currentUser");if(a==null)return "redirect:/login";try{borrows.returnBook(recordId,a.getId());ra.addFlashAttribute("success","Book returned.");}catch(RuntimeException e){ra.addFlashAttribute("error",e.getMessage());}return "redirect:/borrow/history";}
}
