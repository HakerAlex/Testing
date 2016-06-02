package com.springapp.mvc.service;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import com.springapp.mvc.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("treeCreate")
public class CreateTreeFromQuery {

    @Autowired
    private CategoryRepository categoryRepository;


    private StringBuilder getElementTree(CategoriesEntity ourElement, StringBuilder element) {
        element.append("{text:  \"");
        element.append(ourElement.getCategory());
        element.append("\",");
        element.append("href: \"");
        element.append(ourElement.getId());
        element.append("\"");
        element.append(",icon: \"glyphicon glyphicon-folder-close\"");
        element.append(",selectedIcon: \"glyphicon glyphicon-folder-open\"");
        element.append(",selectable: true");
        element.append(",nodes: [");
        return element;
    }

    @Transactional(readOnly = true)
    private StringBuilder recursionTrees(CategoriesEntity ourElement, StringBuilder ourTree) {
        List<CategoriesEntity> ourList = categoryRepository.getCategoriesByParentID(ourElement.getId());
        for (CategoriesEntity ourElement1 : ourList) {
            recursionTrees(ourElement1, getElementTree(ourElement1, ourTree)).append("]},");
        }
        return ourTree;
    }

    @Transactional(readOnly = true)
    public String createTree() {
        List<CategoriesEntity> ourList1 = categoryRepository.getCategoriesByParentID(0);

        StringBuilder ourTree = new StringBuilder(200);
        ourTree.append("[");

        for (CategoriesEntity ourElement1 : ourList1) {
            recursionTrees(ourElement1, getElementTree(ourElement1, ourTree)).append("]},");
        }
        ourTree.append("]");
        String replace = "nodes: \\[\\]";
        return ourTree.toString().replaceAll(replace, "");
    }


    @Transactional(readOnly = true)
    private StringBuilder recursionFind(CategoriesEntity ourElement, StringBuilder ourTree) {
        List<CategoriesEntity> ourList = categoryRepository.getCategoriesByParentID(ourElement.getId());
        for (CategoriesEntity ourElement1 : ourList) {
            ourTree.append("-");
            ourTree.append(ourElement1.getId());
            recursionFind(ourElement1, ourTree);
        }
        return ourTree;
    }

    @Transactional(readOnly = true)
    public String findChildNode(int idCategory){
        CategoriesEntity ourElement = categoryRepository.getCategoriesByID(idCategory);

        StringBuilder ourTree = new StringBuilder(200);
        ourTree.append("-");
        ourTree.append(ourElement.getId());
        recursionFind(ourElement, ourTree);
        ourTree.append("-");
        return ourTree.toString();
    }


    @Transactional(readOnly = true)
    public String getInputQuestion(String category, String context) {
        List<QuestionsEntity> ourQuestion = categoryRepository.getAllQuestionByCategoryID(new Integer(category));
        StringBuilder ourTable = new StringBuilder(200);

        ourTable.append(" <thead> ");
        ourTable.append("<tr> ");
        ourTable.append("<th>Вопрос</th> ");
        ourTable.append("<th>Тип вопроса</th> ");
        ourTable.append("<th>Редактировать</th> ");
        ourTable.append("<th>Удалить</th> ");
        ourTable.append("</tr> ");
        ourTable.append("</thead> ");


        ourTable.append("<tbody> ");
        for (QuestionsEntity ourElement : ourQuestion) {
            ourTable.append(" <tr> ");

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
            ourTable.append(context);
            ourTable.append("\"");

            ourTable.append(" class=\"label btn-info\"> <i class=\"fa fa-pencil\">Редактировать</i> </a>");
            ourTable.append(" </span>");
            ourTable.append(" </td>");

            ourTable.append(" <td>");
            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append("javascript:fundelquestion(");
            ourTable.append(ourElement.getId());
            ourTable.append(")\"");
            ourTable.append(" class=\"label btn-danger\"> <i class=\"fa fa-trash\">Удалить</i></a>");
            ourTable.append(" </span>");
            ourTable.append(" </td>");

            ourTable.append(" </tr>");

        }
        ourTable.append(" </tbody>");

        return ourTable.toString();

    }


    @Transactional(readOnly = true)
    public String getInputQuestionForTest(String category, String context) {
        List<QuestionsEntity> ourQuestion = categoryRepository.getAllQuestionByCategoryID(new Integer(category));
        StringBuilder ourTable = new StringBuilder(200);

        ourTable.append(" <thead> ");
        ourTable.append("<tr> ");
        ourTable.append("<th>Вопрос</th> ");
        ourTable.append("<th>Добавить</th> ");
        ourTable.append("</tr> ");
        ourTable.append("</thead> ");


        ourTable.append("<tbody> ");
        for (QuestionsEntity ourElement : ourQuestion) {
            ourTable.append(" <tr> ");

            ourTable.append(" <td>");
            ourTable.append(ourElement.getQuestion());
            ourTable.append(" </td> ");

            ourTable.append(" <td>");
            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append("javascript:funaddquestion(");
            ourTable.append(ourElement.getId());
            ourTable.append(")\"");
            ourTable.append(" class=\"label btn-success\"> <i class=\"fa fa-pencil\">Добавить</i></a>");
            ourTable.append(" </span>");
            ourTable.append(" </td>");

            ourTable.append(" </tr>");

        }
        ourTable.append(" </tbody>");

        return ourTable.toString();

    }


}

