package com.springapp.mvc.service;

import com.springapp.mvc.domain.TestQuestionsEntity;
import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.domain.TestsEntity;
import com.springapp.mvc.repository.TestRepository;
import com.springapp.mvc.repository.TestcategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service("treeCreateTest")
public class CreateTreeFromQueryTest {

    @Autowired
    private TestcategoryRepository testcategoryRepository;

    @Autowired
    private TestRepository testRepository;

    private StringBuilder getElementTree(TestcategoriesEntity ourElement, StringBuilder element) {
        element.append("{text:  \"");
        element.append(ourElement.getCategory());
        element.append("\",href:\"");
        element.append(ourElement.getId());
        element.append("\",icon: \"glyphicon glyphicon-folder-close\"");
        element.append(",selectedIcon: \"glyphicon glyphicon-folder-open\"");
        element.append(",selectable: true");
        element.append(",nodes: [");
        return element;
    }

    @Transactional(readOnly = true)
    private StringBuilder recursionTrees(TestcategoriesEntity ourElement, StringBuilder ourTree) {
        List<TestcategoriesEntity> ourList = testcategoryRepository.getCategoriesByParentID(ourElement.getId());
        for (TestcategoriesEntity ourElement1 : ourList) {
            recursionTrees(ourElement1, getElementTree(ourElement1, ourTree)).append("]},");
        }
        return ourTree;
    }

    @Transactional(readOnly = true)
    public String createTree(int category) {
        List<TestcategoriesEntity> ourList1 = new ArrayList<>();
        if (category == 0) {
            ourList1 = testcategoryRepository.getCategoriesByParentID(0);
        } else {
            ourList1.add(testcategoryRepository.getCategoryByID(category));
        }


        StringBuilder ourTree = new StringBuilder(200);
        ourTree.append("[");

        for (TestcategoriesEntity ourElement1 : ourList1) {
            recursionTrees(ourElement1, getElementTree(ourElement1, ourTree)).append("]},");
        }
        ourTree.append("]");
        String replace = "nodes: \\[\\]";
        return ourTree.toString().replaceAll(replace, "");
    }

    @Transactional(readOnly = true)
    public String getTestByCategory(int category, String context) {
        List<TestsEntity> ourQuestion = testcategoryRepository.getAllTestByCategoryID(category);
        StringBuilder ourTable = new StringBuilder(200);

        ourTable.append(" <thead> ");
        ourTable.append("<tr> ");
        ourTable.append("<th>Тест</th> ");
        ourTable.append("<th>Редактировать</th> ");
        ourTable.append("<th>Скопировать</th> ");
        ourTable.append("<th>Удалить</th> ");
        ourTable.append("</tr> ");
        ourTable.append("</thead> ");


        ourTable.append("<tbody> ");
        for (TestsEntity ourElement : ourQuestion) {
            ourTable.append(" <tr> ");

            ourTable.append(" <td>");
            ourTable.append(ourElement.getTestname());
            ourTable.append(" </td> ");


            ourTable.append(" <td>");
            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append(context);
            ourTable.append("/edittest/");
            ourTable.append(ourElement.getId());
            ourTable.append("\"");
            ourTable.append(" class=\"label btn-info\"> <i class=\"fa fa-pencil\">Редактировать</i> </a>");
            ourTable.append(" </span>");
            ourTable.append(" </td>");

            ourTable.append(" <td>");
            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append("javascript:funcopytest(");
            ourTable.append(ourElement.getId());
            ourTable.append(")\"");
            ourTable.append(" class=\"label btn-primary\"> <i class=\"fa fa-pencil\">Скопировать</i></a>");
            ourTable.append(" </span>");
            ourTable.append(" </td>");


            ourTable.append(" <td>");
            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append("javascript:fundeltest(");
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
    public String getQuestionsByTestID(int id) {
        List<TestQuestionsEntity> ourQuestions = testRepository.getQuestionByTestID(id);
        StringBuilder ourTable = new StringBuilder(200);

        ourTable.append(" <thead> ");
        ourTable.append("<tr> ");
        ourTable.append("<th>Вопрос</th> ");
        ourTable.append("<th>Удалить</th> ");
        ourTable.append("</tr> ");
        ourTable.append("</thead> ");


        ourTable.append("<tbody> ");
        for (TestQuestionsEntity ourElement : ourQuestions) {
            ourTable.append(" <tr> ");

            ourTable.append(" <td>");
            ourTable.append(ourElement.getQuestionsEntity().getQuestion());
            ourTable.append(" </td> ");

            ourTable.append(" <td>");
            ourTable.append(" <span class=\"tooltip-area\">");
            ourTable.append(" <a href=\"");
            ourTable.append("javascript:fundeltest(");
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
    public String createList(int categoryID){
        List<TestsEntity> listTest=testcategoryRepository.getAllTestByCategoryIDFirstPage(categoryID);
        StringBuilder ourBuffer=new StringBuilder(100);

        for (TestsEntity ourElement: listTest){
            ourBuffer.append("<a href=\"javascript:opentest('");
            ourBuffer.append(ourElement.getPathtotest());
            ourBuffer.append("')\" class=\"list-group-item\" style=\"text-align: left\">");
            ourBuffer.append("<span class=\"glyphicon glyphicon-star\"></span>");
            ourBuffer.append(ourElement.getTestname());
            ourBuffer.append("</a>");
        }

        return ourBuffer.toString();
    }


    @Transactional(readOnly = true)
    private StringBuilder recursionFind(TestcategoriesEntity ourElement, StringBuilder ourTree) {
        List<TestcategoriesEntity> ourList = testcategoryRepository.getCategoriesByParentID(ourElement.getId());
        for (TestcategoriesEntity ourElement1 : ourList) {
            ourTree.append("-");
            ourTree.append(ourElement1.getId());
            recursionFind(ourElement1, ourTree);
        }
        return ourTree;
    }

    @Transactional(readOnly = true)
    public String findChildNode(int idCategory){
        TestcategoriesEntity ourElement = testcategoryRepository.getCategoryByID(idCategory);

        StringBuilder ourTree = new StringBuilder(200);
        ourTree.append("-");
        ourTree.append(ourElement.getId());
        recursionFind(ourElement, ourTree);
        ourTree.append("-");
        return ourTree.toString();
    }

}

