package com.springapp.mvc.domain;

import javax.persistence.*;


@Entity
@Table(name = "answers")
public class AnswersEntity {
    private int id;
    private String answer;
    private byte correct;
    private int idQuestion;

    private QuestionsEntity questionById;

    @Id
    @GeneratedValue
    @Column(name = "ID")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "answer", length = -1)
    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    @Basic
    @Column(name = "correct")
    public byte getCorrect() {
        return correct;
    }

    public void setCorrect(byte correct) {
        this.correct = correct;
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

        AnswersEntity that = (AnswersEntity) o;

        if (id != that.id) return false;
        if (correct != that.correct) return false;
        if (idQuestion != that.idQuestion) return false;
        if (answer != null ? !answer.equals(that.answer) : that.answer != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (answer != null ? answer.hashCode() : 0);
        result = 31 * result + (int) correct;
        result = 31 * result + idQuestion;
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "ID_question", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
    public QuestionsEntity getQuestionById() {
        return questionById;
    }

    public void setQuestionById(QuestionsEntity questionById) {
        this.questionById = questionById;
    }
}
