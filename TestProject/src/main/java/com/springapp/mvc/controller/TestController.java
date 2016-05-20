package com.springapp.mvc.controller;

import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.domain.TestsEntity;
import com.springapp.mvc.repository.TestRepository;
import com.springapp.mvc.repository.TestcategoryRepository;
import com.springapp.mvc.repository.UserRepository;
import com.springapp.mvc.service.CreateTreeFromQuery;
import com.springapp.mvc.service.CreateTreeFromQueryTest;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Date;
import java.util.List;
import java.util.Random;

@Controller
public class TestController {

    @Autowired
    private TestRepository testRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TestcategoryRepository testcategoryRepository;


    @Autowired(required = false)
    private CreateTreeFromQuery treeBean;

    @Autowired(required = false)
    private CreateTreeFromQueryTest treeTestBean;


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getparenttest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String addParentTest(@RequestParam("category") String namecategory)
    {
        TestcategoriesEntity ourCategory=testcategoryRepository.getCategoryByID(new Integer(treeBean.returnCode(namecategory)));
        TestcategoriesEntity ourCategoryParent= testcategoryRepository.getCategoryByID(ourCategory.getParent());

        StringBuilder ourBuffer = new StringBuilder(100);
        ourBuffer.append(" Код:");
        ourBuffer.append(ourCategoryParent.getId());
        ourBuffer.append(" ");
        ourBuffer.append(ourCategoryParent.getCategory());

        StringBuilder json=new StringBuilder(100);
        json.append("{\"parent\":\"");
        json.append(ourBuffer.toString());
        json.append("\",\"desc\":\"");
        json.append(ourCategory.getDescription());
        json.append("\"}");
        return json.toString();
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/gettest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String getTests(@RequestParam("category") String category, @RequestParam("context") String context)
    {
        return treeTestBean.getTestByCategory(category,context);
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getpicture", method = RequestMethod.POST)
    @ResponseBody
    public String addPictureTest(@RequestParam("category") String namecategory)
    {
        TestcategoriesEntity ourCategory=testcategoryRepository.getCategoryByID(new Integer(treeBean.returnCode(namecategory)));

        return ourCategory.getPicture();
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addcategorytest", method = RequestMethod.POST)
    @ResponseBody
    public String addCategoryTest(@RequestParam("namecategory") String namecategory, @RequestParam("parent") String parent, @RequestParam("description") String description,@RequestParam("picture") String picture)
    {
        TestcategoriesEntity newCategory = new TestcategoriesEntity();
        newCategory.setCategory(namecategory);

        if (!parent.equals("")) {
            newCategory.setParent(new Integer(treeBean.returnCode(parent)));
        } else {
            newCategory.setParent(0);
        }

        newCategory.setDescription(description);
        newCategory.setPicture(picture);

        try {
            testcategoryRepository.createCategory(newCategory);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/updatecategorytest", method = RequestMethod.POST)
    @ResponseBody
    public String updateCategoryTest(@RequestParam("namecategory") String namecategory, @RequestParam("oldcategory") String oldcategory, @RequestParam("parent") String parent, @RequestParam("description") String description,@RequestParam("picture") String picture)
    {
        TestcategoriesEntity newCategory = testcategoryRepository.getCategoryByID(new Integer(treeBean.returnCode(oldcategory)));

        newCategory.setCategory(namecategory);

        if (!parent.equals("")) {
            newCategory.setParent(new Integer(treeBean.returnCode(parent)));
        } else {
            newCategory.setParent(0);
        }

        newCategory.setDescription(description);
        newCategory.setPicture(picture);

        try {
            testcategoryRepository.updateCategory(newCategory);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/delcategorytest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String delCategory(@RequestParam("namecategory") String namecategory) throws Exception {

        int ourID = new Integer(treeBean.returnCode(namecategory));

        List<TestcategoriesEntity> list = testcategoryRepository.getCategoriesByParentID(ourID);
        if (!list.isEmpty()) {
            return "Не могу удалить есть подчиненные элементы";
        }

        List<TestsEntity> listQ = testcategoryRepository.getAllTestByCategoryID(ourID);
        if (!listQ.isEmpty()) {
            return "Не могу удалить есть связанные вопросы";
        }

        testcategoryRepository.deleteCategory(testcategoryRepository.getCategoryByID(ourID));

        return "";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/writetest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String writeTest(@RequestParam("category") String category, @RequestParam("context") String context, @RequestParam("title") String title,@RequestParam("dateopen") String dateopen, @RequestParam("dateclose") String dateclose,  @RequestParam("code") String code,@RequestParam("access") String access ) throws Exception {

        TestsEntity ourTest;

        if (code.equals("")) {
            ourTest=new TestsEntity();
            ourTest.setPathtotest(RandomStringUtils.randomAlphabetic(15));
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            ourTest.setIdUsers(userRepository.findUserByEmail(user.getUsername()).getId());
        }
        else
        {
            ourTest=testRepository.getTestByID(new Integer(code));
        }

        ourTest.setTestname(title);

        if (access.equals("all")) {
            ourTest.setFirstpage((byte) 1);
        }
        else
        {
            ourTest.setFirstpage((byte) 0);
        }
        ourTest.setIdCategory(new Integer(treeBean.returnCode(category)));

        if (!dateopen.equals(""))
        {ourTest.setDateStart(Date.valueOf(dateopen));}

        if (!dateclose.equals(""))
        {ourTest.setDateFinish(Date.valueOf(dateclose));}


        if (code.equals("")) {
            testRepository.createTest(ourTest);
        }
        else {
            testRepository.updateTest(ourTest);
        }

        ourTest=testRepository.getTestByTitle(ourTest.getTestname());

        StringBuilder json=new StringBuilder(100);
        json.append("{\"code\":\"");
        json.append(ourTest.getId());
        json.append("\",\"href\":\"");
        if (!context.equals(""))
        {
            json.append(context);
        }

        json.append("/open/");
        json.append(ourTest.getPathtotest());
        json.append("\",\"author\":\"");
        json.append(ourTest.getUsersById().getName());
        json.append(" ");
        json.append(ourTest.getUsersById().getSurname());
        json.append("\"}");

        return json.toString();
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addtest", method = RequestMethod.POST)
    public String addtest(@RequestParam("categoryfortest")  String category, Model model) {
        model.addAttribute("categoryfortest",category);
        model.addAttribute("tree", treeBean.createTree());
        return "addtest";
    }

}
