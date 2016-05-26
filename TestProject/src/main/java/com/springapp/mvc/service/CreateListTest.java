package com.springapp.mvc.service;

import com.springapp.mvc.domain.AnswersEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import com.springapp.mvc.repository.QuestionRepository;
import com.springapp.mvc.repository.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("createListTest")
public class CreateListTest {

    @Autowired
    private TestRepository testRepository;

    @Autowired
    private QuestionRepository questionRepository;

  public String createListTest(String numberTest){

      List<QuestionsEntity> ourQuestions =testRepository.getQuestionsByTestPath(numberTest);

      StringBuilder ourBuffer=new StringBuilder(500);

      for (QuestionsEntity ourQuen: ourQuestions){
          ourBuffer.append("<li class=\"list-group-item\">");
          ourBuffer.append("<span class=\"glyphicon glyphicon-star\"></span>");
          ourBuffer.append("<h4 class=\"list-group-item-heading\">");
          ourBuffer.append(ourQuen.getQuestion());
          ourBuffer.append("</h4>");
          ourBuffer.append("<input type=\"hidden\" name=\"question");
          ourBuffer.append(ourQuen.getId());
          ourBuffer.append("\">");
          ourBuffer.append("<hr class=\"hr-xs\">");
          ourBuffer.append("<p class=\"list-group-item-body\" style=\"color:black\">");


          List<AnswersEntity> ourAnswers=questionRepository.getAnswersByQuestion(ourQuen.getId());

          for (AnswersEntity ourAnswer:ourAnswers){
              ourBuffer.append(ourAnswer.getAnswer());
              ourBuffer.append("<hr class=\"hr-xs\">");
          }

          if (ourQuen.getTypeQuestion()<3){
              ourBuffer.append("<div class=\"btn-group\" data-toggle=\"buttons\">");

              for(int i=1;i<=ourAnswers.size();i++){

                  ourBuffer.append("<label class=\"btn btn-primary\">");

                  if (ourQuen.getTypeQuestion()==1) {
                      ourBuffer.append("<input type=\"radio\" name=\"answer\" id=\"option\"");
                      ourBuffer.append(ourQuen.getId());
                      ourBuffer.append(" value=\"");
                      ourBuffer.append(i);
                      ourBuffer.append("\">");
                      ourBuffer.append("");
                      ourBuffer.append("Ответ №"+i);
                  }

                  if (ourQuen.getTypeQuestion()==2) {
                      ourBuffer.append("<input type=\"checkbox\" name=\"answer\" id=\"option\"");
                      ourBuffer.append(ourQuen.getId());
                      ourBuffer.append(" value=\"");
                      ourBuffer.append(i);
                      ourBuffer.append("\">");
                      ourBuffer.append("");
                      ourBuffer.append("Ответ №"+i);
                  }
                  ourBuffer.append("</label>");
              }
              ourBuffer.append("</div>");
          }

          if (ourQuen.getTypeQuestion()==3) {
              ourBuffer.append("<div class=\"form-group\">");
              ourBuffer.append("<div class=\"input-group\">");
              ourBuffer.append("<span class=\"input-group-addon\"><i class=\"ti-info\"></i></span>");
              ourBuffer.append("<input type=\"form-control\" class=\"form-control\" name=\"text");
              ourBuffer.append(ourQuen.getId());
              ourBuffer.append("\">");
              ourBuffer.append("</div>");
              ourBuffer.append("</div>");
          }

          ourBuffer.append("</p>");
          ourBuffer.append("</li>");
      }


      return ourBuffer.toString();
  }
}
