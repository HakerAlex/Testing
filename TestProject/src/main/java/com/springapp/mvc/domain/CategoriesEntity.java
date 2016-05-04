package com.springapp.mvc.domain;


import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "categories")
public class CategoriesEntity {
    private String category;
    private int id;
    private int parent;
    private Collection<QuestionsEntity> questionById;


    @Basic
    @Column(name = "category")
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "parent", nullable = true)
    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CategoriesEntity that = (CategoriesEntity) o;

        if (id != that.id) return false;
        if (parent != that.parent) return false;
        if (category != null ? !category.equals(that.category) : that.category != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = category != null ? category.hashCode() : 0;
        result = 31 * result + id;
        result = 31 * result + parent;
        return result;
    }

    @OneToMany(mappedBy = "category")
    public Collection<QuestionsEntity> getQuestionById() {
        return questionById;
    }

    public void setQuestionById(Collection<QuestionsEntity> questionById) {
        this.questionById = questionById;
    }


}
