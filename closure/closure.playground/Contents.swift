import UIKit

//
//  closure.swift
//  data science ML AI
//
//  Created by amber on 2/18/25.
//


struct Student {
    let name: String
    var testScore: Int
}
//create a list of students using Student constructor
let students = [Student(name:"luke", testScore: 88),
                Student(name:"Hab", testScore: 75)]

//closure
//Use a named parameter  and explicit return statement
//var topStudnetFilter:(Student)->Bool={a in return a.testScore>80
//}
//use shorthand
var topStudnetFilterClosure:(Student)->Bool={$0.testScore>80}

//Or use the following function as an alternative
//function:

func topStudnetFilterFunction(student: Student)->Bool{return student.testScore>70
}

let topStudents = students.filter(topStudnetFilterClosure)
//let topStudents = students.filter(topStudnetFilterFunction)

for topStudent in topStudents {
    print(topStudent.name)
}


