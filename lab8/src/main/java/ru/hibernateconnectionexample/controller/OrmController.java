package ru.hibernateconnectionexample.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.hibernateconnectionexample.dao.PatientDao;

@Controller
@RequestMapping("/orm")
public class OrmController {

    private final PatientDao PatientDao;

    @Autowired
    public OrmController(PatientDao PatientDao) {
        this.PatientDao = PatientDao;
    }

    @GetMapping
    public String list(Model model) {
        model.addAttribute("patients", PatientDao.findAll());
        return "orm";
    }
}
