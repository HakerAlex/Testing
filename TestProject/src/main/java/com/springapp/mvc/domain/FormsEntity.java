package com.springapp.mvc.domain;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Collection;

@Entity
@Table(name = "forms")
public class FormsEntity {
    private int id;
    private int idTest;
    private int idUser;
    private Date date;
    private Timestamp datestart;
    private Timestamp datefinish;
    private int quantityQuestion;
    private int correctQuestion;

    private TestsEntity testsEntity;
    private UsersEntity usersEntity;

    private Collection<AnswersUserEntity> answersUserEntities;

    @Id
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
    @Column(name = "ID_user")
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @Basic
    @Column(name = "date")
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Basic
    @Column(name = "datestart")
    public Timestamp getDatestart() {
        return datestart;
    }

    public void setDatestart(Timestamp datestart) {
        this.datestart = datestart;
    }

    @Basic
    @Column(name = "datefinish")
    public Timestamp getDatefinish() {
        return datefinish;
    }

    public void setDatefinish(Timestamp datefinish) {
        this.datefinish = datefinish;
    }

    @Basic
    @Column(name = "quantity_question")
    public int getQuantityQuestion() {
        return quantityQuestion;
    }

    public void setQuantityQuestion(int quantityQuestion) {
        this.quantityQuestion = quantityQuestion;
    }

    @Basic
    @Column(name = "correct_question")
    public int getCorrectQuestion() {
        return correctQuestion;
    }

    public void setCorrectQuestion(int correctQuestion) {
        this.correctQuestion = correctQuestion;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FormsEntity that = (FormsEntity) o;

        if (id != that.id) return false;
        if (idTest != that.idTest) return false;
        if (idUser != that.idUser) return false;
        if (quantityQuestion != that.quantityQuestion) return false;
        if (correctQuestion != that.correctQuestion) return false;
        if (date != null ? !date.equals(that.date) : that.date != null) return false;
        if (datestart != null ? !datestart.equals(that.datestart) : that.datestart != null) return false;
        if (datefinish != null ? !datefinish.equals(that.datefinish) : that.datefinish != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + idTest;
        result = 31 * result + idUser;
        result = 31 * result + (date != null ? date.hashCode() : 0);
        result = 31 * result + (datestart != null ? datestart.hashCode() : 0);
        result = 31 * result + (datefinish != null ? datefinish.hashCode() : 0);
        result = 31 * result + quantityQuestion;
        result = 31 * result + correctQuestion;
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "ID_test", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
    public TestsEntity getTestsEntity() {
        return testsEntity;
    }

    public void setTestsEntity(TestsEntity testsEntity) {
        this.testsEntity = testsEntity;
    }

    @ManyToOne
    @JoinColumn(name = "ID_user", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
    public UsersEntity getUsersEntity() {
        return usersEntity;
    }

    public void setUsersEntity(UsersEntity usersEntity) {
        this.usersEntity = usersEntity;
    }

    @OneToMany(mappedBy = "idForm")
    public Collection<AnswersUserEntity> getAnswersUserEntities() {
        return answersUserEntities;
    }

    public void setAnswersUserEntities(Collection<AnswersUserEntity> answersUserEntities) {
        this.answersUserEntities = answersUserEntities;
    }

}
