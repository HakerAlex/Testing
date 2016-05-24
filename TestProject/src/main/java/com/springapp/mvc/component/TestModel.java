package com.springapp.mvc.component;

import com.springapp.mvc.domain.TestsEntity;

import java.util.List;

public class TestModel {
    private TestsEntity test;
    private List<QuestionModel> listQuestion;

    public List<QuestionModel> getListQuestion() {
        return listQuestion;
    }

    public void setListQuestion(List<QuestionModel> listQuestion) {
        this.listQuestion = listQuestion;
    }

    public TestsEntity getTest() {
        return test;
    }

    public void setTest(TestsEntity test) {
        this.test = test;
    }

}
