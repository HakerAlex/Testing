package com.springapp.mvc.service;

import com.springapp.mvc.domain.AnswersEntity;
import com.springapp.mvc.domain.FormsEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import com.springapp.mvc.repository.QuestionRepository;
import com.springapp.mvc.repository.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("createListTest")
public class CreateListTest {

    @Autowired
    private TestRepository testRepository;

    @Autowired
    private QuestionRepository questionRepository;

    public String createListTest(String numberTest) {

        List<QuestionsEntity> ourQuestions = testRepository.getQuestionsByTestPath(numberTest);

        StringBuilder ourBuffer = new StringBuilder(500);

        int flag = 0;
        for (QuestionsEntity ourQuen : ourQuestions) {

            if (ourQuen == null) {
                ourBuffer.append("<li class=\"list-group-item list-group-item-danger\">");
                ourBuffer.append("<span class=\"glyphicon glyphicon-star\"></span>");
                ourBuffer.append("<h4 class=\"list-group-item-heading\">");
                ourBuffer.append("Вопросы к тесту не добавлены!!!!");
                ourBuffer.append("</h4>");
                ourBuffer.append("</li>");
                return ourBuffer.toString();
            }

            if (flag == 0) {
                ourBuffer.append("<li class=\"list-group-item list-group-item-success\">");
                flag++;
            } else if (flag == 1) {
                ourBuffer.append("<li class=\"list-group-item list-group-item-warning\">");
                flag++;
            } else if (flag == 2) {
                ourBuffer.append("<li class=\"list-group-item list-group-item-info\">");
                flag++;
            } else if (flag == 3) {
                ourBuffer.append("<li class=\"list-group-item list-group-item-danger\">");
                flag = 0;
            }

            ourBuffer.append("<span class=\"glyphicon glyphicon-star\"></span>");
            ourBuffer.append("<h4 class=\"list-group-item-heading\">");
            ourBuffer.append(ourQuen.getQuestion());
            ourBuffer.append("</h4>");
            ourBuffer.append("<input type=\"hidden\" name=\"question");
            ourBuffer.append(ourQuen.getId());
            ourBuffer.append("\">");
            ourBuffer.append("<hr class=\"hr-xs\">");
            ourBuffer.append("<p class=\"list-group-item-body\" style=\"color:black\">");


            List<AnswersEntity> ourAnswers = questionRepository.getAnswersByQuestion(ourQuen.getId());

            int i = 0;
            for (AnswersEntity ourAnswer : ourAnswers) {
                if (ourQuen.getTypeQuestion() < 3) {
                    i++;
                    ourBuffer.append("<h5>");
                    ourBuffer.append("<span class=\"glyphicon glyphicon-bookmark\"></span>");
                    ourBuffer.append("Ответ №");
                    ourBuffer.append(i);
                    ourBuffer.append("</h5>");

                    ourBuffer.append(ourAnswer.getAnswer());
                    ourBuffer.append("<hr class=\"hr-xs\">");
                }
            }

            if (ourQuen.getTypeQuestion() < 3) {
                ourBuffer.append("<div class=\"btn-group\" data-toggle=\"buttons\">");

                for (i = 1; i <= ourAnswers.size(); i++) {

                    ourBuffer.append("<label class=\"btn btn-primary\">");

                    if (ourQuen.getTypeQuestion() == 1) {
                        ourBuffer.append("<input type=\"radio\" name=\"answer");
                        ourBuffer.append(ourQuen.getId());
                        ourBuffer.append("id");
                        ourBuffer.append(ourAnswers.get(i - 1).getId());
                        ourBuffer.append("\" id=\"option\"");
                        ourBuffer.append(ourQuen.getId());
                        ourBuffer.append(" value=\"");
                        ourBuffer.append(i);
                        ourBuffer.append("\">");
                        ourBuffer.append("Ответ №");
                        ourBuffer.append(i);
                    }

                    if (ourQuen.getTypeQuestion() == 2) {
                        ourBuffer.append("<input type=\"checkbox\" name=\"answer");
                        ourBuffer.append(ourQuen.getId());
                        ourBuffer.append("id");
                        ourBuffer.append(ourAnswers.get(i - 1).getId());
                        ourBuffer.append("\" id=\"option\"");
                        ourBuffer.append(ourQuen.getId());
                        ourBuffer.append(" value=\"");
                        ourBuffer.append(i);
                        ourBuffer.append("\">");
                        ourBuffer.append("Ответ №");
                        ourBuffer.append(i);
                    }
                    ourBuffer.append("</label>");
                }
                ourBuffer.append("</div>");
            }

            if (ourQuen.getTypeQuestion() == 3 && ourAnswers.size() > 0) {
                ourBuffer.append("<div class=\"form-group\">");
                ourBuffer.append("<div class=\"input-group\">");
                ourBuffer.append("<span class=\"input-group-addon\"><i class=\"ti-info\"></i></span>");
                ourBuffer.append("<input type=\"form-control\" class=\"form-control\" name=\"answer");
                ourBuffer.append(ourQuen.getId());
                ourBuffer.append("id");
                ourBuffer.append(ourAnswers.get(0).getId());
                ourBuffer.append("\">");
                ourBuffer.append("</div>");
                ourBuffer.append("</div>");
            }

            ourBuffer.append("</p>");
            ourBuffer.append("</li>");
        }


        return ourBuffer.toString();
    }

