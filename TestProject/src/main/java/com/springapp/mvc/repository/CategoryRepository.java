package com.springapp.mvc.repository;

import com.springapp.mvc.domain.CategoriesEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import org.hibernate.HibernateException;
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

    public CategoriesEntity getCategoriesByID(int id) {
        return (CategoriesEntity) session.getCurrentSession().createSQLQuery("Select * from categories where ID=:id").addEntity(CategoriesEntity.class).setInteger("id", id).uniqueResult();
    }


    public List<QuestionsEntity> getAllQuestionByCategoryID(int idCategory) {
        return session.getCurrentSession().createSQLQuery("Select * from questions where category=:idcategory").addEntity(QuestionsEntity.class).setInteger("idcategory", idCategory).list();
    }

    public List<CategoriesEntity> getAllCategories() {
        return session.getCurrentSession().createSQLQuery("Select * from categories").addEntity(CategoriesEntity.class).list();
    }

    public void createCategory(CategoriesEntity category) throws Exception {
        try {
            session.getCurrentSession().save(category);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать категорию " + category.getCategory(), e);
        }

    }

    public void deleteCategory(CategoriesEntity category) throws Exception {
        try {
            session.getCurrentSession().delete(category);
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить категорию " + category.getCategory(), e);
        }

    }

    public void updateCategory(CategoriesEntity category) throws Exception {
        try {
            session.getCurrentSession().update(category);
        } catch (HibernateException e) {
            throw new Exception("Невозможно обновить категорию " + category.getCategory(), e);
        }

    }


}
