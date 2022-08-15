//
//  ResultsQuiz.swift
//  Lab7_2022
//
//  Created by ICS 224 on 2022-03-09.
//

import SwiftUI

/// This struct will be displayed after the DisplayQuiz struct has displayed all questions.
/// And will show the correct, incorrect, and percentage achieved of correct answers.
/// When the Done button is clicked. All the data from the quiz will be deleted.
///
///  - Properties
///     questionsURL - A String that will hold a URL with JSON data
///     fetchedQuestions - A Boolean that will hold if the CreateQuiz struct has accomplished its purpose
///     questions - An array of Strings that will hold the questions fetched from the URL
///     answers - An array of Strings that will hold the answers fetched from the URL
///     actualQuestion - Integer representation of the index of the current question (more details on DisplayQuiz struct)
///     countCorrects - Integer representation of the correct answers given by a user
struct ResultsQuiz: View {
    @Binding var questionsURL : String;
    @Binding var fetchedQuestions : Bool;
    @Binding var questions : [String];
    @Binding var answers : [String];
    @Binding var actualQuestion : Int;
    @Binding var countCorrects : Int;
    
    /// The cleanQuiz function will clean all quiz values. It will make the program display the CreateQuiz struct
    /// And will make the "CreateQuiz > DisplayQuiz > ResultQuiz" cycle start again
    /// - Returns: No return values
    func cleanQuiz() -> Void {
        questionsURL = "";
        fetchedQuestions = false;
        questions = [];
        answers = [];
        actualQuestion = 0;
        countCorrects = 0;
    }

    var body: some View {
        Text("Correct: \(countCorrects)");
        Text("Wrong: \(questions.count - countCorrects)");
        Text("Score: \((Float(countCorrects)/Float(questions.count)) * 100.0)%");
        Button("Done"){
            cleanQuiz();
        }.padding()
    }
}

struct ResultsQuiz_Previews: PreviewProvider {
    @State static var questionsURL : String = "";
    @State static var fetchedQuestions : Bool = false;
    @State static var questions : [String] = [];
    @State static var answers : [String] = [];
    @State static var actualQuestion : Int = 0;
    @State static var countCorrects : Int = 0;

    static var previews: some View {
        ResultsQuiz(questionsURL: $questionsURL, fetchedQuestions: $fetchedQuestions, questions: $questions, answers: $answers, actualQuestion: $actualQuestion, countCorrects: $countCorrects);
    }
}
