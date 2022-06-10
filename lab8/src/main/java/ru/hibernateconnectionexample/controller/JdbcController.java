package ru.hibernateconnectionexample.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.hibernateconnectionexample.dao.DoctorDao;

@Controller
@RequestMapping("/jdbc")
public class JdbcController {

    private final DoctorDao DoctorDao;

    @Autowired
    public JdbcController(DoctorDao DoctorDao) {this.DoctorDao = DoctorDao;}

    @GetMapping
    public String list(Model model) {
        model.addAttribute("Doctors", DoctorDao.findAll());
        return "jdbc";
    }
}
