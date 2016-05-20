package com.springapp.mvc.service;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.domain.TestsEntity;
import com.springapp.mvc.repository.CategoryRepository;
import com.springapp.mvc.repository.TestcategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("treeCreateTest")
public class CreateTreeFromQueryTest {

    @Autowired
    private TestcategoryRepository testcategoryRepository;

    @Autowired(required = false)
    private CreateTreeFromQuery treeBean;


    private StringBuilder getElementTree(TestcategoriesEntity ourElement, StringBuilder element) {
        element.append("{text:  \" Код:");
        element.append(ourElement.getId());
        element.append(" ");
        element.append(ourElement.getCategory());
        element.append("\"");
        element.append(",icon: \"glyphicon glyphicon-folder-close\"");
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
    public String createTree() {
        List<TestcategoriesEntity> ourList1 = testcategoryRepository.getCategoriesByParentID(0);

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
    public String getTestByCategory(String category, String context) {
        List<TestsEntity> ourQuestion = testcategoryRepository.getAllTestByCategoryID(new Integer(treeBean.returnCode(category)));
        StringBuilder ourTable = new StringBuilder(200);

        ourTable.append(" <thead> ");
        ourTable.append("<tr> ");
        ourTable.append("<th>Тест</th> ");
        ourTable.append("<th>Редактировать</th> ");
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
            ourTable.append("javascript:funedittest(");
            ourTable.append(ourElement.getId());
            ourTable.append(")\"");
            ourTable.append(" class=\"label btn-success\"> <i class=\"fa fa-pencil\">Редактировать</i></a>");
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

}

