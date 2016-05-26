package com.springapp.mvc.repository;

import com.springapp.mvc.domain.*;
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

    public List<TestQuestionsEntity> getQuestionByTestID(int id) {
        return session.getCurrentSession().createSQLQuery("Select * from test_questions WHERE test_questions.ID_test=:id").addEntity(TestQuestionsEntity.class).setInteger("id", id).list();
    }

    public List<QuestionsEntity> getQuestionsByTestPath(String path) {
        return session.getCurrentSession().createSQLQuery("SELECT questions.* FROM testdb.tests left join test_questions on testdb.tests.ID=test_questions.ID_test left join questions on  test_questions.ID_question=questions.ID where testdb.tests.pathtotest=:path").addEntity(QuestionsEntity.class).setString("path", path).list();
    }

    public List<FormsEntity> getFormsWrite(int id) {
        return session.getCurrentSession().createSQLQuery("Select * from forms WHERE ID_test=:idtest").addEntity(FormsEntity.class).setInteger("idtest", id).list();
    }


    public TestsEntity getTestByPath(String path){
        return (TestsEntity) session.getCurrentSession().createSQLQuery("select * from tests WHERE pathtotest=:test").addEntity(TestsEntity.class).setString("test", path).uniqueResult();
    }

    public void createTest(TestsEntity test) throws Exception {
        try {
            session.getCurrentSession().save(test);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать тест " + test.getTestname(), e);
        }

    }

    public boolean checkQuestionInTheTest(int idTest,int idQuestion){
        List<TestQuestionsEntity> ourList=session.getCurrentSession().createSQLQuery("SELECT * from test_questions WHERE ID_test=:idtest and ID_question=:idquestion").addEntity(TestQuestionsEntity.class).setInteger("idtest",idTest).setInteger("idquestion",idQuestion).list();
        if (ourList.size()==0) {return true;}
        return false;
    }

    public void deleteTest(TestsEntity test) throws Exception {
        try {
            session.getCurrentSession().delete(test);
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить тест " + test.getTestname(), e);
        }

    }


    public void deleteQuestionFromTest(int idTest) throws Exception {
        try {
            session.getCurrentSession().createSQLQuery("delete from test_questions WHERE ID_test=:idtest").setInteger("idtest",idTest).executeUpdate();
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить из теста " + idTest, e);
        }

    }

    public TestQuestionsEntity getQuestionRow(int idQuestion) {
        return (TestQuestionsEntity) session.getCurrentSession().createSQLQuery("Select * from test_questions WHERE ID=:idquestion").addEntity(TestQuestionsEntity.class).setInteger("idquestion", idQuestion).uniqueResult();
    }



    public void deleteQuestionFromTest(TestQuestionsEntity question) throws Exception {
        try {
            session.getCurrentSession().delete(question);
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить вопрос " + question.getId(), e);
        }

    }

    public void addQuestionToTest(TestQuestionsEntity questionForTest) throws Exception{
        try {
            session.getCurrentSession().save(questionForTest);
        } catch (HibernateException e) {
            throw new Exception("Невозможно записать вопрос к тесту " + questionForTest.getId(), e);
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
