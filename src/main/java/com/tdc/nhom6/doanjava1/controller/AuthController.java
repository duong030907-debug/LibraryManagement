package com.tdc.nhom6.doanjava1.controller;
import com.tdc.nhom6.doanjava1.model.Account;import com.tdc.nhom6.doanjava1.service.AccountService;
import javax.servlet.http.HttpSession;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.*;import org.springframework.web.servlet.mvc.support.RedirectAttributes;
@Controller public class AuthController {
 private final AccountService service;public AuthController(AccountService s){service=s;}
 @GetMapping("/login") public String loginPage(HttpSession s){return s.getAttribute("currentUser")!=null?"redirect:/books":"auth/login";}
 @PostMapping("/login") public String login(@RequestParam String username,@RequestParam String password,HttpSession s,RedirectAttributes ra){Account a=service.authenticate(username,password);if(a==null){ra.addFlashAttribute("error","Tên đăng nhập hoặc mật khẩu không đúng");return "redirect:/login";}s.setAttribute("currentUser",a);String target=(String)s.getAttribute("redirectAfterLogin");s.removeAttribute("redirectAfterLogin");return target!=null&&!target.contains("/login")?"redirect:"+target:"redirect:/books";}
 @GetMapping("/register") public String registerPage(){return "auth/register";}
 @PostMapping("/register") public String register(@RequestParam String username,@RequestParam String password,@RequestParam String fullName,@RequestParam(required=false)String email,RedirectAttributes ra){try{service.register(username,password,fullName,email);ra.addFlashAttribute("success","Đăng ký thành công. Hãy đăng nhập.");return "redirect:/login";}catch(RuntimeException e){ra.addFlashAttribute("error",e.getMessage());return "redirect:/register";}}
 @GetMapping("/logout") public String logout(HttpSession s){s.invalidate();return "redirect:/login";}
 @PostMapping("/logout") public String logoutPost(HttpSession s){s.invalidate();return "redirect:/login";}
 @GetMapping("/profile") public String profile(HttpSession s,Model m){Account a=(Account)s.getAttribute("currentUser");if(a==null)return "redirect:/login";m.addAttribute("account",a);return "auth/profile";}
}