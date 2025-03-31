import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var userPoints: Int = 0
    @Published var userRanking: Int = 0
    @Published var quizCategories: [QuizCategory] = []
    @Published var recentResults: [QuizResult] = []
    
    private let dbManager = DatabaseManager.shared
    
    init() {
        loadData()
        loadUserData()
    }
    
    private func loadData() {
        // Load categories from database
        let categories = dbManager.getAllCategories()
        self.categories = categories
        
        // Load questions for each category
        self.quizCategories = categories.map { category in
            let questions = dbManager.getQuestions(for: category.id)
            return QuizCategory(category: category, questions: questions)
        }
    }
    
    func loadUserData() {
        // Load recent results from database
        recentResults = dbManager.getRecentResults()
        
        // Calculate user points based on results (10 points per correct answer)
        userPoints = recentResults.reduce(0) { $0 + ($1.score * 10) }
        
        // For now, ranking is static as we don't have multi-user support
        userRanking = 1
    }
    
    func getQuestions(for category: Category) -> [QuizQuestion] {
        return quizCategories.first(where: { $0.category.id == category.id })?.questions ?? []
    }
    
    func saveQuizResult(category: Category, score: Int, totalQuestions: Int) {
        // Check if there's an existing result for this category
        if let existingResult = recentResults.first(where: { $0.categoryName == category.name }) {
            // Update existing result if new score is better
            if score > existingResult.score {
                dbManager.updateQuizResult(categoryId: category.id, score: score, totalQuestions: totalQuestions)
            }
        } else {
            // Save new result if no existing result for this category
            dbManager.saveQuizResult(categoryId: category.id, score: score, totalQuestions: totalQuestions)
        }
        
        // Reload recent results and user data
        DispatchQueue.main.async {
            self.loadUserData()
            self.objectWillChange.send()
        }
    }
}
