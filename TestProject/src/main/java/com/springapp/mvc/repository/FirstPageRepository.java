package com.springapp.mvc.repository;

import com.springapp.mvc.domain.TestcategoriesEntity;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Alex on 01.05.2015.
 */
@Repository
@Transactional
public class FirstPageRepository {
    @Autowired
    private SessionFactory sessionFactory;

    public Object testQuantity() {
        return this.sessionFactory.getCurrentSession().createSQLQuery("select count(*) as allrecord from tests").uniqueResult();
    }

    public List<TestcategoriesEntity> listCategories() {
        return this.sessionFactory.getCurrentSession().createSQLQuery("SELECT * FROM testcategories").addEntity(TestcategoriesEntity.class).list();
    }

//    public void addFirstPage(int idArticle, boolean feature, int raiting){
//        this.sessionFactory.getCurrentSession().createSQLQuery("Insert INTO firstpage (Article_ID,feature,Raiting) values(:id,:fe,:ra)").setInteger("id",idArticle).setBoolean("fe",feature).setInteger("ra",raiting).executeUpdate();
//    }


//
//    public List<FirstpageEntity> newsByName(String name){
//        return this.sessionFactory.getCurrentSession().createSQLQuery("SELECT * FROM articles LEFT JOIN users on users.ID = articles.Author WHERE articles.NamePage=:name").addEntity(ArticlesEntity.class).addEntity(UsersEntity.class).setString("name", name).list();
//    }


}
