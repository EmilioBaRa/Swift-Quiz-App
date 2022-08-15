//
//  ContentView.swift
//  Lab7_2022
//
//  Created by ICS 224 on 2022-03-08.
//


import SwiftUI

/// This struct will be the main logic handler for the quiz display. The CreateQuiz struct will handle
///  which information and operations are made each time. The struct first will display the CreateQuiz struct.
///  When the CreateQuiz operations are handled the DisplayQuiz struct will be displayed. Finally, the ResultQuiz struct will
///  be displayed. After the ResultQuiz struct the cycle will repeat from the CreateQuiz struct
///
///  - Properties
///     questionsURL - A String that will hold a URL with JSON data
///     fetchedQuestions - A Boolean that will hold if the CreateQuiz struct has accomplished its purpose
///     questions - An array of Strings that will hold the questions fetched from the URL
///     answers - An array of Strings that will hold the answers fetched from the URL
///     actualQuestion - Integer representation of the index of the current question (more details on DisplayQuiz struct)
///     countCorrects - Integer representation of the correct answers given by a user
struct ContentView: View {
    @State var questionsURL : String = "";
    @State var fetchedQuestions : Bool = false;
    @State var questions : [String] = [];
    @State var answers : [String] = [];
    @State var actualQuestion : Int = 0;
    @State var countCorrects : Int = 0;
    
    var body: some View {
        if(!fetchedQuestions){
            CreateQuiz(questionsURL: $questionsURL, fetchedQuestions: $fetchedQuestions, questions: $questions, answers: $answers);
        }
        else{
            if(questions.count > actualQuestion){
                DisplayQuiz(questions: questions, answers: answers, actualQuestion: $actualQuestion, countCorrects: $countCorrects);
            }
            else{
                ResultsQuiz(questionsURL: $questionsURL, fetchedQuestions: $fetchedQuestions, questions: $questions, answers: $answers, actualQuestion: $actualQuestion, countCorrects: $countCorrects);
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
