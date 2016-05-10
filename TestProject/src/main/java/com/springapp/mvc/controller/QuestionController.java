package com.springapp.mvc.controller;

import com.springapp.mvc.domain.QuestionsEntity;
import com.springapp.mvc.repository.CategoryRepository;
import com.springapp.mvc.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class QuestionController {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private CategoryRepository categoryRepository;


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

        QuestionsEntity newOurQuestion=questionRepository.getQuestionByText(ourQuestion.getQuestion());

        StringBuilder ourAnswer = new StringBuilder(10);
        ourAnswer.append(newOurQuestion.getId());
        return ourAnswer.toString();
    }

    @PreAuthorize("hasRole('admin')")
    @RequestMapping(value = "/editquestion/{id}", method = RequestMethod.GET)
    public String addQuestion(@PathVariable int id, Model model) {
        QuestionsEntity ourQuestion = questionRepository.getQuestionByID(id);

        model.addAttribute("category",ourQuestion.getCategory());
        model.addAttribute("code",ourQuestion.getId());
        model.addAttribute("questiontext",ourQuestion.getQuestion());
        model.addAttribute("questiontype",ourQuestion.getTypeQuestion());

        return "addquestion";
    }

}
