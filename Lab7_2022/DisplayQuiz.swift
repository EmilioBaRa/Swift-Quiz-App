//
//  DisplayQuiz.swift
//  Lab7_2022
//
//  Created by ICS 224 on 2022-03-09.
//

import SwiftUI


/// This struct will display the quiz questions, will save the correct answers given by the user
/// and will stop displaying after all questions have been displayed and answer by the user.
///
///  - Properties
///     userAnswer - State String that will hold the answers given by the user
///     correctResponse - State boolean that will hold if the actual displayed question is correct
///     questions - A constant  array of Strings that will hold the questions fetched from the URL
///     answers - A constant array of Strings that will hold the answers fetched from the URL
///     actualQuestion - Integer representation of the index of the current question. When the index is more than the questions and answers arrays, the struct will stop displaying more questions
///     countCorrects - Integer representation of the correct answers given by a user
struct DisplayQuiz: View {
    
    @State var userAnswer : String = "";
    @State var correctResponse : Bool = false;
    
    let questions : [String];
    let answers : [String];
    
    @Binding var actualQuestion : Int;
    @Binding var countCorrects : Int;

    var body: some View {
        if(questions.count > actualQuestion){
            Text(questions[actualQuestion]);
            TextField("Answer", text: Binding(
                get: {
                    userAnswer;
                }, set: {
                    userAnswer = $0;
                    correctResponse = userAnswer == answers[actualQuestion] ? true : false;
                }
            )).padding(.leading)
            if(correctResponse){
                Text("Correct");
            }
            else{
                Text("Incorrect");
            }
            Button("Next"){
                actualQuestion += 1;
        
                if(correctResponse){
                countCorrects += 1;
                }
        
                correctResponse = false;
                userAnswer = "";
            }.padding()
        }
    }
}

struct DisplayQuiz_Previews: PreviewProvider {
    static var questions : [String] = [];
    static var answers : [String] = [];
    @State static var actualQuestion : Int = 0;
    @State static var countCorrects : Int = 0;
    
    static var previews: some View {
        DisplayQuiz(questions: questions, answers: answers, actualQuestion: $actualQuestion, countCorrects: $countCorrects);
    }
}
