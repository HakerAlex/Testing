package com.springapp.mvc.domain;

import javax.persistence.*;

@Entity
@Table(name = "test_questions")
public class TestQuestionsEntity {
    private int id;
    private int idTest;
    private int idQuestion;

    private TestsEntity testsEntity;


    private QuestionsEntity questionsEntity;

    @Id
    @GeneratedValue
    @Column(name = "ID", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "ID_test")
    public int getIdTest() {
        return idTest;
    }

    public void setIdTest(int idTest) {
        this.idTest = idTest;
    }

    @Basic
    @Column(name = "ID_question")
    public int getIdQuestion() {
        return idQuestion;
    }

    public void setIdQuestion(int idQuestion) {
        this.idQuestion = idQuestion;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TestQuestionsEntity that = (TestQuestionsEntity) o;

        if (id != that.id) return false;
        if (idTest != that.idTest) return false;
        if (idQuestion != that.idQuestion) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + idTest;
        result = 31 * result + idQuestion;
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "ID_test", referencedColumnName = "ID", insertable = false, updatable = false)
    public TestsEntity getTestsEntity() {
        return testsEntity;
    }

    public void setTestsEntity(TestsEntity testsEntity) {
        this.testsEntity = testsEntity;
    }


    @ManyToOne
    @JoinColumn(name = "ID_question", referencedColumnName = "ID", insertable = false, updatable = false)
    public QuestionsEntity getQuestionsEntity() {
        return questionsEntity;
    }

    public void setQuestionsEntity(QuestionsEntity questionsEntity) {
        this.questionsEntity = questionsEntity;
    }

}
