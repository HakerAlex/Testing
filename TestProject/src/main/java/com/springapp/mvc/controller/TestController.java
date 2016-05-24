package com.springapp.mvc.controller;

import com.springapp.mvc.domain.TestQuestionsEntity;
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
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;

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
    public String addParentTest(@RequestParam("category") int namecategory) {
        TestcategoriesEntity ourCategory = testcategoryRepository.getCategoryByID(namecategory);
        TestcategoriesEntity ourCategoryParent = testcategoryRepository.getCategoryByID(ourCategory.getParent());
        StringBuilder ourBuffer = new StringBuilder(10);
        StringBuilder ourBufferCode = new StringBuilder(10);

        if (ourCategoryParent!=null){
            ourBuffer.append(ourCategoryParent.getCategory());
            ourBufferCode.append(ourCategoryParent.getId());
        }
        StringBuilder json = new StringBuilder(100);
        json.append("{\"parent\":\"");
        json.append(ourBuffer.toString());
        json.append("\",\"desc\":\"");
        json.append(ourCategory.getDescription());
        json.append("\",\"parentid\":\"");
        json.append( ourBufferCode.toString());
        json.append("\"}");
        return json.toString();
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/gettest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String getTests(@RequestParam("category") int category, @RequestParam("context") String context) {
        return treeTestBean.getTestByCategory(category, context);
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getpicture", method = RequestMethod.POST)
    @ResponseBody
    public String addPictureTest(@RequestParam("category") int namecategory) {
        TestcategoriesEntity ourCategory = testcategoryRepository.getCategoryByID(namecategory);

        return ourCategory.getPicture();
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addcategorytest", method = RequestMethod.POST)
    @ResponseBody
    public String addCategoryTest(@RequestParam("namecategory") String namecategory, @RequestParam("parent") String parent, @RequestParam("description") String description, @RequestParam("picture") String picture) {
        TestcategoriesEntity newCategory = new TestcategoriesEntity();
        newCategory.setCategory(namecategory);

        if (!parent.equals("")) {
            newCategory.setParent(new Integer(parent));
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
    public String updateCategoryTest(@RequestParam("namecategory") String namecategory, @RequestParam("oldcategory") String oldcategory, @RequestParam("parent") String parent, @RequestParam("description") String description, @RequestParam("picture") String picture) {
        TestcategoriesEntity newCategory = testcategoryRepository.getCategoryByID(new Integer(oldcategory));

        newCategory.setCategory(namecategory);

        if (!parent.equals("")) {
            newCategory.setParent(new Integer(parent));
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

        int ourID = new Integer(namecategory);

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
    public String writeTest(@RequestParam("category") String category, @RequestParam("context") String context, @RequestParam("title") String title, @RequestParam("dateopen") String dateopen, @RequestParam("dateclose") String dateclose, @RequestParam("code") String code, @RequestParam("access") String access) throws Exception {

        TestsEntity ourTest;

        if (code.equals("")) {
            ourTest = new TestsEntity();
            ourTest.setPathtotest(RandomStringUtils.randomAlphabetic(15));
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            ourTest.setIdUsers(userRepository.findUserByEmail(user.getUsername()).getId());
        } else {
            ourTest = testRepository.getTestByID(new Integer(code));
        }

        ourTest.setTestname(title);

        if (access.equals("all")) {
            ourTest.setFirstpage((byte) 1);
        } else {
            ourTest.setFirstpage((byte) 0);
        }
        ourTest.setIdCategory(new Integer(category));

        if (!dateopen.equals("")) {
            ourTest.setDateStart(Date.valueOf(dateopen));
        }

        if (!dateclose.equals("")) {
            ourTest.setDateFinish(Date.valueOf(dateclose));
        }


        if (code.equals("")) {
            testRepository.createTest(ourTest);
        } else {
            testRepository.updateTest(ourTest);
        }

        ourTest = testRepository.getTestByTitle(ourTest.getTestname());

        StringBuilder json = new StringBuilder(100);
        json.append("{\"code\":\"");
        json.append(ourTest.getId());
        json.append("\",\"href\":\"");
        json.append(ourTest.getPathtotest());
        json.append("\",\"author\":\"");
        json.append(ourTest.getUsersById().getName());
        json.append(" ");
        json.append(ourTest.getUsersById().getSurname());
        json.append("\"}");

        return json.toString();
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addquestionfortest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String addQuestionToTest(@RequestParam("idtest") int idtest, @RequestParam("idquestion") int idquestion) throws Exception {

        if (!testRepository.checkQuestionInTheTest(idtest, idquestion)) {
            return "Вопрос уже добавлен!";
        }

        TestQuestionsEntity ourQuestion = new TestQuestionsEntity();

        ourQuestion.setIdQuestion(idquestion);
        ourQuestion.setIdTest(idtest);

        testRepository.addQuestionToTest(ourQuestion);

        return treeTestBean.getQuestionsByTestID(idtest);
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/deltest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String delTest(@RequestParam("id") int idtest, @RequestParam("context") String context, @RequestParam("category") int category) throws Exception {

        if (context.equals("empty")) {
            context = "";
        }


        if (testRepository.getFormsWrite(idtest).size() > 0) {
            return "error";
        }

        try {
            testRepository.deleteQuestionFromTest(idtest);
            testRepository.deleteTest(testRepository.getTestByID(idtest));
        } catch (Exception e) {
            return "error";
        }
        return treeTestBean.getTestByCategory(category, context);
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/copytest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String copyTest(@RequestParam("id") int idtest, @RequestParam("context") String context, @RequestParam("category") int category) throws Exception {

        if (context.equals("empty")) {
            context = "";
        }

        TestsEntity ourTest = testRepository.getTestByID(idtest);
        TestsEntity newTest = new TestsEntity();

        newTest.setIdCategory(ourTest.getIdCategory());
        newTest.setDateStart(ourTest.getDateStart());
        newTest.setDateFinish(ourTest.getDateFinish());
        newTest.setFirstpage(ourTest.getFirstpage());
        newTest.setPathtotest(RandomStringUtils.randomAlphabetic(15));
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        newTest.setIdUsers(userRepository.findUserByEmail(user.getUsername()).getId());
        newTest.setTestname("(Копия)" + ourTest.getTestname());
        testRepository.createTest(newTest);
        newTest=testRepository.getTestByTitle(newTest.getTestname());

        List<TestQuestionsEntity> listQuestion =testRepository.getQuestionByTestID(idtest);

        for (TestQuestionsEntity ourElement : listQuestion) {
            TestQuestionsEntity newQuestion=new TestQuestionsEntity();
            newQuestion.setIdTest(newTest.getId());
            newQuestion.setIdQuestion(ourElement.getIdQuestion());
            testRepository.addQuestionToTest(newQuestion);
        }

        return treeTestBean.getTestByCategory(category, context);
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/delquestionfromtest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String delQuestionFromTest(@RequestParam("idtest") int idtest, @RequestParam("idquestion") int idquestion) throws Exception {

        try {
            testRepository.deleteQuestionFromTest(testRepository.getQuestionRow(idquestion));
        } catch (Exception e) {
            return "error";
        }

        return treeTestBean.getQuestionsByTestID(idtest);
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addtest", method = RequestMethod.POST)
    public String addtest(@RequestParam("categoryfortest") String category, @RequestParam("categoryfortestid") String categoryid,Model model) {
        model.addAttribute("categoryfortest", category);
        model.addAttribute("categoryfortestid", categoryid);
        model.addAttribute("tree", treeBean.createTree());
        model.addAttribute("type", 1);
        model.addAttribute("table", treeTestBean.getQuestionsByTestID(0));
        return "addtest";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/edittest/{id}", method = RequestMethod.GET)
    public String editTest(@PathVariable int id, Model model) {
        TestsEntity ourTest = testRepository.getTestByID(id);

        StringBuilder author = new StringBuilder(20);
        author.append(ourTest.getUsersById().getName());
        author.append(" ");
        author.append(ourTest.getUsersById().getSurname());

        model.addAttribute("categoryfortest", ourTest.getCategoryById().getCategory());
        model.addAttribute("categoryfortestid", ourTest.getCategoryById().getId());
        model.addAttribute("tree", treeBean.createTree());
        model.addAttribute("code", ourTest.getId());
        model.addAttribute("href", ourTest.getPathtotest());
        model.addAttribute("author", author.toString());
        model.addAttribute("title", ourTest.getTestname());
        model.addAttribute("dateopen", ourTest.getDateStart());
        model.addAttribute("dateclose", ourTest.getDateFinish());
        model.addAttribute("type", ourTest.getFirstpage());
        model.addAttribute("table", treeTestBean.getQuestionsByTestID(id));
        return "addtest";
    }

}
