package com.springapp.mvc.service;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.repository.CategoryRepository;
import javafx.beans.binding.StringBinding;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("treeCreate")
public class CreateTreeFromQuery {

    @Autowired
    private CategoryRepository categoryRepository;


    private StringBuilder getElementTree(CategoriesEntity ourElement,StringBuilder element) {
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
    private StringBuilder recursionTrees(CategoriesEntity ourElement,StringBuilder ourTree){
        List<CategoriesEntity> ourList = categoryRepository.getCategoriesByParentID(ourElement.getId());
        for (CategoriesEntity ourElement1 : ourList) {
            recursionTrees(ourElement1,getElementTree(ourElement1,ourTree)).append("]},");
         }
        return ourTree;
    }

    @Transactional(readOnly = true)
    public String createTree() {
        List<CategoriesEntity> ourList1 = categoryRepository.getCategoriesByParentID(0);

        StringBuilder ourTree = new StringBuilder(200);
        ourTree.append("[");

        for (CategoriesEntity ourElement1 : ourList1) {
           recursionTrees(ourElement1, getElementTree(ourElement1,ourTree)).append("]},");
        }
        ourTree.append("]");
        String replace = "nodes: \\[\\]";
        return ourTree.toString().replaceAll(replace, "");
    }

}

