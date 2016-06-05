package com.springapp.mvc.controller;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import com.springapp.mvc.repository.CategoryRepository;
import com.springapp.mvc.repository.QuestionRepository;
import com.springapp.mvc.service.CreateTreeFromQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.List;

@Controller
public class CategoryController {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired(required = false)
    private CreateTreeFromQuery treeBean;

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/updatetree", method = RequestMethod.GET)
    @ResponseBody
    public String getTree() {
        return treeBean.createTree();
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/delcategory", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String delCategory(@RequestParam("namecategory") String namecategory) throws Exception {

        int ourID = new Integer(namecategory);
        List<CategoriesEntity> list = categoryRepository.getCategoriesByParentID(ourID);
        if (!list.isEmpty()) {
            return "Не могу удалить есть подчиненные элементы";
        }
        List<QuestionsEntity> listQ = categoryRepository.getAllQuestionByCategoryID(ourID);
        if (!listQ.isEmpty()) {
            return "Не могу удалить есть связанные вопросы";
        }
        categoryRepository.deleteCategory(categoryRepository.getCategoriesByID(ourID));

        return "";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getparent", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String getParent(@RequestParam("category") String namecategory) {
        Integer parentID = categoryRepository.getCategoriesByID(new Integer(namecategory)).getParent();
        CategoriesEntity ourCategory = categoryRepository.getCategoriesByID(parentID);

        StringBuilder json = new StringBuilder(100);
        json.append("{\"code\":\"");
        json.append(ourCategory.getId());
        json.append("\",\"parent\":\"");
        json.append(ourCategory.getCategory());
        json.append("\"}");
        return json.toString();
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addcategory", method = RequestMethod.POST)
    @ResponseBody
    public String addCategory(@RequestParam("namecategory") String namecategory, @RequestParam("parent") String parent) {
        CategoriesEntity newCategory = new CategoriesEntity();
        newCategory.setCategory(namecategory);

        if (!parent.equals("")) {
            newCategory.setParent(new Integer(parent));
        } else {
            newCategory.setParent(0);
        }

        try {
            categoryRepository.createCategory(newCategory);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addquestion", method = RequestMethod.POST)
    public String addQuestion(@RequestParam("categoryforquestion") String category, @RequestParam("categoryforquestionid") String categoryid, Model model) {
        model.addAttribute("category", category);
        model.addAttribute("categoryid", categoryid);
        model.addAttribute("code", "");
        model.addAttribute("questiontext", "");
        model.addAttribute("questiontype", 1);
        model.addAttribute("tree",treeBean.createTree());
        return "addquestion";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/updatecategory", method = RequestMethod.POST)
    @ResponseBody
    public String updateCategory(@RequestParam("oldcategory") String oldcategory, @RequestParam("namecategory") String category, @RequestParam("parent") String parent) {
        CategoriesEntity ourCategory = categoryRepository.getCategoriesByID(new Integer(oldcategory));
        ourCategory.setCategory(category);

        if (!parent.equals("")) {
            ourCategory.setParent(new Integer(parent));
        } else {
            ourCategory.setParent(0);
        }

        try {
            categoryRepository.updateCategory(ourCategory);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }



    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getquestion", method = RequestMethod.POST, produces = {"text/html; charset=UTF-8"})
    @ResponseBody
    public String getQuestions(@RequestParam("category") String category, @RequestParam("context") String context) {
        return treeBean.getInputQuestion(category, context);
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getquestionfortest", method = RequestMethod.POST, produces = {"text/html; charset=UTF-8"})
    @ResponseBody
    public String getQuestionsForTest(@RequestParam("category") String category, @RequestParam("context") String context) {
        return treeBean.getInputQuestionForTest(category, context);
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/delquestion", method = RequestMethod.POST, produces = {"text/html; charset=UTF-8"})
    @ResponseBody
    public String delQuestions(@RequestParam("id") int question, @RequestParam("context") String context, @RequestParam("category") String category) {
        BigDecimal getChildElement = questionRepository.getChildRecordCount(question);
        if (getChildElement.intValue() == 0) {
            QuestionsEntity ques = questionRepository.getQuestionByID(question);
            try {
                questionRepository.deleteAnswersByQuestion(question);
                questionRepository.deleteQuestion(ques);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return treeBean.getInputQuestion(category, context);
        }
        return "error";
    }



    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getcheckcategorytest", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String getCheckCategory(@RequestParam("categorycheck") String check, @RequestParam("ourcategory") int ourcategory) {

        String ourCheckString=treeBean.findChildNode(ourcategory);
        if (ourCheckString.indexOf("-"+check+"-")>-1){
            return "error";
        }
    return "ok";
    }




}
