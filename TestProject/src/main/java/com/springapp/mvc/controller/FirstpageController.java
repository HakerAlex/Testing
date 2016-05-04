package com.springapp.mvc.controller;

import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.repository.CategoryRepository;
import com.springapp.mvc.repository.FirstPageRepository;
import com.springapp.mvc.service.CreateTreeFromQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class FirstpageController {

    private FirstPageRepository firstPageRepository;

    @Autowired
    public FirstpageController(FirstPageRepository firstPageRepository) {
        this.firstPageRepository = firstPageRepository;
    }

    @Autowired(required=false)
    private CreateTreeFromQuery treeBean;

    public void setTreeBean(CreateTreeFromQuery treeBean) {
        this.treeBean = treeBean;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String getBasic(Model model) {
        Object countTest = this.firstPageRepository.testQuantity();
        List<TestcategoriesEntity> listCategories = this.firstPageRepository.listCategories();
        model.addAttribute("count", countTest);
        model.addAttribute("allcategories", listCategories);
        return "index";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String getRegister(Model model) {
        return "register";
    }

    @RequestMapping(value = "/question", method = RequestMethod.GET)
    public String getQuestion(Model model) {
        model.addAttribute("tree",this.treeBean.createTree());
        return "tablequestions";
    }
}
