package com.springapp.mvc.controller;

import com.springapp.mvc.domain.*;
import com.springapp.mvc.repository.QuestionRepository;
import com.springapp.mvc.repository.TestcategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class TestController {

    @Autowired
    private TestcategoryRepository testcategoryRepository;

    private String returnCode(String parent) {
        String ID = parent.substring(5);
        int pos = ID.indexOf(" ");
        return ID.substring(0, pos);
    }

    public String stripTags(String xmlStr){
        xmlStr = xmlStr.replaceAll("<(.)+?>", "");
        xmlStr = xmlStr.replaceAll("<(\n)+?>", "");
        return xmlStr;
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addcategorytest", method = RequestMethod.POST)
    @ResponseBody
    public String addCategoryTest(@RequestParam("namecategory") String namecategory, @RequestParam("parent") String parent, @RequestParam("description") String description,@RequestParam("picture") String picture)
    {
        TestcategoriesEntity newCategory = new TestcategoriesEntity();
        newCategory.setCategory(namecategory);

        if (!parent.equals("")) {
            newCategory.setParent(new Integer(returnCode(parent)));
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

}
