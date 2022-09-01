
/////////////////////////////////// typeProcedure
db.typesProcedure.insertMany([
    {
        tp_name: "Электрокардиография", // самая дешевая услуга
        cost: 1500,
        equipment: {
            eq_name: "Электрокардиограф",
            eq_dateProd: "21.10.20",
            eq_price: 50000
        }

    },
    {
        tp_name: "Гастроскопия",
        cost: 2500,
        equipment: {
            eq_name: "Эндоскоп",
            eq_dateProd: "22.10.20",
            eq_price: 40000
        }
    },
    {
        tp_name: "Электрофорез",
        cost: 2200,
        equipment: {
            eq_name: "Электрофорез",
            eq_dateProd: "25.10.20",
            eq_price: 45000
        }
    }
])


/////////////////////////////////// doctor
db.doctors.insertMany([
    {
        d_name: "Артем",
        d_surname: "Ермаков",
        d_patronymic: "Вадимович",
        d_phone: "89068531355"
    },
    {
        d_name: "Андрей",
        d_surname: "Погольдин",
        d_patronymic: "Максимович",
        d_phone: "89118771355"
    },
    {
        d_name: "Ай",
        d_surname: "Болит",
        d_patronymic: "Сергеевич",
        d_phone: "89017775555"
    },
    {
        d_name: "Иван",
        d_surname: "Иванов",
        d_patronymic: "Иванович",
        d_phone: "89011115555"
    }
])


db.visits.insertMany([
    {
        // не ходил на процедуру к И.И. Иванову
        // Ходил на электрофорез
        // Ходил к Ермаков и на прием и на процедуру
        p_name: "Алексей",
        p_surname: "Котов",
        p_patronymic: "Иванович",
        p_phone: "89059761111",

        reception: [ { // прием

            _id : ObjectId("626af49dbf9f4c3693c25330"),
            rec_date : "2022-04-23", // дата приема
            doc_id : ObjectId("627d635843dc640eb72974d3"), //Ермаков
            type_recept: { // тип приема
                id: 0,
                rec_name: "Первичный прием"
            },

             schedule_day: "saturday",
            schedule_day_type : "0",

        }
        ],

        procedur: [ // процедура
            {
                _id : ObjectId("626af49dbf9f4c3693c25331"),
                proc_date : "2022-04-22", // дата процедуры
                doc_id : ObjectId("627d635843dc640eb72974d3"), // доктор Ермаков
                proc_id : ObjectId("627d634543dc640eb72974d1"), // Электрофорез

                schedule_day: "friday", // расписание
                schedule_day_type : "1", // 1 - здоровые 0-больные

            },
        ]
    },
    {
        // Ходил к наибольшему количеству врачей
        p_name: "Роман",
        p_surname: "Остановка",
        p_patronymic: "Олегович",
        p_phone: "89005553535", // телефон

        reception: [ { // прием

            _id : ObjectId("626af49dbf9f4c3693c25332"),
            rec_date : "2022-04-25", // дата приема
            doc_id : ObjectId("627d635843dc640eb72974d5"), //Айболит
            type_recept: { // тип приема
                id: 1,
                rec_name: "Вторичный прием"
            },

            schedule_day: "monday",
            schedule_day_type : "0",

        }
        ],

        procedur: [ // процедура
            {
                _id : ObjectId("626af49dbf9f4c3693c25333"),
                proc_date : "2022-04-26", // дата процедуры
                doc_id : ObjectId("627d635843dc640eb72974d6"), // доктор Иванов Иван Иванович
                proc_id : ObjectId("627d634543dc640eb72974d0"), // Гастроскопия

                schedule_day: "tuesday", // расписание
                schedule_day_type : "1", // 1 - здоровые 0-больные

            },
        ]
    }
])
