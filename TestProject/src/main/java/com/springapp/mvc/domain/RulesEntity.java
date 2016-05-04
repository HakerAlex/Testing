package com.springapp.mvc.domain;

import javax.persistence.*;
import java.util.Collection;


@Entity
@Table(name = "rules", schema = "testdb", catalog = "")
public class RulesEntity {
    private int id;
    private String namerule;

    private Collection<UsersEntity> usersEntityCollection;

    @Id
    @Column(name = "ID", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "namerule", length = 1500)
    public String getNamerule() {
        return namerule;
    }

    public void setNamerule(String namerule) {
        this.namerule = namerule;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RulesEntity that = (RulesEntity) o;

        if (id != that.id) return false;
        if (namerule != null ? !namerule.equals(that.namerule) : that.namerule != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (namerule != null ? namerule.hashCode() : 0);
        return result;
    }

    @OneToMany(mappedBy = "idRule")
    public Collection<UsersEntity> getUsersEntityCollection() {
        return usersEntityCollection;
    }

    public void setUsersEntityCollection(Collection<UsersEntity> usersEntityCollection) {
        this.usersEntityCollection = usersEntityCollection;
    }
}
