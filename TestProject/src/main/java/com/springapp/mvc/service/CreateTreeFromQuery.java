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
        String element="";
        element=element.concat("{text: Код:"+ourElement.getId()+" ");
        element=element.concat("Наименование:"+ourElement.getCategory());
        element=element.concat(",icon: \"glyphicon glyphicon-folder-open\"");
        element=element.concat(",selectable: true");
        element=element.concat(",nodes: [");
        return element;
    }


    @Transactional(readOnly = true)
    public String createTree(){
        List<CategoriesEntity> ourList1=this.categoryRepository.getCategoriesByParentID(0);

        String ourTree="[";

       for (CategoriesEntity ourElement1:ourList1) {
           ourTree=ourTree.concat(getElementTree(ourElement1));
           List<CategoriesEntity> ourList2=this.categoryRepository.getCategoriesByParentID(ourElement1.getId());
           for (CategoriesEntity ourElement2:ourList2) {
               ourTree=ourTree.concat(getElementTree(ourElement2));
               List<CategoriesEntity> ourList3=this.categoryRepository.getCategoriesByParentID(ourElement2.getId());
               for (CategoriesEntity ourElement3:ourList3) {
                   ourTree=ourTree.concat(getElementTree(ourElement3));
                   List<CategoriesEntity> ourList4=this.categoryRepository.getCategoriesByParentID(ourElement3.getId());
                   for (CategoriesEntity ourElement4:ourList4) {
                       ourTree=ourTree.concat(getElementTree(ourElement4));
                       List<CategoriesEntity> ourList5=this.categoryRepository.getCategoriesByParentID(ourElement4.getId());
                       for (CategoriesEntity ourElement5:ourList5) {
                           ourTree= ourTree.concat(getElementTree(ourElement5));
                       }
                       ourTree=ourTree.concat("]},");
                   }
                   ourTree=ourTree.concat("]},");
               }
               ourTree=ourTree.concat("]},");
           }
           ourTree=ourTree.concat("]},");
        }
        ourTree=ourTree.concat("]");
        System.out.print(ourTree);
        return ourTree;
    }

}
