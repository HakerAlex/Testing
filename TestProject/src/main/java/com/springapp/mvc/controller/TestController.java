package com.springapp.mvc.controller;

import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.domain.TestsEntity;
import com.springapp.mvc.repository.TestcategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getparenttest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String addParentTest(@RequestParam("category") String namecategory)
    {
        TestcategoriesEntity ourCategory=testcategoryRepository.getCategoryByID(new Integer(returnCode(namecategory)));
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
    @RequestMapping(value = "/getpicture", method = RequestMethod.POST)
    @ResponseBody
    public String addPictureTest(@RequestParam("category") String namecategory)
    {
        TestcategoriesEntity ourCategory=testcategoryRepository.getCategoryByID(new Integer(returnCode(namecategory)));

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


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/updatecategorytest", method = RequestMethod.POST)
    @ResponseBody
    public String updateCategoryTest(@RequestParam("namecategory") String namecategory, @RequestParam("oldcategory") String oldcategory, @RequestParam("parent") String parent, @RequestParam("description") String description,@RequestParam("picture") String picture)
    {
        TestcategoriesEntity newCategory = testcategoryRepository.getCategoryByID(new Integer(returnCode(oldcategory)));

        newCategory.setCategory(namecategory);

        if (!parent.equals("")) {
            newCategory.setParent(new Integer(returnCode(parent)));
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

        int ourID = new Integer(returnCode(namecategory));

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
}
