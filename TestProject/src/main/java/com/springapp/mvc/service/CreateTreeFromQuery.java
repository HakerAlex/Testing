package com.springapp.mvc.service;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service("treeCreate")
public class CreateTreeFromQuery {

    @Autowired
    private CategoryRepository categoryRepository;


    private String getElementTree(CategoriesEntity ourElement)
    {
        StringBuilder element=new StringBuilder(200);
        element=element.append("{text:  \" Cod:");
        element=element.append(ourElement.getId());
        element=element.append(" ");
        element=element.append(ourElement.getCategory());
        element=element.append("\"");
        element=element.append(",icon: \"glyphicon glyphicon-folder-close\"");
        element=element.append(",selectedIcon: \"glyphicon glyphicon-folder-open\"");
        element=element.append(",selectable: true");
        element=element.append(",nodes: [");
        return element.toString();
    }


    @Transactional(readOnly = true)
    public String createTree(){
        List<CategoriesEntity> ourList1=categoryRepository.getCategoriesByParentID(0);

        StringBuilder ourTree=new StringBuilder(200);
        ourTree=ourTree.append("[");

       for (CategoriesEntity ourElement1:ourList1) {
           ourTree=ourTree.append(getElementTree(ourElement1));
           List<CategoriesEntity> ourList2=categoryRepository.getCategoriesByParentID(ourElement1.getId());
           for (CategoriesEntity ourElement2:ourList2) {
               ourTree=ourTree.append(getElementTree(ourElement2));
               List<CategoriesEntity> ourList3=categoryRepository.getCategoriesByParentID(ourElement2.getId());
               for (CategoriesEntity ourElement3:ourList3) {
                   ourTree=ourTree.append(getElementTree(ourElement3));
                   List<CategoriesEntity> ourList4=categoryRepository.getCategoriesByParentID(ourElement3.getId());
                   for (CategoriesEntity ourElement4:ourList4) {
                       ourTree=ourTree.append(getElementTree(ourElement4));
                       List<CategoriesEntity> ourList5=categoryRepository.getCategoriesByParentID(ourElement4.getId());
                       for (CategoriesEntity ourElement5:ourList5) {
                           ourTree= ourTree.append(getElementTree(ourElement5));
                       }
                       ourTree=ourTree.append("]},");
                   }
                   ourTree=ourTree.append("]},");
               }
               ourTree=ourTree.append("]},");
           }
           ourTree=ourTree.append("]},");
        }
        ourTree=ourTree.append("]");
        String replace="nodes: \\[\\]";
        String finish=ourTree.toString().replaceAll(replace,"");  //replace for child
        return finish;
    }

}
