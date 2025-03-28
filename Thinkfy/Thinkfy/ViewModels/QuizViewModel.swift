import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var userPoints: Int = 0
    @Published var userRanking: Int = 0
    @Published var quizCategories: [QuizCategory] = []
    @Published var recentResults: [QuizResult] = []
    
    init() {
        setupData()
        loadUserData()
    }
    
    private func setupData() {
        // Sample Categories
        let categories = [
            Category(id: 1, name: "Science", icon: "atom", color: "#007AFF"),
            Category(id: 2, name: "History", icon: "book.closed", color: "#FF9500"),
            Category(id: 3, name: "Geography", icon: "globe", color: "#34C759"),
            Category(id: 4, name: "Mathematics", icon: "function", color: "#FF3B30")
        ]
        
        // Sample Questions for Science
        let scienceQuestions = [
            QuizQuestion(question: "What is the chemical symbol for gold?",
                        options: ["Au", "Ag", "Fe", "Cu"],
                        correctAnswer: "Au"),
            QuizQuestion(question: "Which planet is known as the Red Planet?",
                        options: ["Mars", "Venus", "Jupiter", "Saturn"],
                        correctAnswer: "Mars"),
            // Add more questions...
        ]
        
        // Sample Questions for History
        let historyQuestions = [
            QuizQuestion(question: "Who was the first President of the United States?",
                        options: ["George Washington", "Thomas Jefferson", "John Adams", "Benjamin Franklin"],
                        correctAnswer: "George Washington"),
            QuizQuestion(question: "In which year did World War II end?",
                        options: ["1945", "1944", "1946", "1943"],
                        correctAnswer: "1945"),
            // Add more questions...
        ]
        
        // Sample Questions for Geography
        let geographyQuestions = [
            QuizQuestion(question: "What is the capital of Japan?",
                        options: ["Tokyo", "Seoul", "Beijing", "Bangkok"],
                        correctAnswer: "Tokyo"),
            QuizQuestion(question: "Which is the largest ocean on Earth?",
                        options: ["Pacific", "Atlantic", "Indian", "Arctic"],
                        correctAnswer: "Pacific"),
            // Add more questions...
        ]
        
        // Sample Questions for Mathematics
        let mathQuestions = [
            QuizQuestion(question: "What is 7 x 8?",
                        options: ["56", "54", "58", "62"],
                        correctAnswer: "56"),
            QuizQuestion(question: "What is the square root of 144?",
                        options: ["12", "14", "10", "16"],
                        correctAnswer: "12"),
            // Add more questions...
        ]
        
        self.categories = categories
        self.quizCategories = [
            QuizCategory(category: categories[0], questions: scienceQuestions),
            QuizCategory(category: categories[1], questions: historyQuestions),
            QuizCategory(category: categories[2], questions: geographyQuestions),
            QuizCategory(category: categories[3], questions: mathQuestions)
        ]
    }
    
    private func loadUserData() {
        // Mock data for recent results
        recentResults = [
            QuizResult(categoryName: "Science", score: 8, totalQuestions: 10, date: Date()),
            QuizResult(categoryName: "History", score: 7, totalQuestions: 10, date: Date().addingTimeInterval(-86400)),
            QuizResult(categoryName: "Mathematics", score: 9, totalQuestions: 10, date: Date().addingTimeInterval(-172800))
        ]
        
        self.userPoints = 2300
        self.userRanking = 32
    }
    
    func getQuestions(for category: Category) -> [QuizQuestion] {
        return quizCategories.first(where: { $0.category.id == category.id })?.questions ?? []
    }
    
    func saveQuizResult(category: Category, score: Int, totalQuestions: Int) {
        let result = QuizResult(
            categoryName: category.name,
            score: score,
            totalQuestions: totalQuestions,
            date: Date()
        )
        recentResults.insert(result, at: 0)
        if recentResults.count > 5 {
            recentResults.removeLast()
        }
        
        // Update user points (10 points per correct answer)
        userPoints += score * 10
    }
}
