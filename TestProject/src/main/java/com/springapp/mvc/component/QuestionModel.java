package com.springapp.mvc.component;


import com.springapp.mvc.domain.AnswersEntity;
import com.springapp.mvc.domain.QuestionsEntity;

import java.util.List;

public class QuestionModel {
    private QuestionsEntity question;
    private List<AnswersEntity> listAnswers;

    public QuestionsEntity getQuestion() {
        return question;
    }

    public void setQuestion(QuestionsEntity question) {
        this.question = question;
    }

    public List<AnswersEntity> getListAnswers() {
        return listAnswers;
    }

    public void setListAnswers(List<AnswersEntity> listAnswers) {
        this.listAnswers = listAnswers;
    }
}
