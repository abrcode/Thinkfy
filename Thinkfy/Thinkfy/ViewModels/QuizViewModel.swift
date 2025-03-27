import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var userPoints: Int = 0
    @Published var userRanking: Int = 0
    @Published var recentResults: [QuizResult] = []
    
    init() {
        loadUserData()
        loadCategories()
    }
    
    private func loadUserData() {
        // TODO: Load from database
        self.userPoints = 2300
        self.userRanking = 32
    }
    
    private func loadCategories() {
        // TODO: Load from database
        self.categories = [
            Category(id: 1, name: "Animals", icon: "hare.fill", color: "#FFB080"),
            Category(id: 2, name: "Science", icon: "flask.fill", color: "#80B0FF"),
            Category(id: 3, name: "Math", icon: "ruler.fill", color: "#80FFB0"),
            Category(id: 4, name: "Geography", icon: "globe", color: "#FF80B0")
        ]
    }
}