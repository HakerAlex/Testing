package com.springapp.mvc.domain;

import javax.persistence.*;
import java.util.Collection;


@Entity
@Table(name = "users", schema = "testdb", catalog = "")
public class UsersEntity {
    private int id;
    private String name;
    private String phone;
    private String password;
    private byte status;
    private String email;
    private int idRule;
    private String surname;

    private RulesEntity rulesEntity;

    private Collection<TestsEntity> testsEntityCollection;
    private Collection<FormsEntity> formsEntityCollection;

    @Id
    @Column(name = "ID", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "name", length = 100)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "password",  length = 1500)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "status")
    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    @Basic
    @Column(name = "email", length = 100)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "phone",  length = 100)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Basic
    @Column(name = "ID_rule")
    public int getIdRule() {
        return idRule;
    }

    public void setIdRule(int idRule) {
        this.idRule = idRule;
    }

    @Basic
    @Column(name = "surname", length = 100)
    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UsersEntity that = (UsersEntity) o;

        if (id != that.id) return false;
        if (status != that.status) return false;
        if (idRule != that.idRule) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (surname != null ? !surname.equals(that.surname) : that.surname != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (int) status;
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + idRule;
        result = 31 * result + (surname != null ? surname.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "ID_rule", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
    public RulesEntity getRulesEntity() {
        return rulesEntity;
    }

    public void setRulesEntity(RulesEntity rulesEntity) {
        this.rulesEntity = rulesEntity;
    }

    @OneToMany(mappedBy = "idUsers")
    public Collection<TestsEntity> getTestsEntityCollection() {
        return testsEntityCollection;
    }

    public void setTestsEntityCollection(Collection<TestsEntity> testsEntityCollection) {
        this.testsEntityCollection = testsEntityCollection;
    }

    @OneToMany(mappedBy = "idUser")
    public Collection<FormsEntity> getFormsEntityCollection() {
        return formsEntityCollection;
    }

    public void setFormsEntityCollection(Collection<FormsEntity> formsEntityCollection) {
        this.formsEntityCollection = formsEntityCollection;
    }


}
