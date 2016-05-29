package com.springapp.mvc.domain;

import javax.persistence.*;

@Entity
@Table(name = "answers_user")
public class AnswersUserEntity {
    private int id;
    private int idForm;
    private Integer idAnswer;
    private int idQuestion;
    private String textanswer;

    private QuestionsEntity questionByid;
    private FormsEntity formsByid;


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
    @Column(name = "ID_form", nullable = false)
    public int getIdForm() {
        return idForm;
    }

    public void setIdForm(int idForm) {
        this.idForm = idForm;
    }

    @Basic
    @Column(name = "ID_answer")
    public Integer getIdAnswer() {
        return idAnswer;
    }

    public void setIdAnswer(Integer idAnswer) {
        this.idAnswer = idAnswer;
    }

    @Basic
    @Column(name = "ID_question")
    public int getIdQuestion() {
        return idQuestion;
    }

    public void setIdQuestion(int idQuestion) {
        this.idQuestion = idQuestion;
    }

    @Basic
    @Column(name = "textanswer")
    public String getTextanswer() {
        return textanswer;
    }

    public void setTextanswer(String textanswer) {
        this.textanswer = textanswer;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AnswersUserEntity that = (AnswersUserEntity) o;

        if (id != that.id) return false;
        if (idForm != that.idForm) return false;
        if (idQuestion != that.idQuestion) return false;
        if (idAnswer != null ? !idAnswer.equals(that.idAnswer) : that.idAnswer != null) return false;
        if (textanswer != null ? !textanswer.equals(that.textanswer) : that.textanswer != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + idForm;
        result = 31 * result + (idAnswer != null ? idAnswer.hashCode() : 0);
        result = 31 * result + idQuestion;
        result = 31 * result + (textanswer != null ? textanswer.hashCode() : 0);
        return result;
    }


    @ManyToOne
    @JoinColumn(name = "ID_question", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
    public QuestionsEntity getQuestionByid() {
        return questionByid;
    }

    public void setQuestionByid(QuestionsEntity questionByid) {
        this.questionByid = questionByid;
    }

    @ManyToOne
    @JoinColumn(name = "ID_form", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
    public FormsEntity getFormsByid() {
        return formsByid;
    }

    public void setFormsByid(FormsEntity formsByid) {
        this.formsByid = formsByid;
    }
}
