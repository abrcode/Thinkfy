import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentSlide = 0
    @Published var userName = ""
    @Published var showOnboarding = true
    @Published var showNameInput = false
    @Published var showMainApp = false
    
    private let sessionManager = SessionManager.shared
    
    init() {
        // Check if user has completed onboarding
        if sessionManager.hasCompletedOnboarding {
            showOnboarding = false
            showNameInput = false
            showMainApp = true
            userName = sessionManager.userName
        }
    }
    
    let slides: [OnboardingSlide] = [
        OnboardingSlide(
            image: "brain.head.profile",
            title: "Welcome to Thinkfy",
            description: "Your personal quiz companion to test and enhance your knowledge across various subjects.",
            color: "#007AFF"
        ),
        OnboardingSlide(
            image: "trophy.fill",
            title: "Track Your Progress",
            description: "Earn points, climb rankings, and see your improvement over time with detailed statistics.",
            color: "#FF9500"
        ),
        OnboardingSlide(
            image: "star.fill",
            title: "Learn & Grow",
            description: "Challenge yourself with diverse categories and expand your knowledge horizons.",
            color: "#34C759"
        )
    ]
    
    func nextSlide() {
        withAnimation {
            if currentSlide < slides.count - 1 {
                currentSlide += 1
            } else {
                showOnboarding = false
                showNameInput = true
            }
        }
    }
    
    func previousSlide() {
        withAnimation {
            if currentSlide > 0 {
                currentSlide -= 1
            }
        }
    }
    
    func completeOnboarding() {
        withAnimation {
            sessionManager.completeOnboarding(userName: userName)
            showNameInput = false
            showMainApp = true
        }
    }
} 