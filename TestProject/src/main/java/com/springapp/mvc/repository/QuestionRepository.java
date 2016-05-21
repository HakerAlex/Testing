package com.springapp.mvc.repository;

import com.springapp.mvc.domain.AnswersEntity;
import com.springapp.mvc.domain.AnswersUserEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

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

    public AnswersEntity getAnswerByText(String answer) {
        return (AnswersEntity) session.getCurrentSession().createSQLQuery("Select * from answers where answer=:answer").addEntity(AnswersEntity.class).setString("answer", answer).uniqueResult();
    }

    public List<AnswersUserEntity> getAnswerUserByQuestionID(int idquestion) {
        return session.getCurrentSession().createSQLQuery("Select * from answers_user where ID_question=:idquestion").addEntity(AnswersUserEntity.class).setInteger("idquestion", idquestion).list();
    }



    public List<AnswersEntity> getAnswersByQuestion(int question) {
        return session.getCurrentSession().createSQLQuery("Select * from answers where ID_question=:question").addEntity(AnswersEntity.class).setInteger("question", question).list();
    }

    public AnswersEntity getAnswersByID(int answerid) {
        return (AnswersEntity) session.getCurrentSession().createSQLQuery("Select * from answers where id=:answerid").addEntity(AnswersEntity.class).setInteger("answerid", answerid).uniqueResult();
    }

    public void createQuestion(QuestionsEntity questionsEntity) throws Exception {
        try {
            session.getCurrentSession().save(questionsEntity);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать вопрос ", e);
        }

    }

    public void createAnswer(AnswersEntity answersEntity) throws Exception {
        try {
            session.getCurrentSession().save(answersEntity);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать ответ ", e);
        }

    }

    public void updateAnswer(AnswersEntity answersEntity) throws Exception {
        try {
            session.getCurrentSession().update(answersEntity);
        } catch (HibernateException e) {
            throw new Exception("Невозможно обновить ответ ", e);
        }

    }


    public void deleteAnswer(AnswersEntity answersEntity) throws Exception {
        try {
            session.getCurrentSession().delete(answersEntity);
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить ответ ", e);
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
                "  (SELECT count(ID_question) as reccount from answers_user WHERE ID_question=:id\n" +
                "UNION All\n" +
                "   SELECT count(ID_question) from test_questions WHERE ID_question=:id) as ob").setInteger("id", questionid).uniqueResult();
    }


    public void deleteAnswersByQuestion(int idQuestion) throws Exception {
        try {
            session.getCurrentSession().createSQLQuery("delete from answers where ID_question=:idquestion").setInteger("idquestion",idQuestion).executeUpdate();
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить вопрос ", e);
        }

    }

    public void deleteQuestion(QuestionsEntity questionsEntity) throws Exception {
        try {
            session.getCurrentSession().delete(questionsEntity);
        } catch (HibernateException e) {
            throw new Exception("Невозможно удалить вопрос ", e);
        }

    }


}


