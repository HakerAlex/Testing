package com.springapp.mvc.repository;

import com.springapp.mvc.domain.QuestionsEntity;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Repository
@Transactional
public class QuestionRepository {

    @Autowired
    private SessionFactory session;

    public QuestionsEntity getQuestionByID(int id) {
        return (QuestionsEntity) session.getCurrentSession().createSQLQuery("Select * from questions where ID=:id").addEntity(QuestionsEntity.class).setInteger("id", id).uniqueResult();
    }

    public QuestionsEntity getQuestionByText(String question) {
        return (QuestionsEntity) session.getCurrentSession().createSQLQuery("Select * from questions where question=:question").addEntity(QuestionsEntity.class).setString("question", question).uniqueResult();
    }

    public void createQuestion(QuestionsEntity questionsEntity) throws Exception {
        try {
            session.getCurrentSession().save(questionsEntity);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать вопрос ", e);
        }

    }

    public void updateQuestion(QuestionsEntity questionsEntity) throws Exception {
        try {
            session.getCurrentSession().update(questionsEntity);
        } catch (HibernateException e) {
            throw new Exception("Невозможно обновить вопрос ", e);
        }

    }

    public BigDecimal getChildRecordCount(int questionid) {
        return (BigDecimal) session.getCurrentSession().createSQLQuery("SELECT SUM(reccount) as reccount from\n" +
                "  (SELECT count(ID_question) as reccount from answers where ID_question=:id\n" +
                "UNION ALL\n" +
                "   SELECT count(ID_question) from answers_user WHERE ID_question=:id\n" +
                "UNION All\n" +
                "   SELECT count(ID_question) from test_questions WHERE ID_question=:id) as ob").setInteger("id", questionid).uniqueResult();
    }

    public void deleteQuestion(QuestionsEntity questionsEntity) throws Exception {
        try {
            session.getCurrentSession().delete(questionsEntity);
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить вопрос ", e);
        }

    }


}


