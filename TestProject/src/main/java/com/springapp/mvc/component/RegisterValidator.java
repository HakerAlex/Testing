package com.springapp.mvc.component;


import com.springapp.mvc.forms.RegisterForm;
import org.apache.commons.validator.routines.EmailValidator;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Component
public class RegisterValidator implements Validator {
    public boolean supports(Class<?> clazz) {
        return RegisterForm.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        RegisterForm signupForm = (RegisterForm) target;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "name", "Имя пользователя не может быть пустым");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "surname", "surname", "Фамилия пользователя не может быть пустой");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "password", "Пароль не может быть пустым");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmpassword", "confirmpassword", "Подтверждение не может быть пустым");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "phone", "Телефон не может быть пустым");


        Pattern p = Pattern.compile("^((8|\\+38)[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{7,10}$");
        Matcher m = p.matcher(signupForm.getPhone());
        if (!m.matches()) {
            errors.rejectValue("phone", "phone", "Телефон не валидный");
        }

        if (!signupForm.getPassword().equals(signupForm.getConfirmpassword())) {
            errors.rejectValue("password", "password", "Пароли не совпадают");
        }

        if (signupForm.getPassword().length() < 6) {
            errors.rejectValue("password", "password", "Пароль меньше 6 символов");
        }

        if (!EmailValidator.getInstance().isValid(signupForm.getEmail())) {
            errors.rejectValue("email", "email", "Email адрес не валидный");
        }
    }
}