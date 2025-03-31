import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var rotation = 0.0
    private let sessionManager = SessionManager.shared
    
    var body: some View {
        if isActive {
            if sessionManager.hasCompletedOnboarding {
                ContentView()
            } else {
                OnboardingContainerView()
            }
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "#007AFF").opacity(0.1),
                        Color(hex: "#34C759").opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(rotation))
                    
                    Text(sessionManager.hasCompletedOnboarding ? "Welcome Back, \(sessionManager.userName)!" : "Thinkfy")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text(sessionManager.hasCompletedOnboarding ? "Ready to Train Your Brain?" : "Train Your Brain")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.secondary)
                        .opacity(opacity)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                    withAnimation(.spring(response: 1.2, dampingFraction: 0.3, blendDuration: 0.5)) {
                        self.rotation = 360 // Single rotation with bouncy effect
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeOut(duration: 0.3)) {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}