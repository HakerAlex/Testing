package com.springapp.mvc.domain;

import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "questions")
public class QuestionsEntity {
    private int id;
    private String question;
    private int category;
    private int typeQuestion;
    private CategoriesEntity categoriesById;

    //collections

    private Collection<AnswersEntity> answersById;
    private Collection<AnswersUserEntity> answersusersById;
    private Collection<TestQuestionsEntity> testQuestionById;

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
    @Column(name = "question")
    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    @Basic
    @Column(name = "category")
    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    @Basic
    @Column(name = "type_question")
    public int getTypeQuestion() {
        return typeQuestion;
    }

    public void setTypeQuestion(int typeQuestion) {
        this.typeQuestion = typeQuestion;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        QuestionsEntity that = (QuestionsEntity) o;

        if (id != that.id) return false;
        if (category != that.category) return false;
        if (typeQuestion != that.typeQuestion) return false;
        if (question != null ? !question.equals(that.question) : that.question != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (question != null ? question.hashCode() : 0);
        result = 31 * result + category;
        result = 31 * result + typeQuestion;
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "category", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
    public CategoriesEntity getCategoryById() {
        return categoriesById;
    }

    public void setCategoryById(CategoriesEntity categoriesById) {
        this.categoriesById = categoriesById;
    }

    @OneToMany(mappedBy = "idQuestion")
    public Collection<AnswersEntity> getAnswersById() {
        return answersById;
    }

    public void setAnswersById(Collection<AnswersEntity> answersById) {
        this.answersById = answersById;
    }

    @OneToMany(mappedBy = "idQuestion")
    public Collection<AnswersUserEntity> getAnswersusersById() {
        return answersusersById;
    }

    public void setAnswersusersById(Collection<AnswersUserEntity> answersusersById) {
        this.answersusersById = answersusersById;
    }

    @OneToMany(mappedBy = "idQuestion")
    public Collection<TestQuestionsEntity> getTestQuestionById() {
        return testQuestionById;
    }

    public void setTestQuestionById(Collection<TestQuestionsEntity> testQuestionById) {
        this.testQuestionById = testQuestionById;
    }

}
