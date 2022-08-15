//
//  CreateQuiz.swift
//  Lab7_2022
//
//  Created by ICS 224 on 2022-03-09.
//
//http://10.51.10.9/capitals.json

import SwiftUI

/// Given a string that contains an URL, a connection to the URL will be established to get all data
/// in JSON format from the URL. After data has been received it will be converted and returned in a [String : String]
/// format.
///
/// Note: All JSON data from the dictionary will be got in random order
///
/// - Parameter stringURL: an String that contains the URL of a website which contains data in JSON format
/// - Returns fetchedQuestions: Fetched data will be returned in a [String : String] dictionary format
func getContentURL(stringURL : String) async -> [String : String] {
    
    var fetchedQuestions : [String : String] = [:];
    
    guard let url = URL(string: stringURL) else {
        return fetchedQuestions;
    };
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url);
        
        if let decodedQuestions = try? JSONDecoder().decode([String : String].self, from: data) {
            print(decodedQuestions)
            fetchedQuestions = decodedQuestions;
        }
        
    } catch  {
        print("ERROR")
    }
    
    return fetchedQuestions;
    
}


/// This struct will try to get the quiz questions from a given URL. The struct will still display when data fetched is not correct
/// or when the URL is incorrect
///
///  - Properties
///     questionsandAnswers - A [String : String ] dictionary that will hold the questions and answers
///     questionsURL - State String that will hold the answers given by the user
///     fetchedQuestions - State boolean that will hold if the actual displayed question is correct
///     questions - An array of Strings that will hold the questions fetched from the URL
///     answers - An array of Strings that will hold the answers fetched from the URL
struct CreateQuiz: View {
    @State var questionsAndAnswers : [String : String] = [:];
    @Binding var questionsURL : String;
    @Binding var fetchedQuestions : Bool;
    @Binding var questions : [String];
    @Binding var answers : [String];

    var body: some View {
        
        TextField("Quiz URL", text: $questionsURL)
            .multilineTextAlignment(.center)
            .frame(width: 300.0, height: 70.0)
        if(questionsURL.count != 0){
            Button("Launch Quiz") {
                Task {
                    questionsAndAnswers = [:];
                    questionsAndAnswers = await getContentURL(stringURL: questionsURL);
                    
                    if(questionsAndAnswers.count != 0){
                        fetchedQuestions = true;
                    }
                    
                    questionsURL = "";
                    
                    for (question, answer) in questionsAndAnswers {
                        questions.append(question);
                        answers.append(answer);
                    }
                }
            }
        }
    }
}


struct CreateQuiz_Previews: PreviewProvider {
    @State static var questionsURL : String = "";
    @State static var fetchedQuestions = false;
    @State static var questions : [String] = [];
    @State static var answers : [String] = [];
    
    static var previews: some View {
        CreateQuiz(questionsURL: $questionsURL, fetchedQuestions: $fetchedQuestions, questions: $questions, answers: $answers)
    }
}
