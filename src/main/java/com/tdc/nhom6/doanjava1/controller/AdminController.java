package com.tdc.nhom6.doanjava1.controller;

import com.tdc.nhom6.doanjava1.model.*;
import com.tdc.nhom6.doanjava1.service.*;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private final AccountService accounts;
    private final BorrowService borrows;
    private final BookService books;
    private final DocumentService documents;

    public AdminController(AccountService a, BorrowService b, BookService k, DocumentService d) {
        accounts=a; borrows=b; books=k; documents=d;
    }
    private Account current(HttpSession s) { return (Account)s.getAttribute("currentUser"); }
    private boolean allowed(HttpSession s) { Account a=current(s); return a!=null && a.canManage(); }

    @GetMapping({"", "/"})
    public String dashboard(@RequestParam(required=false) Long editBook, HttpSession s, Model m) {
        Account a=current(s);
        if(a==null || !a.canManage()) return "redirect:/login";
        List<Book> allBooks=books.findAll();
        int total=allBooks.stream().mapToInt(b -> b.getTotalCopies()==null?0:b.getTotalCopies()).sum();
        int available=allBooks.stream().mapToInt(b -> b.getAvailableCopies()==null?0:b.getAvailableCopies()).sum();
        Map<String,Object> inventory=new HashMap<>();
        inventory.put("totalTitles",allBooks.size()); inventory.put("totalCopies",total);
        inventory.put("availableCopies",available); inventory.put("borrowedCopies",total-available);
        Map<String,Object> monthly=new HashMap<>();
        monthly.put("month",java.time.YearMonth.now().toString());
        monthly.put("totalBorrows",borrows.countBorrowedThisMonth());
        monthly.put("totalReturns",borrows.countReturnedThisMonth());
        monthly.put("currentOverdue",borrows.findOverdue().size());
        Map<String,Object> revenue=new HashMap<>(); revenue.put("totalFinesCollected",borrows.finesCollected());

        m.addAttribute("account",a);
        m.addAttribute("users",accounts.findAll());
        m.addAttribute("books",allBooks);
        m.addAttribute("editBook",editBook==null?null:books.findById(editBook));
        m.addAttribute("activeRecords",borrows.findActive());
        m.addAttribute("allRecords",borrows.findAll());
        m.addAttribute("overdueRecords",borrows.findOverdue());
        m.addAttribute("documents",documents.findAll());
        m.addAttribute("inventory",inventory); m.addAttribute("monthly",monthly);
        m.addAttribute("revenue",revenue); m.addAttribute("overdueCount",borrows.findOverdue().size());
        m.addAttribute("mostBorrowed",borrows.mostBorrowed(10));
        return "admin/dashboard";
    }

    // Backward-compatible routes now land on the unified administration page.
    @GetMapping("/stats") public String stats() { return "redirect:/admin#overview"; }
    @GetMapping("/users") public String users() { return "redirect:/admin#users"; }

    @GetMapping("/users/{id}/history")
    public String userHistory(@PathVariable Long id,HttpSession s,Model m) {
        if(!allowed(s)) return "redirect:/login";
        Account target=accounts.findById(id);
        if(target==null) return "redirect:/admin#users";
        m.addAttribute("account",current(s)); m.addAttribute("targetUser",target);
        m.addAttribute("records",borrows.findByAccount(id));
        return "admin/user-history";
    }
    @PostMapping("/users/{id}/promote")
    public String promote(@PathVariable Long id,HttpSession s,RedirectAttributes ra) {
        if(current(s)==null||!current(s).isAdmin()) return "redirect:/admin";
        try { accounts.promote(id); ra.addFlashAttribute("success","Đã thăng cấp thành Thủ thư."); }
        catch(RuntimeException e) { ra.addFlashAttribute("error",e.getMessage()); }
        return "redirect:/admin#users";
    }
    @PostMapping("/users/{id}/demote")
    public String demote(@PathVariable Long id,HttpSession s,RedirectAttributes ra) {
        if(current(s)==null||!current(s).isAdmin()) return "redirect:/admin";
        try { accounts.demote(id); ra.addFlashAttribute("success","Đã hạ cấp thành Thành viên."); }
        catch(RuntimeException e) { ra.addFlashAttribute("error",e.getMessage()); }
        return "redirect:/admin#users";
    }
    @PostMapping("/users/{id}/delete")
    public String disable(@PathVariable Long id,HttpSession s,RedirectAttributes ra) {
        if(current(s)==null||!current(s).isAdmin()) return "redirect:/admin";
        try { accounts.delete(id); ra.addFlashAttribute("success","Đã vô hiệu hóa tài khoản."); }
        catch(RuntimeException e) { ra.addFlashAttribute("error",e.getMessage()); }
        return "redirect:/admin#users";
    }
}