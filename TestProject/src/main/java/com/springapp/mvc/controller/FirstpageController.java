package com.springapp.mvc.controller;

import com.springapp.mvc.domain.*;
import com.springapp.mvc.repository.FirstPageRepository;
import com.springapp.mvc.repository.TestRepository;
import com.springapp.mvc.repository.TestcategoryRepository;
import com.springapp.mvc.repository.UserRepository;
import com.springapp.mvc.service.CreateListTest;
import com.springapp.mvc.service.CreateTreeFromQuery;
import com.springapp.mvc.service.CreateTreeFromQueryTest;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class FirstpageController {

    @Autowired
    private FirstPageRepository firstPageRepository;

    @Autowired(required = false)
    private CreateTreeFromQuery treeBean;

    @Autowired(required = false)
    private CreateListTest createListTestBean;


    @Autowired
    private TestcategoryRepository testcategoryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TestRepository testRepository;

    @Autowired(required = false)
    private CreateTreeFromQueryTest treeTestBean;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String getBasic(Model model) {
        String countTest = firstPageRepository.testQuantity();
        List<TestcategoriesEntity> listCategories = firstPageRepository.listCategoriesByParentID(0);
        List<TestcategoriesEntity> allCategories = firstPageRepository.listCategories();
        model.addAttribute("count", countTest);
        model.addAttribute("categories", listCategories);
        model.addAttribute("allcategories", allCategories);
        return "index";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String getRegister(Model model) {
        return "register";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/question", method = RequestMethod.GET)
    public String getQuestion(Model model) {
        model.addAttribute("tree", treeBean.createTree());
        return "tablequestions";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/tests", method = RequestMethod.GET)
    public String getTests(Model model) {
        model.addAttribute("tree", treeTestBean.createTree(0));
        return "tests";
    }


    @RequestMapping(value = "/open/{id}", method = RequestMethod.GET)
    public String openCategory(@PathVariable int id, Model model) {

        TestcategoriesEntity ourCategory = testcategoryRepository.getCategoryByID(id);
        model.addAttribute("picture", ourCategory.getPicture());
        model.addAttribute("category", ourCategory.getCategory());
        model.addAttribute("description", ourCategory.getDescription());
        model.addAttribute("tree", treeTestBean.createTree(ourCategory.getId()));
        model.addAttribute("list", treeTestBean.createList(ourCategory.getId()));
        return "categorylist";
    }

    @RequestMapping(value = "/getlisttest", method = RequestMethod.POST, produces = {"text/html; charset=UTF-8"})
    @ResponseBody
    public String getParent(@RequestParam("category") int category) {
        return treeTestBean.createList(category);
    }


    @RequestMapping(value = "/search", method = RequestMethod.POST, produces = {"text/html; charset=UTF-8"})
    @ResponseBody
    public String getSearch(@RequestParam("category") int category,@RequestParam("search") String search) {
        return createListTestBean.returnSearchList(category,search);
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/opentest", method = RequestMethod.POST)
    public String openTest(@RequestParam("testnumber") String testnumber, Model model) {
        TestsEntity ourTest = testRepository.getTestByPath(testnumber);

        Date ourCurrentDate = new Date(System.currentTimeMillis());

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UsersEntity ourUser = userRepository.findUserByEmail(user.getUsername());

        int flag = 0;

        Date dateStart = ourTest.getDateStart();
        Date dateFinish = ourTest.getDateFinish();

        if (dateStart != null) {
            if (ourCurrentDate.before(dateStart)) {
                model.addAttribute("flag", "before");
                StringBuilder ourBuffer = new StringBuilder(500);
                ourBuffer.append("<li class=\"list-group-item list-group-item-danger\">");
                ourBuffer.append("<span class=\"glyphicon glyphicon-star\"></span>");
                ourBuffer.append("<h4 class=\"list-group-item-heading\">");
                ourBuffer.append("Тест будет доступен после: ");
                ourBuffer.append(dateStart);
                ourBuffer.append("</h4>");
                ourBuffer.append("</li>");
                model.addAttribute("list",ourBuffer.toString());
                model.addAttribute("count",0);
                flag = 1;
            }
        }

        if (dateFinish != null) {
            if (ourCurrentDate.after(dateFinish)) {
                model.addAttribute("flag", "after");
                StringBuilder ourBuffer = new StringBuilder(500);
                ourBuffer.append("<li class=\"list-group-item list-group-item-danger\">");
                ourBuffer.append("<span class=\"glyphicon glyphicon-star\"></span>");
                ourBuffer.append("<h4 class=\"list-group-item-heading\">");
                ourBuffer.append("Тест закрыт с: ");
                ourBuffer.append(dateFinish);
                ourBuffer.append("</h4>");
                ourBuffer.append("</li>");
                model.addAttribute("list",ourBuffer.toString());
                model.addAttribute("count",0);
                flag = 1;
            }
        }

        model.addAttribute("surname", ourUser.getSurname());
        model.addAttribute("name", ourUser.getName());
        model.addAttribute("phone", ourUser.getPhone());
        model.addAttribute("email", ourUser.getEmail());
        model.addAttribute("description", ourTest.getTestname());
        Calendar calendar = Calendar.getInstance();
        long now = calendar.getTimeInMillis();
        model.addAttribute("datestart", now);
        model.addAttribute("testid", ourTest.getId());

        if (flag == 0) //all OK
        {
            model.addAttribute("list", createListTestBean.createListTest(testnumber));
            model.addAttribute("count", testRepository.getCountQuestionByTestID(ourTest.getId()));
        }




        return "testform";
    }


    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/writetestuser", method = RequestMethod.POST, produces = {"text/html; charset=UTF-8"})
    @ResponseBody
    public String writeTestUser(@RequestParam("ourResult") String ourResult,@RequestParam("datefinish") long datef, @RequestParam("datebegin") long date, @RequestParam("testid") int testid) throws Exception {

        JSONParser parser = new JSONParser();

        Object listObj = parser.parse(ourResult);
        JSONArray arrayJSON = (JSONArray) listObj;

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UsersEntity ourUser = userRepository.findUserByEmail(user.getUsername());

        FormsEntity ourForm = new FormsEntity();
        ourForm.setIdUser(ourUser.getId());

        ourForm.setDatestart(new Timestamp(date));
        ourForm.setDatefinish(new Timestamp(datef));
        ourForm.setIdTest(testid);
        ourForm.setCorrectQuestion(0);
        ourForm.setQuantityQuestion(0);

        ourForm = testRepository.addForm(ourForm); //save to base

        AnswersUserEntity ourAnswer = null;
        int flag = 0;
        for (int i = 0; i < arrayJSON.size(); i++) {
            JSONObject obj = (JSONObject) arrayJSON.get(i);

            String ourElement = obj.get("name").toString();
            String ourValue = obj.get("value").toString();


            if (ourElement.contains("question"))//it's a question
            {
                ourAnswer = new AnswersUserEntity();
                ourAnswer.setIdQuestion(new Integer(ourElement.replace("question", "")));
                ourAnswer.setIdForm(ourForm.getId());
                ourAnswer.setIdAnswer(0);
                testRepository.addResult(ourAnswer); //write to base our result
                flag = 0;
                continue;
            }

            if (ourElement.contains("answer"))//it's an answer
            {
                ourAnswer.setIdAnswer(new Integer(ourElement.replace("answer" + ourAnswer.getIdQuestion() + "id", "")));
                if (!ourValue.equals("")) {
                    ourAnswer.setTextanswer(ourValue);
                }
                if (flag == 0) {
                    testRepository.updateResult(ourAnswer); //update to base our result
                    flag++;
                } else {
                    testRepository.addResult(ourAnswer);
                }

            }


        }

        return createListTestBean.returnResult(ourForm.getId());
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/statistics", method = RequestMethod.GET)
    public String getStatistics(Model model) {
        return "statistics";
    }

}
