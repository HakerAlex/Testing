package com.springapp.mvc.repository;

import com.springapp.mvc.domain.TestcategoriesEntity;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class FirstPageRepository {
    @Autowired
    private SessionFactory sessionFactory;

    public String testQuantity() {
        return sessionFactory.getCurrentSession().createSQLQuery("select count(*) as allrecord from tests").uniqueResult().toString();
    }

    public List<TestcategoriesEntity> listCategories() {
        return sessionFactory.getCurrentSession().createSQLQuery("SELECT * FROM testcategories").addEntity(TestcategoriesEntity.class).list();
    }

    public List<TestcategoriesEntity> listCategoriesByParentID(int parentid) {
        return sessionFactory.getCurrentSession().createSQLQuery("SELECT * FROM testcategories WHERE parent=:parentid").addEntity(TestcategoriesEntity.class).setInteger("parentid",parentid).list();
    }

}
