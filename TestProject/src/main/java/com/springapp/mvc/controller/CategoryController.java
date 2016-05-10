package com.springapp.mvc.controller;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import com.springapp.mvc.repository.CategoryRepository;
import com.springapp.mvc.service.CreateTreeFromQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class CategoryController {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired(required = false)
    private CreateTreeFromQuery treeBean;


    String returnCode(String parent) {
        String ID = parent.substring(5);
        int pos = ID.indexOf(" ");
        return ID.substring(0, pos);
    }


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

        int ourID=new Integer(returnCode(namecategory));
        List<CategoriesEntity> list =categoryRepository.getCategoriesByParentID(ourID);
        if (!list.isEmpty()) {
            return "Не могу удалить есть подчиненные элементы";
        }
        List<QuestionsEntity> listQ =categoryRepository.getAllQuestionByCategoryID(ourID);
        if (!listQ.isEmpty()) {
            return "Не могу удалить есть связанные вопросы";
        }
        categoryRepository.deleteCategory( categoryRepository.getCategoriesByID(ourID));

        return "";
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/getparent", method = RequestMethod.POST, produces = {"text/plain; charset=UTF-8"})
    @ResponseBody
    public String getParent(@RequestParam("category") String namecategory) {
        Integer parentID = categoryRepository.getCategoriesByID(new Integer(returnCode(namecategory))).getParent();
        CategoriesEntity ourCategory = categoryRepository.getCategoriesByID(parentID);
        StringBuilder ourBuffer = new StringBuilder(100);
        ourBuffer.append(" Код:");
        ourBuffer.append(ourCategory.getId());
        ourBuffer.append(" ");
        ourBuffer.append(ourCategory.getCategory());
        return ourBuffer.toString();
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/addcategory", method = RequestMethod.POST)
    @ResponseBody
    public String addCategory(@RequestParam("namecategory") String namecategory, @RequestParam("parent") String parent) {
        CategoriesEntity newCategory = new CategoriesEntity();
        newCategory.setCategory(namecategory);

        if (parent != "") {
            newCategory.setParent(new Integer(returnCode(parent)));
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
    public String addQuestion(@RequestParam("categoryforquestion") String category, Model model) {
        model.addAttribute("category",category);
        model.addAttribute("code","");
        model.addAttribute("questiontext","");
        model.addAttribute("questiontype",1);
        return "addquestion";
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/updatecategory", method = RequestMethod.POST)
    @ResponseBody
    public String updateCategory(@RequestParam("oldcategory") String oldcategory, @RequestParam("namecategory") String category, @RequestParam("parent") String parent) {
        CategoriesEntity ourCategory = categoryRepository.getCategoriesByID(new Integer(returnCode(oldcategory)));
        ourCategory.setCategory(category);

        if (parent != "") {
            ourCategory.setParent(new Integer(returnCode(parent)));
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
    public String getQuestions(@RequestParam("category") String category,@RequestParam("context") String context) {
        List<QuestionsEntity> ourQuestion = categoryRepository.getAllQuestionByCategoryID(new Integer(returnCode(category)));
        StringBuilder ourTable = new StringBuilder(200);

        ourTable.append(" <thead> ");
        ourTable.append("<tr> ");
        ourTable.append("<th>Код</th> ");
        ourTable.append("<th>Вопрос</th> ");
        ourTable.append("<th>Тип вопроса</th> ");
        ourTable.append("<th>Редактировать</th> ");
        ourTable.append("<th>Добавить ответ</th> ");
        ourTable.append("<th>Удалить</th> ");
        ourTable.append("</tr> ");
        ourTable.append("</thead> ");


        ourTable.append("<tbody> ");
        for (QuestionsEntity ourElement : ourQuestion) {
            ourTable.append(" <tr> ");
            ourTable.append(" <td> ");
            ourTable.append(ourElement.getId());
            ourTable.append(" </td> ");

            ourTable.append(" <td>");
            ourTable.append(ourElement.getQuestion());
            ourTable.append(" </td> ");

            ourTable.append(" <td> ");
            ourTable.append(" <span class=\"label bg-success\" style=\"background: #00cc00\"> ");
            if (ourElement.getTypeQuestion() == 1) {
                ourTable.append("Один");
            } else if (ourElement.getTypeQuestion() == 2) {
                ourTable.append("Несколько");
            } else if (ourElement.getTypeQuestion() == 3) {
                ourTable.append("Поле ввода");
            }
            ourTable.append(" </span>");
            ourTable.append(" </td>");

            ourTable.append(" <td>");

            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append(context);
            ourTable.append("/editquestion/");
            ourTable.append(ourElement.getId());
            ourTable.append("\"");

            ourTable.append(" class=\"label btn-info\"> <i class=\"fa fa-pencil\">Редактировать</i> </a>");
            ourTable.append(" </span>");
            ourTable.append(" </td>");
            ourTable.append(" <td>");
            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append(context);
            ourTable.append("/addanswer/");
            ourTable.append(ourElement.getId());
            ourTable.append("\"");
            ourTable.append(" class=\"label btn-primary\"> <i class=\"fa fa-leaf\">Добавить ответ</i></a>");
            ourTable.append(" </span>");
            ourTable.append(" </td>");


            ourTable.append(" <td>");
            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append(context);
            ourTable.append("/delquestion/");
            ourTable.append(ourElement.getId());
            ourTable.append("\"");
            ourTable.append(" class=\"label btn-danger\"> <i class=\"fa fa-trash\">Удалить</i></a>");
            ourTable.append(" </span>");
            ourTable.append(" </td>");

            ourTable.append(" </tr>");

        }
        ourTable.append(" </tbody>");

        return ourTable.toString();
    }


}
