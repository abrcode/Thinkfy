import Foundation

struct QuizQuestion: Identifiable {
    let id = UUID()
    var question: String
    var options: [String]
    var correctAnswer: String
}

struct QuizCategory {
    var category: Category
    var questions: [QuizQuestion]
}

struct QuizResult: Identifiable {
    let id = UUID()
    var categoryName: String
    var score: Int
    var totalQuestions: Int
    var date: Date
    
    var percentage: Double {
        return Double(score) / Double(totalQuestions)
    }
}
