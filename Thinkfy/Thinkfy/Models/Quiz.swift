import Foundation

struct Quiz: Identifiable {
    let id: Int
    let categoryId: Int
    let question: String
    let options: [String]
    let correctAnswer: String
    let explanation: String?
}

struct QuizResult: Identifiable {
    let id: Int
    let categoryId: Int
    let score: Int
    let totalQuestions: Int
    let date: Date
}