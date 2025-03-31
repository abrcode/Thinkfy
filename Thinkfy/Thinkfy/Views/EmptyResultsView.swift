import SwiftUI

struct EmptyResultsView: View {
    @State private var isAnimating = false
    @State private var showText = false
    @ObservedObject var vm: QuizViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Animated Illustration
            ZStack {
                // Background Circle
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 120, height: 120)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                
                // Trophy Icon
                Image(systemName: "trophy")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
            }
            .padding(.top, 20)
            
            // Text Content
            VStack(spacing: 12) {
                Text("No Quiz Results Yet")
                    .font(.title2)
                    .bold()
                    .opacity(showText ? 1 : 0)
                    .offset(y: showText ? 0 : 20)
                
                Text("Complete quizzes to see your results here")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .opacity(showText ? 1 : 0)
                    .offset(y: showText ? 0 : 20)
            }
            .padding(.horizontal)
            
            // Navigation Link
            NavigationLink(destination: QuizView(category: vm.categories[0])
                .environmentObject(vm)) {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                    Text("Start a Quiz")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(25)
            }
            .opacity(showText ? 1 : 0)
            .offset(y: showText ? 0 : 20)
            .padding(.top, 10)
        }
        .padding()
        .onAppear {
            // Start animations
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
            
            withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
                showText = true
            }
        }
    }
} 
