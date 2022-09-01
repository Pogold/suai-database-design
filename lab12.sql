Пример обновления данных
db.typesProcedure.updateOne({tp_name : "Гастроскопия"} ,{$set: {cost : 2600}});

Пример удаления данных
db. typesProcedure.deleteOne({tp_name: "Гастроскопия"});

а. пациенты, приходившие на любые процедуры, связанные с электрофорезом
db.visits.aggregate([
    {
        $lookup: {
            from: "typesProcedure",
            localField: "procedur.proc_id",
            foreignField: "_id",
            as: "visit_tp_proc"
        }
        },
    {
        $match: {
            "visit_tp_proc.tp_name": {$regex: "Электрофорез"}
        }
    }
]);

б. пациент, приходивший к одному врачу и на прием и на процедуру

db.visits.aggregate([
    {
        $project : {
            _id : 1,
            "p_name": "$p_name",
            "p_patronymic": "$p_patronymic",
            "p_surname": "$p_surname",
            filterThisDoc : {
                $cond : {
                    if  : {
                        $eq : ["$procedur.proc_doc_id", "$reception.rec_doc_id"]
                    },
                    then : 1,
                    else  : 0
                }
            }
        }
    },
    {
        $match : {
            filterThisDoc : 1
        }
    },
    {
        $project : {
            filterThisDoc : 0
        }
    }
]);
в. процедуры с наименьшей стоимостью

db.typesProcedure.aggregate([
    {
        $project: {
            _id: 1,
            tp_name: 1,
            cost: 1
        }
    },
    {
        $group: {
            _id: null,
            procedure_data: {"$push": "$$ROOT"},
            min_cost: {$min: "$cost"}

        }
    },
    { $unwind: "$procedure_data" },
    {
        $project: {
            "_id": "$procedure_data._id",
            "tp_name": "$procedure_data.tp_name",
             "cost": "$procedure_data.cost",
            min_cost: 1,
            "is_eq": {$eq: ["$procedure_data.cost", "$min_cost"]}
        }
    },
    { $match: {"is_eq": true} }
]);

г. пациент, ходивший к наибольшему количеству врачей

db.visits.aggregate([
    {
        "$project": {
            "doctors_id": { "$setUnion": [ "$reception.rec_doc_id", "$procedur.proc_doc_id" ] },
            "p_name": "$p_name",
            "p_patronymic": "$p_patronymic",
            "p_surname": "$p_surname",
        }
    },
    {
        "$project": {
            doctors_count: { $max: { $size: "$doctors_id" } },
            "p_name": "$p_name",
            "p_patronymic": "$p_patronymic",
            "p_surname": "$p_surname",
        }
    },
    {
        $group: {
            _id: null,
            max_doctors_count: {$max: "$doctors_count"},
            patient_data: {"$push": "$$ROOT"}
        }
    },
    { $unwind: "$patient_data" },
    {
        $project: {
            "p_name": "$patient_data.p_name",
            "p_patronymic": "$patient_data.p_patronymic",
            "p_surname": "$patient_data.p_surname",
            max_doctors_count: 1,
            "is_eq": {$eq: ["$patient_data.doctors_count", "$max_doctors_count"]}
        }
    },
    { $match: {"is_eq": true} }
])

д. пациент, не ходивший на процедуры к Иванову Ивану Ивановичу
db.visits.aggregate([
    {
        $lookup: {
            from: "doctors",
            localField: "procedur.proc_doc_id",
            foreignField: "_id",
            as: "visit_doc"
        }
    },
    { $match: { $and: [ { "visit_doc.d_name": {$ne: "Иван"}}, { "visit_doc.d_surname": {$ne: "Иванов"}},
                { "visit_doc.d_patronymic": {$ne: "Иванович"}}] } }
]);
