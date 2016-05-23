package com.springapp.mvc.controller;

import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.repository.FirstPageRepository;
import com.springapp.mvc.repository.TestcategoryRepository;
import com.springapp.mvc.service.CreateTreeFromQuery;
import com.springapp.mvc.service.CreateTreeFromQueryTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class FirstpageController {

    @Autowired
    private FirstPageRepository firstPageRepository;

    @Autowired(required = false)
    private CreateTreeFromQuery treeBean;

    @Autowired
    private TestcategoryRepository testcategoryRepository;


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

        return "categorylist";
    }

}
