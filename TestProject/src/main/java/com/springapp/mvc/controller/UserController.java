package com.springapp.mvc.controller;

import com.springapp.mvc.component.RegisterValidator;
import com.springapp.mvc.domain.UsersEntity;
import com.springapp.mvc.forms.RegisterForm;
import com.springapp.mvc.repository.UserRepository;
import com.springapp.mvc.service.CreateListTest;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserController {

    @Autowired
    private UserRepository userRepository;
    private RegisterValidator registerValidator;

    @Autowired(required = false)
    private CreateListTest createListTestBean;

    @RequestMapping(value = "/createuser", method = RequestMethod.POST)
    public String getUser(@ModelAttribute("new_user") RegisterForm userForm, Model model, BindingResult result) throws Exception {

        registerValidator = new RegisterValidator();
        registerValidator.validate(userForm, result);
        model.addAttribute("name", userForm.getName());
        model.addAttribute("surname", userForm.getSurname());
        model.addAttribute("phone", userForm.getPhone());
        model.addAttribute("email", userForm.getEmail());
        model.addAttribute("password", userForm.getPassword());
        model.addAttribute("confirmpassword", userForm.getConfirmpassword());
        model.addAttribute("errorname", "");
        model.addAttribute("errorsurname", "");
        model.addAttribute("errorphone", "");
        model.addAttribute("erroremail", "");
        model.addAttribute("errorpassword", "");
        model.addAttribute("confirmpassword", "");
        model.addAttribute("errorconfirmpassword", "");


        if (result.hasErrors()) {
            for (ObjectError error : result.getAllErrors())
                model.addAttribute("error" + error.getCode(), error.getDefaultMessage());
            return "register";
        }

        if (userRepository.findUserByEmail(userForm.getEmail()) != null) {
            model.addAttribute("erroremail", "Пользователь с таким адресом уже существует");
            return "register";
        }

        UsersEntity usersEntity = new UsersEntity();
        usersEntity.setName(userForm.getName());
        usersEntity.setSurname(userForm.getSurname());
        usersEntity.setEmail(userForm.getEmail());
        usersEntity.setPhone(userForm.getPhone());
        usersEntity.setPassword(DigestUtils.sha256Hex(userForm.getPassword()));
        usersEntity.setIdRule(1);
        usersEntity.setStatus((byte) 1);
        userRepository.createUser(usersEntity);

        model.addAttribute("name", "");
        model.addAttribute("surname", "");
        model.addAttribute("phone", "");
        model.addAttribute("email", userForm.getEmail());
        model.addAttribute("password", "");
        model.addAttribute("confirmpassword", "");
        model.addAttribute("errorname", "");
        model.addAttribute("errorsurname", "");
        model.addAttribute("errorphone", "");
        model.addAttribute("erroremail", "");
        model.addAttribute("errorpassword", "");
        model.addAttribute("confirmpassword", "");
        model.addAttribute("errorconfirmpassword", "");

        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getLogin(Model model) {
        return "login";
    }

    @RequestMapping(value = "/login/{error}", method = RequestMethod.GET)
    public String admin(@PathVariable String error, Model model) {

        if (error.equals("error")) {
            model.addAttribute("error", 1);
        }

        return "login";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/tableuser", method = RequestMethod.GET)
    public String getUsers(Model model) {
        model.addAttribute("users", userRepository.getAllUsers());
        return "tableuser";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/edituser/{userid}", method = RequestMethod.GET)
    public String edituser(@PathVariable int userid, Model model) {
        UsersEntity ourUser = userRepository.findUserByID(userid);
        if (ourUser != null) {
            model.addAttribute("user", ourUser);
            model.addAttribute("rule", userRepository.findRuleByUserID(userid));
            return "edituser";
        }
        return "forward:/";

    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/updateuser", method = RequestMethod.POST)
    public String updateuser(@RequestParam("id") int id, @RequestParam("name") String name, @RequestParam("surname") String surname, @RequestParam("phone") String phone, @RequestParam("email") String email, @RequestParam("rule") String rule, @RequestParam("status") int status, @RequestParam("password") String password, Model model) {
        UsersEntity ourUser = userRepository.findUserByID(id);
        ourUser.setStatus((byte) status);
        ourUser.setPhone(phone);
        ourUser.setName(name);
        ourUser.setSurname(surname);
        ourUser.setEmail(email);
        if (!ourUser.getPassword().equals(password)) {
            ourUser.setPassword(DigestUtils.sha256Hex(password));
        }
        if (rule.equals("admin")) {
            ourUser.setIdRule(2);
        }
        if (rule.equals("user")) {
            ourUser.setIdRule(1);
        }
        try {
            userRepository.updateUser(ourUser);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("users", userRepository.getAllUsers());
        return "tableuser";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/resultuser/{userid}", method = RequestMethod.GET)
    public String resultUser(@PathVariable int userid, Model model) {
        model.addAttribute("table", userRepository.getUsersResult(userid));
        return "userstest";

    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getuserresult", method = RequestMethod.POST, produces = {"text/html; charset=UTF-8"})
    @ResponseBody
    public String getUserResult(@RequestParam("testid") int testid){
         return createListTestBean.returnResult(testid);
    }




    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/edituserprofile", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String editUserprofile( @RequestParam("name") String name, @RequestParam("surname") String surname, @RequestParam("phone") String phone, @RequestParam("email") String email, @RequestParam("password") String password) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UsersEntity ourUser = userRepository.findUserByEmail(user.getUsername());
        ourUser.setPhone(phone);
        ourUser.setName(name);
        ourUser.setSurname(surname);
        ourUser.setEmail(email);

        if (!ourUser.getPassword().equals(password)) {
            ourUser.setPassword(DigestUtils.sha256Hex(password));
        }


        try {
            userRepository.updateUser(ourUser);
        } catch (Exception e) {
            e.printStackTrace();
        }

        StringBuilder json = new StringBuilder(100);
        json.append("{\"name\":\"");
        json.append(ourUser.getName());
        json.append("\",\"surname\":\"");
        json.append(ourUser.getSurname());
        json.append("\",\"phone\":\"");
        json.append(ourUser.getPhone());
        json.append("\",\"email\":\"");
        json.append(ourUser.getEmail());
        json.append("\"}");
        return json.toString();
    }

}
