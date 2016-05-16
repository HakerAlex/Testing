package com.springapp.mvc.domain;

import javax.persistence.*;
import java.util.Arrays;
import java.util.Collection;

@Entity
@Table(name = "testcategories")
public class TestcategoriesEntity {
    private String category;
    private int id;
    private String pathtopicture;
    private byte[] picture;
    private String description;


    @Basic
    @Column(name = "parent")
    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    private int parent;


    private Collection<TestsEntity> testsEntityCollection;

    @Basic
    @Column(name = "category", nullable = false, length = -1)
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Id
    @Column(name = "ID", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "pathtopicture", length = -1)
    public String getPathtopicture() {
        return pathtopicture;
    }

    public void setPathtopicture(String pathtopicture) {
        this.pathtopicture = pathtopicture;
    }

    @Basic
    @Column(name = "picture")
    public byte[] getPicture() {
        return picture;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    @Basic
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TestcategoriesEntity that = (TestcategoriesEntity) o;

        if (id != that.id) return false;
        if (category != null ? !category.equals(that.category) : that.category != null) return false;
        if (pathtopicture != null ? !pathtopicture.equals(that.pathtopicture) : that.pathtopicture != null)
            return false;
        if (!Arrays.equals(picture, that.picture)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = category != null ? category.hashCode() : 0;
        result = 31 * result + id;
        result = 31 * result + (pathtopicture != null ? pathtopicture.hashCode() : 0);
        result = 31 * result + Arrays.hashCode(picture);
        return result;
    }

    @OneToMany(mappedBy = "idCategory")
    public Collection<TestsEntity> getTestsEntityCollection() {
        return testsEntityCollection;
    }

    public void setTestsEntityCollection(Collection<TestsEntity> testsEntityCollection) {
        this.testsEntityCollection = testsEntityCollection;
    }
}
