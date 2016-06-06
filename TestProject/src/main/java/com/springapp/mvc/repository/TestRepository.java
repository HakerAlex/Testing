package com.springapp.mvc.repository;

import com.springapp.mvc.domain.*;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.List;

@Repository
@Transactional
public class TestRepository {

    @Autowired
    private SessionFactory session;

    public TestsEntity getTestByID(int id) {
        return (TestsEntity) session.getCurrentSession().createSQLQuery("Select * from tests where ID=:id").addEntity(TestsEntity.class).setInteger("id", id).uniqueResult();
    }

    public BigInteger getCountQuestionByTestID(int id) {
        return (BigInteger) session.getCurrentSession().createSQLQuery("SELECT count(*) as quantity FROM test_questions where ID_test=:id").setInteger("id", id).uniqueResult();
    }

    public FormsEntity getFormByID(int id) {
        return (FormsEntity) session.getCurrentSession().createSQLQuery("Select * from forms where ID=:id").addEntity(FormsEntity.class).setInteger("id", id).uniqueResult();
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

    public TestsEntity getTestByPath(String path) {
        return (TestsEntity) session.getCurrentSession().createSQLQuery("select * from tests WHERE pathtotest=:test").addEntity(TestsEntity.class).setString("test", path).uniqueResult();
    }

    public void createTest(TestsEntity test) throws Exception {
        try {
            session.getCurrentSession().save(test);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать тест " + test.getTestname(), e);
        }

    }

    public boolean checkQuestionInTheTest(int idTest, int idQuestion) {
        List<TestQuestionsEntity> ourList = session.getCurrentSession().createSQLQuery("SELECT * from test_questions WHERE ID_test=:idtest and ID_question=:idquestion").addEntity(TestQuestionsEntity.class).setInteger("idtest", idTest).setInteger("idquestion", idQuestion).list();
        if (ourList.size() == 0) {
            return true;
        }
        return false;
    }

    public boolean checkCountAnswerInQuestion(int idQuestion) {
        List<AnswersEntity> ourList = session.getCurrentSession().createSQLQuery("SELECT * from answers WHERE ID_question=:idquestion").addEntity(AnswersEntity.class).setInteger("idquestion", idQuestion).list();
        if (ourList.size() == 0) {
            return false;
        }
        return true;
    }

    public boolean checkCountCorrectAnswerInQuestion(int idQuestion) {
        List<AnswersEntity> ourList = session.getCurrentSession().createSQLQuery("SELECT * from answers WHERE ID_question=:idquestion and correct=1").addEntity(AnswersEntity.class).setInteger("idquestion", idQuestion).list();
        if (ourList.size() == 0) {
            return false;
        }
        return true;
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
            session.getCurrentSession().createSQLQuery("delete from test_questions WHERE ID_test=:idtest").setInteger("idtest", idTest).executeUpdate();
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

    public void addQuestionToTest(TestQuestionsEntity questionForTest) throws Exception {
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

    public FormsEntity addForm(FormsEntity ourForm) throws Exception {
        try {
            session.getCurrentSession().save(ourForm);
            return (FormsEntity) session.getCurrentSession().get(FormsEntity.class, ourForm.getId());
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать форму результат", e);
        }
    }

    public void updateForm(FormsEntity ourForm) throws Exception {
        try {
            session.getCurrentSession().update(ourForm);
        } catch (HibernateException e) {
            throw new Exception("Невозможно обновить форму результат", e);
        }
    }

    public void addResult(AnswersUserEntity ourAnswer) throws Exception {
        try {
            session.getCurrentSession().save(ourAnswer);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать строку результатв", e);
        }
    }

    public void updateResult(AnswersUserEntity ourAnswer) throws Exception {
        try {
            session.getCurrentSession().update(ourAnswer);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать строку результатв", e);
        }
    }

    public List getResult(int idform) {
        StringBuilder sql = new StringBuilder(200);

        sql.append("SELECT \n");
        sql.append("    questions.question,\n");
        sql.append("    IF(cor = usercorrect and cor<>0, 1, 0) AS correct,\n");
        sql.append("    IF(cor <> usercorrect or cor=0, 1, 0) AS uncorrect\n");
        sql.append("FROM\n");
        sql.append("    (SELECT \n");
        sql.append("        ID,\n");
        sql.append("            SUM(correct) AS cor,\n");
        sql.append("            SUM(userAnswerCorrect + textcorrect) AS usercorrect\n");
        sql.append("    FROM\n");
        sql.append("        (SELECT \n");
        sql.append("        *,\n");
        sql.append("            IF(type_question = 3\n");
        sql.append("                AND UPPER(TRIM(answer)) = UPPER(TRIM(textanswer)), 1, 0) AS textcorrect\n");
        sql.append("    FROM\n");
        sql.append("        (SELECT \n");
        sql.append("        *,\n");
        sql.append("            IF(correct = 1 AND usersID IS NOT NULL\n");
        sql.append("                AND type_question < 3, 1, 0) AS userAnswerCorrect\n");
        sql.append("    FROM\n");
        sql.append("        (SELECT \n");
        sql.append("        test.*, answers_user.textanswer, answers_user.ID AS usersID\n");
        sql.append("    FROM\n");
        sql.append("        (SELECT \n");
        sql.append("        questions.ID,\n");
        sql.append("            questions.type_question,\n");
        sql.append("            answers.correct,\n");
        sql.append("            answers.ID AS idanswer,\n");
        sql.append("            IF(questions.type_question = 3, answers.answer, '') AS answer\n");
        sql.append("    FROM\n");
        sql.append("        questions\n");
        sql.append("    LEFT JOIN answers ON questions.ID = answers.ID_question\n");
        sql.append("    WHERE\n");
        sql.append("        questions.ID IN (SELECT \n");
        sql.append("                answers_user.ID_question\n");
        sql.append("            FROM\n");
        sql.append("                answers_user\n");
        sql.append("            WHERE\n");
        sql.append("                ID_form = :idform)) AS test\n");
        sql.append("    LEFT JOIN answers_user ON test.ID = answers_user.ID_question\n");
        sql.append("        AND answers_user.ID_form = :idform\n");
        sql.append("        AND test.idanswer = answers_user.ID_answer) AS main) AS ourquery) AS repeatQ\n");
        sql.append("    GROUP BY ID) AS finish left join questions on finish.ID=questions.ID");
        SQLQuery query = session.getCurrentSession().createSQLQuery(sql.toString());
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List results = query.setInteger("idform", idform).list();
        return results;
    }

    public List getListTestByKey(int category, String keySearch) {
        StringBuilder sql = new StringBuilder(200);

        sql.append("SELECT DISTINCT\n");
        sql.append("    tests.testname, tests.pathtotest\n");
        sql.append("FROM\n");
        sql.append("    (SELECT \n");
        sql.append("        ID as idtest\n");
        sql.append("    FROM\n");
        sql.append("        tests\n");
        sql.append("    WHERE\n");
        if  (category!=0)
        {sql.append("        ID_category = :idcategory AND ");}
        sql.append(        " firstpage = 1\n");
        sql.append("            AND testname LIKE :key UNION SELECT \n");
        sql.append("        ID_test\n");
        sql.append("    FROM\n");
        sql.append("        (SELECT \n");
        sql.append("        test_questions.ID_test, test_questions.ID_question\n");
        sql.append("    FROM\n");
        sql.append("        test_questions\n");
        sql.append("    LEFT JOIN questions ON test_questions.ID_question = questions.ID\n");
        sql.append("    WHERE\n");
        sql.append("        test_questions.ID_test IN (SELECT \n");
        sql.append("                ID\n");
        sql.append("            FROM\n");
        sql.append("                tests\n");
        sql.append("            WHERE\n");
        if  (category!=0)
        {sql.append("        ID_category = :idcategory AND ");}
        sql.append(        " firstpage = 1)) AS main\n");
        sql.append("    LEFT JOIN questions ON main.ID_question = questions.ID\n");
        sql.append("    WHERE\n");
        sql.append("        questions.question LIKE :key) AS finish left join tests on finish.idtest=tests.ID");

        SQLQuery query = session.getCurrentSession().createSQLQuery(sql.toString());
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        if  (category!=0) {query.setInteger("idcategory", category);}
        query.setString("key", "%"+keySearch+"%");
        List results = query.list();
        return results;

    }


}
