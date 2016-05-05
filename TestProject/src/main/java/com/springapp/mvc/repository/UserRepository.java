package com.springapp.mvc.repository;

import com.springapp.mvc.domain.RulesEntity;
import com.springapp.mvc.domain.UsersEntity;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class UserRepository {

    @Autowired
    private SessionFactory session;

    public UsersEntity findUserByEmail(String email) {
        return (UsersEntity) session.getCurrentSession().createSQLQuery("Select * from users WHERE  users.email=:name").addEntity(UsersEntity.class).setString("name", email).uniqueResult();
    }

    public void createUser(UsersEntity user) throws Exception {
        try {
            session.getCurrentSession().save(user);
        } catch (HibernateException e) {
            throw new Exception("Невозможно создать пользователя " + user.getEmail(), e);
        }

    }

    public void updateUser(UsersEntity user) throws Exception {
        try {
            session.getCurrentSession().update(user);
        } catch (HibernateException e) {
            throw new Exception("Невозможно обновить пользователя " + user.getEmail(), e);
        }

    }

    public List<UsersEntity> getAllUsers() {
        return session.getCurrentSession().createSQLQuery("Select * from users LEFT JOIN rules on users.ID_rule = rules.ID").addEntity(UsersEntity.class).addEntity(RulesEntity.class).list();
    }

    public UsersEntity findUserByID(int id) {
        return (UsersEntity) session.getCurrentSession().createSQLQuery("Select * from users WHERE users.id=:id").addEntity(UsersEntity.class).setInteger("id", id).uniqueResult();
    }

    public RulesEntity findRuleByUserID(int id) {
        return (RulesEntity) session.getCurrentSession().createSQLQuery("Select rules.ID,rules.namerule from users left JOIN rules on users.ID_rule = rules.ID WHERE users.id=:id").addEntity(RulesEntity.class).setInteger("id", id).uniqueResult();
    }


}
