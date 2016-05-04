package com.springapp.mvc.domain;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;

@Entity
@Table(name = "tests")
public class TestsEntity {
    private int id;
    private String testname;
    private Date dateStart;
    private Date dateFinish;
    private byte firstpage;
    private int idUsers;
    private int idCategory;
    private String pathtotest;

    private CategoriesEntity categoriesById;
    private UsersEntity usersById;

    private Collection<TestQuestionsEntity> testQuestionsEntities;
    private Collection<FormsEntity> formsEntities;


    @Id
    @Column(name = "ID", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "testname",  length = -1)
    public String getTestname() {
        return testname;
    }

    public void setTestname(String testname) {
        this.testname = testname;
    }

    @Basic
    @Column(name = "date_start")
    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    @Basic
    @Column(name = "date_finish" )
    public Date getDateFinish() {
        return dateFinish;
    }

    public void setDateFinish(Date dateFinish) {
        this.dateFinish = dateFinish;
    }

    @Basic
    @Column(name = "firstpage")
    public byte getFirstpage() {
        return firstpage;
    }

    public void setFirstpage(byte firstpage) {
        this.firstpage = firstpage;
    }

    @Basic
    @Column(name = "ID_users")
    public int getIdUsers() {
        return idUsers;
    }

    public void setIdUsers(int idUsers) {
        this.idUsers = idUsers;
    }

    @Basic
    @Column(name = "ID_category", nullable = false)
    public int getIdCategory() {
        return idCategory;
    }

    public void setIdCategory(int idCategory) {
        this.idCategory = idCategory;
    }

    @Basic
    @Column(name = "pathtotest")
    public String getPathtotest() {
        return pathtotest;
    }

    public void setPathtotest(String pathtotest) {
        this.pathtotest = pathtotest;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TestsEntity that = (TestsEntity) o;

        if (id != that.id) return false;
        if (firstpage != that.firstpage) return false;
        if (idUsers != that.idUsers) return false;
        if (idCategory != that.idCategory) return false;
        if (testname != null ? !testname.equals(that.testname) : that.testname != null) return false;
        if (dateStart != null ? !dateStart.equals(that.dateStart) : that.dateStart != null) return false;
        if (dateFinish != null ? !dateFinish.equals(that.dateFinish) : that.dateFinish != null) return false;
        if (pathtotest != null ? !pathtotest.equals(that.pathtotest) : that.pathtotest != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (testname != null ? testname.hashCode() : 0);
        result = 31 * result + (dateStart != null ? dateStart.hashCode() : 0);
        result = 31 * result + (dateFinish != null ? dateFinish.hashCode() : 0);
        result = 31 * result + (int) firstpage;
        result = 31 * result + idUsers;
        result = 31 * result + idCategory;
        result = 31 * result + (pathtotest != null ? pathtotest.hashCode() : 0);
        return result;
    }


    @ManyToOne
    @JoinColumn(name = "ID_category", referencedColumnName = "ID",  insertable = false, updatable = false)
    public CategoriesEntity getCategoryById() {
        return categoriesById;
    }

    public void setCategoryById(CategoriesEntity categoriesById) {
        this.categoriesById = categoriesById;
    }

    @ManyToOne
    @JoinColumn(name = "ID_users", referencedColumnName = "ID",  insertable = false, updatable = false)
    public UsersEntity getUsersById() {
        return usersById;
    }

    public void setUsersById(UsersEntity usersById) {
        this.usersById = usersById;
    }

    @OneToMany(mappedBy = "idQuestion")
    public Collection<TestQuestionsEntity> getTestQuestionsEntities() {
        return testQuestionsEntities;
    }

    public void setTestQuestionsEntities(Collection<TestQuestionsEntity> testQuestionsEntities) {
        this.testQuestionsEntities = testQuestionsEntities;
    }

    @OneToMany(mappedBy = "idTest")
    public Collection<FormsEntity> getFormsEntities() {
        return formsEntities;
    }

    public void setFormsEntities(Collection<FormsEntity> formsEntities) {
        this.formsEntities = formsEntities;
    }
}

