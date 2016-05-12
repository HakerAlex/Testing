package com.springapp.mvc.controller;

import com.springapp.mvc.domain.AnswersEntity;
import com.springapp.mvc.domain.QuestionsEntity;
import com.springapp.mvc.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class QuestionController {

    @Autowired
    private QuestionRepository questionRepository;

    String returnCode(String parent) {
        String ID = parent.substring(5);
        int pos = ID.indexOf(" ");
        return ID.substring(0, pos);
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/writequestion", method = RequestMethod.POST)
    @ResponseBody
    public String writeQuestion(@RequestParam("category") String category, @RequestParam("question") String question, @RequestParam("code") String code, @RequestParam("typeq") String typeq) {

        int categoryID;
        if (!category.equals("")) {
            categoryID = new Integer(returnCode(category));
        } else {
            categoryID = 0;
        }

        QuestionsEntity ourQuestion;

        if (!code.equals("")) {
            ourQuestion = questionRepository.getQuestionByID(new Integer(code));
        } else {
            ourQuestion = new QuestionsEntity();
        }

        ourQuestion.setTypeQuestion(new Integer(typeq));

        ourQuestion.setQuestion(question);
        ourQuestion.setCategory(categoryID);

        try {
            if (!code.equals("")) {
                questionRepository.updateQuestion(ourQuestion);
            } else {
                questionRepository.createQuestion(ourQuestion);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        QuestionsEntity newOurQuestion = questionRepository.getQuestionByText(ourQuestion.getQuestion());

        StringBuilder ourAnswer = new StringBuilder(10);
        ourAnswer.append(newOurQuestion.getId());
        return ourAnswer.toString();
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/writeanswer", method = RequestMethod.POST)
    @ResponseBody
    public String writeAnswer(@RequestParam("answer") String answer, @RequestParam("codequestion") int codequestion, @RequestParam("flag") int flag, @RequestParam("typeq") int typeq, @RequestParam("answerid") String answerid) throws Exception {
        //check type of question in DB
        QuestionsEntity ourQuestion = questionRepository.getQuestionByID(codequestion);
        if (ourQuestion.getTypeQuestion() != typeq) //write question type
        {
            ourQuestion.setTypeQuestion(typeq);
            try {
                questionRepository.updateQuestion(ourQuestion);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        AnswersEntity ourAnswer;
        if (!answerid.equals("")) {
            ourAnswer = questionRepository.getAnswersByID(new Integer(answerid));
        } else {
            ourAnswer = new AnswersEntity(); //empty entities
        }


            ourAnswer.setCorrect((byte) 1);
            ourAnswer.setAnswer(answer);
            ourAnswer.setIdQuestion(codequestion);
        if (ourAnswer.getId() == 0)//answer not found
        {
            questionRepository.createAnswer(ourAnswer);
        }
        else
        {
            questionRepository.updateAnswer(ourAnswer);
        }



        List<AnswersEntity> myAnswers = questionRepository.getAnswersByQuestion(codequestion);

        if ((typeq == 1) && (flag == 1)) //we should check and rewrite, only one correct answer in base must be, because flag=1
        {
            for (AnswersEntity ourElement : myAnswers) {
                if (ourElement.getCorrect() == 1 && ourElement.getId() != ourAnswer.getId()) {
                    ourElement.setCorrect((byte) 0);
                    questionRepository.updateAnswer(ourElement);
                }
            }
        }

        StringBuilder error=new StringBuilder(100);

        if (typeq==3 && myAnswers.size()>1){
            error.append("Не может быть несколько ответов при таком типе вопроса");
            return error.toString();
        }


        return "";
    }


    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/editquestion/{id}", method = RequestMethod.GET)
    public String addQuestion(@PathVariable int id, Model model) {
        QuestionsEntity ourQuestion = questionRepository.getQuestionByID(id);

        StringBuilder ourCategory = new StringBuilder(20);
        ourCategory.append(" Код:");
        ourCategory.append(ourQuestion.getCategoryById().getId());
        ourCategory.append(" ");
        ourCategory.append(ourQuestion.getCategoryById().getCategory());

        model.addAttribute("category", ourCategory.toString());
        model.addAttribute("code", ourQuestion.getId());
        model.addAttribute("questiontext", ourQuestion.getQuestion());
        model.addAttribute("questiontype", ourQuestion.getTypeQuestion());

        return "addquestion";
    }


}
