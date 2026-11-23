package com.tdc.nhom6.doanjava1.controller;
import com.tdc.nhom6.doanjava1.model.Account;
import com.tdc.nhom6.doanjava1.service.AccountService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;
@Controller
public class AuthController {
 private final AccountService service;
 public AuthController(AccountService service){this.service=service;}
 @GetMapping("/login") public String loginPage(){return "auth/login";}
 @PostMapping("/login") public String login(@RequestParam String username,@RequestParam String password,HttpSession s,Model m){Account a=service.authenticate(username,password);if(a==null){m.addAttribute("error","Incorrect username or password.");m.addAttribute("username",username);return "auth/login";}s.setAttribute("currentUser",a);return "redirect:/books";}
 @GetMapping("/register") public String registerPage(){return "auth/register";}
 @PostMapping("/register") public String register(@RequestParam String username,@RequestParam String password,@RequestParam String fullName,RedirectAttributes ra,Model m){try{service.register(username,password,fullName);ra.addFlashAttribute("success","Account created. Sign in now.");return "redirect:/login";}catch(RuntimeException e){m.addAttribute("error",e.getMessage());m.addAttribute("username",username);m.addAttribute("fullName",fullName);return "auth/register";}}
 @PostMapping("/logout") public String logout(HttpSession s){s.invalidate();return "redirect:/books";}
}
