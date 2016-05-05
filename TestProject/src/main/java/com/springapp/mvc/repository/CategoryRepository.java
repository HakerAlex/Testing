package com.springapp.mvc.repository;

import com.springapp.mvc.domain.CategoriesEntity;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class CategoryRepository {

    @Autowired
    private SessionFactory session;

    public List<CategoriesEntity> getCategoriesByParentID(int id) {
        return session.getCurrentSession().createSQLQuery("Select * from categories where parent=:id").addEntity(CategoriesEntity.class).setInteger("id", id).list();
    }





}
