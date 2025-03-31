import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            if onboardingViewModel.showOnboarding {
                OnboardingView(viewModel: onboardingViewModel)
            } else if onboardingViewModel.showNameInput {
                NameInputView(viewModel: onboardingViewModel)
            } else if onboardingViewModel.showMainApp {
                ContentView()
            }
        }
    }
} 