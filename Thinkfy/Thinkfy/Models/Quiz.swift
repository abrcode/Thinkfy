import Foundation

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
}

struct QuizCategory {
    let category: Category
    let questions: [QuizQuestion]
}

struct QuizResult: Identifiable {
    let id = UUID()
    let categoryName: String
    let score: Int
    let totalQuestions: Int
    let date: Date
    
    var percentage: Double {
        return Double(score) / Double(totalQuestions)
    }
}