    public String returnResult(int idForm) {

        StringBuilder ourBuffer = new StringBuilder(100);

        ourBuffer.append("<li class=\"list-group-item list-group-item-info\">");
        ourBuffer.append("<span class=\"glyphicon glyphicon-star\"></span>");
        ourBuffer.append("<h4 class=\"list-group-item-heading\">");
        ourBuffer.append("Результат теста");
        ourBuffer.append("</h4>");
        ourBuffer.append("<table id=\"table\" class=\"table table-striped\" data-provide=\"data-table\" cellspacing=\"0\" width=\"100%\">");
        ourBuffer.append(" <thead> ");
        ourBuffer.append("<tr> ");
        ourBuffer.append("<th>Вопрос</th> ");
        ourBuffer.append("<th>Правильно</th> ");
        ourBuffer.append("<th>Неправильно</th> ");
        ourBuffer.append("</tr> ");
        ourBuffer.append("</thead> ");

        List result = testRepository.getResult(idForm);
        ourBuffer.append("<tbody> ");
        int cor = 0, uncor = 0;
        for (Object object : result) {
            ourBuffer.append("<tr>");
            Map row = (Map) object;
            ourBuffer.append("<td>");
            ourBuffer.append(row.get("question"));
            ourBuffer.append("</td>");

            ourBuffer.append("<td>");
            if (row.get("correct").toString().equals("1")) {
                ourBuffer.append(" <span class=\"label bg-success\" style=\"background: #00cc00\">");
                ourBuffer.append("Правильно");
                ourBuffer.append(" </span>");
                cor++;
            }
            ourBuffer.append("</td>");

            ourBuffer.append("<td>");
            if (row.get("uncorrect").toString().equals("1")) {
                ourBuffer.append(" <span class=\"label bg-danger\" style=\"background: red\"> ");
                ourBuffer.append("Неправильно");
                ourBuffer.append(" </span>");
                uncor++;
            }
            ourBuffer.append("</td>");
            ourBuffer.append("</tr>");
        }
        ourBuffer.append("</tbody> ");
        ourBuffer.append("<tfoot> ");
        ourBuffer.append("<tr>");
        ourBuffer.append("<td>");
        ourBuffer.append("Итого:");
        ourBuffer.append("</td>");
        ourBuffer.append("<td>");
        ourBuffer.append(cor);
        ourBuffer.append("</td>");
        ourBuffer.append("<td>");
        ourBuffer.append(uncor);
        ourBuffer.append("</td>");
        ourBuffer.append("</tr>");
        ourBuffer.append("</tfoot> ");
        ourBuffer.append("</table> ");
        ourBuffer.append("</li> ");

        FormsEntity ourForm = testRepository.getFormByID(idForm);
        ourForm.setQuantityQuestion(cor + uncor);
        ourForm.setCorrectQuestion(cor);
        try {
            testRepository.updateForm(ourForm);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ourBuffer.toString();

    }

    public String returnSearchList(int categoryid, String keySearch) {

        List ourSearch = testRepository.getListTestByKey(categoryid, keySearch);


        StringBuilder ourBuffer = new StringBuilder(100);

        for (Object object : ourSearch) {
            Map row = (Map) object;
            ourBuffer.append("<a href=\"javascript:opentest('");
            ourBuffer.append(row.get("pathtotest"));
            ourBuffer.append("')\" class=\"list-group-item\" style=\"text-align: left\">");
            ourBuffer.append("<span class=\"glyphicon glyphicon-star\"></span>");
            ourBuffer.append(row.get("testname"));
            ourBuffer.append("</a>");
        }

        return ourBuffer.toString();

    }


    public String returnStatisticTable(List listResult) {
        Integer countColumn=0;

        if (listResult.size()>0){
            Object object =listResult.get(0);
            Map row = (Map) object;
            countColumn=new Integer(row.get("QuantityForm").toString());
        }
        StringBuilder ourStatistic = new StringBuilder(1000);
        ourStatistic.append("<thead>\n");
        ourStatistic.append("    <tr>\n");
        ourStatistic.append("<th>Фамилия</th>\n");
        ourStatistic.append("<th>Имя</th>\n");
        ourStatistic.append("<th>E-mail</th>\n");
        ourStatistic.append("<th>Телефон</th>\n");
        ourStatistic.append("<th>Тест</th>\n");
        ourStatistic.append("<th>Общее</th>\n");
        ourStatistic.append("<th>Прав.</th>\n");
        ourStatistic.append("<th>Неправ.</th>\n");
        ourStatistic.append("<th>Дата начала</th>\n");
        ourStatistic.append("<th>Дата окончания</th>\n");
        for (int i=0;i<countColumn;i++){
            ourStatistic.append("<th>");
            ourStatistic.append(i+1);
            ourStatistic.append("</th>\n");
        }
        ourStatistic.append("</tr>\n");
        ourStatistic.append("</thead>\n");

        ourStatistic.append("<tfoot>\n");
        ourStatistic.append("    <tr >\n");
        ourStatistic.append("<th>Фамилия</th>\n");
        ourStatistic.append("<th>Имя</th>\n");
        ourStatistic.append("<th>E-mail</th>\n");
        ourStatistic.append("<th>Телефон</th>\n");
        ourStatistic.append("<th>Тест</th>\n");
        ourStatistic.append("<th>Общее</th>\n");
        ourStatistic.append("<th>Прав.</th>\n");
        ourStatistic.append("<th>Неправ.</th>\n");
        ourStatistic.append("<th>Дата начала</th>\n");
        ourStatistic.append("<th>Дата окончания</th>\n");
        for (int i=0;i<countColumn;i++){
            ourStatistic.append("<th>");
            ourStatistic.append(i+1);
            ourStatistic.append("</th>\n");
        }
        ourStatistic.append("</tr>\n");
        ourStatistic.append("</tfoot>\n");


        ourStatistic.append("<tbody>\n");
        for (Object object : listResult) {
            ourStatistic.append("<tr>\n");
            Map row = (Map) object;
            ourStatistic.append("<td>");
            ourStatistic.append(row.get("surname").toString());
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td>");
            ourStatistic.append(row.get("name").toString());
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td>");
            ourStatistic.append(row.get("email").toString());
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td>");
            ourStatistic.append(row.get("phone").toString());
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td>");
            ourStatistic.append("<a href='javascript:getUserResult(");
            ourStatistic.append(row.get("ID").toString());
            ourStatistic.append(")'>");
            ourStatistic.append(row.get("testname").toString());
            ourStatistic.append("</a>");
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td style='text-align: center'>");
            ourStatistic.append(row.get("quantity_question").toString());
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td  style='text-align: center'>");
            ourStatistic.append(row.get("correct_question").toString());
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td  style='text-align: center'>");
            ourStatistic.append(row.get("uncorrect").toString());
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td>");
            ourStatistic.append(row.get("datestart").toString());
            ourStatistic.append("</td>\n");
            ourStatistic.append("<td>");
            ourStatistic.append(row.get("datefinish").toString());
            ourStatistic.append("</td>\n");

            String[] codeQuestion = row.get("all_ID").toString().split(":");
            String[] correctQuestion = row.get("correct").toString().split(":");
            for (int j=0;j<codeQuestion.length;j++){

                ourStatistic.append("<td>");

                if (correctQuestion[j].equals("1")) {
                    ourStatistic.append(" <span class=\"label bg-success\" style=\"background: #00cc00\">");
                    ourStatistic.append("Прав.");
                    ourStatistic.append(" </span>");
                }else
                {
                    ourStatistic.append(" <span class=\"label bg-danger\" style=\"background: red\"> ");
                    ourStatistic.append("Неправ.");
                    ourStatistic.append(" </span>");
                }
                ourStatistic.append("</td>\n");

            }

            if (codeQuestion.length<countColumn){
                for (int i=codeQuestion.length; i<=countColumn;i++)
                {
                ourStatistic.append("<td>");
                ourStatistic.append("</td>\n");
                }
            }

            ourStatistic.append("</tr>");

        }
        ourStatistic.append("<tbody> ");
        return ourStatistic.toString();
    }

}
