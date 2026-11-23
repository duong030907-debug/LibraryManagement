package com.tdc.nhom6.doanjava1.controller;
import com.tdc.nhom6.doanjava1.model.*;
import com.tdc.nhom6.doanjava1.service.BookService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;
@Controller @RequestMapping("/books")
public class BookController {
 private final BookService service;
 public BookController(BookService service){this.service=service;}
 @GetMapping public String list(@RequestParam(value="keyword",required=false)String keyword,Model model,HttpSession session){model.addAttribute("books",service.search(keyword));model.addAttribute("keyword",keyword==null?"":keyword);model.addAttribute("account",session.getAttribute("currentUser"));return "books/list";}
 @GetMapping("/new") public String newForm(HttpSession s,Model m){if(!manager(s))return "redirect:/login";m.addAttribute("book",new Book());m.addAttribute("formTitle","Add a book");m.addAttribute("account",s.getAttribute("currentUser"));return "books/form";}
 @PostMapping public String create(@ModelAttribute Book book,HttpSession s,RedirectAttributes ra){if(!manager(s))return "redirect:/login";try{service.save(book);ra.addFlashAttribute("success","Book added.");}catch(RuntimeException e){ra.addFlashAttribute("error",e.getMessage());return "redirect:/books/new";}return "redirect:/books";}
 @GetMapping("/{id}/edit") public String edit(@PathVariable Long id,HttpSession s,Model m){if(!manager(s))return "redirect:/login";Book b=service.findById(id);if(b==null)return "redirect:/books";m.addAttribute("book",b);m.addAttribute("formTitle","Edit book");m.addAttribute("account",s.getAttribute("currentUser"));return "books/form";}
 @PostMapping("/{id}") public String update(@PathVariable Long id,@ModelAttribute Book book,HttpSession s,RedirectAttributes ra){if(!manager(s))return "redirect:/login";book.setId(id);try{service.save(book);ra.addFlashAttribute("success","Book updated.");}catch(RuntimeException e){ra.addFlashAttribute("error",e.getMessage());}return "redirect:/books";}
 @PostMapping("/{id}/delete") public String delete(@PathVariable Long id,HttpSession s,RedirectAttributes ra){if(!manager(s))return "redirect:/login";try{service.delete(id);ra.addFlashAttribute("success","Book deleted.");}catch(RuntimeException e){ra.addFlashAttribute("error",e.getMessage());}return "redirect:/books";}
 private boolean manager(HttpSession s){Account a=(Account)s.getAttribute("currentUser");return a!=null&&a.canManage();}
}
