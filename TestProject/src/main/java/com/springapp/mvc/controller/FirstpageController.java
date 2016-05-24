package com.springapp.mvc.controller;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.domain.TestsEntity;
import com.springapp.mvc.repository.FirstPageRepository;
import com.springapp.mvc.repository.TestRepository;
import com.springapp.mvc.repository.TestcategoryRepository;
import com.springapp.mvc.service.CreateTreeFromQuery;
import com.springapp.mvc.service.CreateTreeFromQueryTest;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Controller
public class FirstpageController {

    @Autowired
    private FirstPageRepository firstPageRepository;

    @Autowired(required = false)
    private CreateTreeFromQuery treeBean;

    @Autowired
    private TestcategoryRepository testcategoryRepository;


    @Autowired
    private TestRepository testRepository;

    @Autowired(required = false)
    private CreateTreeFromQueryTest treeTestBean;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String getBasic(Model model) {
        String countTest = firstPageRepository.testQuantity();
        List<TestcategoriesEntity> listCategories = firstPageRepository.listCategoriesByParentID(0);
        model.addAttribute("count", countTest);
        model.addAttribute("allcategories", listCategories);
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
    public String openCategory(@PathVariable int id,  Model model) {

        TestcategoriesEntity ourCategory=testcategoryRepository.getCategoryByID(id);
        model.addAttribute("picture",ourCategory.getPicture());
        model.addAttribute("category",ourCategory.getCategory());
        model.addAttribute("description",ourCategory.getDescription());
        model.addAttribute("tree",treeTestBean.createTree(ourCategory.getId()));
        model.addAttribute("list",treeTestBean.createList(ourCategory.getId()));
        return "categorylist";
    }

    @RequestMapping(value = "/getlisttest", method = RequestMethod.POST, produces = {"text/html; charset=UTF-8"})
    @ResponseBody
    public String getParent(@RequestParam("category") int category) {
        return treeTestBean.createList(category);
    }


    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/opentest", method = RequestMethod.POST)
    public String openTest(@RequestParam("testnumber") String testnumber, Model model) {
        TestsEntity ourTest=testRepository.getTestByPath(testnumber);

        Date ourCurrentDate=new Date(System.currentTimeMillis());


        int flag=0;

        Date dateStart=ourTest.getDateStart();
        Date dateFinish=ourTest.getDateFinish();

        if (dateStart==null) {
            dateStart=new Date();
        }

        if (dateFinish==null) {
            dateFinish=new Date();
        }

        if (ourCurrentDate.before(dateStart)) {
            model.addAttribute("flag","before");
            flag=1;
        }

        if (ourCurrentDate.after(dateFinish)) {
            model.addAttribute("flag","after");
            flag=1;
        }


        if (flag==0) //all OK
        {


        }


        return "testpage";
    }


}
