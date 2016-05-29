package com.springapp.mvc.repository;

import com.springapp.mvc.domain.TestcategoriesEntity;
import com.springapp.mvc.domain.TestsEntity;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class TestcategoryRepository {

    @Autowired
    private SessionFactory session;

    public List<TestcategoriesEntity> getCategoriesByParentID(int id) {
        return session.getCurrentSession().createSQLQuery("Select * from testcategories where parent=:id").addEntity(TestcategoriesEntity.class).setInteger("id", id).list();
    }

    public TestcategoriesEntity getCategoryByID(int id) {
        return (TestcategoriesEntity) session.getCurrentSession().createSQLQuery("Select * from testcategories where ID=:id").addEntity(TestcategoriesEntity.class).setInteger("id", id).uniqueResult();
    }

    public List<TestsEntity> getAllTestByCategoryID(int idCategory) {
        return session.getCurrentSession().createSQLQuery("Select * from tests where ID_category=:idcategory").addEntity(TestsEntity.class).setInteger("idcategory", idCategory).list();
    }

    public List<TestsEntity> getAllTestByCategoryIDFirstPage(int idCategory) {
        return session.getCurrentSession().createSQLQuery("Select * from tests where firstpage=1 and ID_category=:idcategory").addEntity(TestsEntity.class).setInteger("idcategory", idCategory).list();
    }

    public List<TestcategoriesEntity> getAllCategories() {
        return session.getCurrentSession().createSQLQuery("Select * from testcategories").addEntity(TestcategoriesEntity.class).list();
    }

    public void createCategory(TestcategoriesEntity category) throws Exception {
        try {
            session.getCurrentSession().save(category);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать категорию " + category.getCategory(), e);
        }

    }

    public void deleteCategory(TestcategoriesEntity category) throws Exception {
        try {
            session.getCurrentSession().delete(category);
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить категорию " + category.getCategory(), e);
        }

    }

    public void updateCategory(TestcategoriesEntity category) throws Exception {
        try {
            session.getCurrentSession().update(category);
        } catch (HibernateException e) {
            throw new Exception("Невозможно обновить категорию " + category.getCategory(), e);
        }

    }


}
