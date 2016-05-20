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
public class TestRepository {

    @Autowired
    private SessionFactory session;


    public TestsEntity getTestByID(int id) {
        return (TestsEntity) session.getCurrentSession().createSQLQuery("Select * from tests where ID=:id").addEntity(TestsEntity.class).setInteger("id", id).uniqueResult();
    }

    public TestsEntity getTestByTitle(String title) {
        return (TestsEntity) session.getCurrentSession().createSQLQuery("Select * from tests where testname=:title").addEntity(TestsEntity.class).setString("title", title).uniqueResult();
    }

     public void createTest(TestsEntity test) throws Exception {
        try {
            session.getCurrentSession().save(test);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать тест " + test.getTestname(), e);
        }

    }

    public void deleteTest(TestsEntity test) throws Exception {
        try {
            session.getCurrentSession().delete(test);
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить тест " + test.getTestname(), e);
        }

    }

    public void updateTest(TestsEntity test) throws Exception {
        try {
            session.getCurrentSession().update(test);
        } catch (HibernateException e) {
            throw new Exception("Невозможно обновить тест " + test.getTestname(), e);
        }

    }


}
