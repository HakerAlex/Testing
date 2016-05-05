package com.springapp.mvc.controller;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.repository.CategoryRepository;
import com.springapp.mvc.repository.FirstPageRepository;
import com.springapp.mvc.service.CreateTreeFromQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class CategoryController {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired(required=false)
    private CreateTreeFromQuery treeBean;

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/nodeChildren", method = RequestMethod.GET)
    @ResponseBody
    public String getTree(@RequestParam("id") int id) {
        System.out.print(id);
        return "OK";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addcategory", method = RequestMethod.POST)
    @ResponseBody
    public String addCategory(@RequestParam("namecategory") String namecategory, @RequestParam("parent") String parent) {
        CategoriesEntity newCategory = new CategoriesEntity();
        newCategory.setCategory(namecategory);

        if (parent != "") {
            String ID = parent.substring(5);
            int pos = ID.indexOf(" ");
            String ourID = ID.substring(0, pos);
            newCategory.setParent(new Integer(ourID));
        } else {
            newCategory.setParent(0);
        }

        try {
            categoryRepository.createCategory(newCategory);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return treeBean.createTree();
    }
}
