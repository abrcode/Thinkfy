import SwiftUI

struct QuizCompletionView: View {
    let score: Int
    let totalQuestions: Int
    let category: Category
    let onDismiss: () -> Void
    
    @State private var showAnimation = false
    @State private var showContent = false
    @State private var showConfetti = false
    
    private var percentage: Double {
        Double(score) / Double(totalQuestions) * 100
    }
    
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissWithAnimation()
                }
            
            // Result Card
            VStack(spacing: 24) {
                // Trophy or Medal
                ZStack {
                    Circle()
                        .fill(Color(hex: category.color).opacity(0.1))
                        .frame(width: 120, height: 120)
                    
                    Circle()
                        .fill(Color(hex: category.color).opacity(0.2))
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: getResultIcon())
                        .font(.system(size: 40))
                        .foregroundColor(Color(hex: category.color))
                }
                .scaleEffect(showAnimation ? 1 : 0.5)
                .opacity(showAnimation ? 1 : 0)
                
                // Result Text
                VStack(spacing: 16) {
                    Text("Quiz Complete!")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                    
                    Text("Your Score")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Text("\(score)/\(totalQuestions)")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(Color(hex: category.color))
                    
                    // Progress Ring
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 8)
                        
                        Circle()
                            .trim(from: 0, to: showContent ? percentage/100 : 0)
                            .stroke(Color(hex: category.color), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut(duration: 1.0), value: showContent)
                        
                        Text("\(Int(percentage))%")
                            .font(.title2.bold())
                            .foregroundColor(Color(hex: category.color))
                    }
                    .frame(width: 100, height: 100)
                    
                    // Performance Message
                    Text(getPerformanceMessage())
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)
                
                // Done Button
                Button(action: dismissWithAnimation) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: category.color))
                        .cornerRadius(15)
                }
                .padding(.top)
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)
            }
            .padding(32)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 20)
            .padding(.horizontal, 24)
            .offset(y: showAnimation ? 0 : 50)
            
            // Confetti Effect
            if showConfetti && percentage >= 70 {
                ConfettiView()
            }
        }
        .onAppear {
            animateEntrance()
        }
    }
    
    private func animateEntrance() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            showAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeOut(duration: 0.5)) {
                showContent = true
            }
            if percentage >= 70 {
                showConfetti = true
            }
        }
    }
    
    private func dismissWithAnimation() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showAnimation = false
            showContent = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onDismiss()
        }
    }
    
    private func getResultIcon() -> String {
        if percentage >= 90 {
            return "star.circle.fill"
        } else if percentage >= 70 {
            return "medal.fill"
        } else if percentage >= 50 {
            return "hand.thumbsup.fill"
        } else {
            return "book.fill"
        }
    }
    
    private func getPerformanceMessage() -> String {
        if percentage >= 90 {
            return "Outstanding! You're a \(category.name) expert! 🌟"
        } else if percentage >= 70 {
            return "Great job! You've got solid knowledge! 🎉"
        } else if percentage >= 50 {
            return "Good effort! Keep practicing to improve! 💪"
        } else {
            return "Don't worry! Practice makes perfect! 📚"
        }
    }
}

struct ConfettiView: View {
    @State private var animate = false
    
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange]
    
    var body: some View {
        ZStack {
            ForEach(0..<50) { i in
                Circle()
                    .fill(colors[i % colors.count])
                    .frame(width: 8, height: 8)
                    .offset(x: animate ? randomOffset() : 0,
                            y: animate ? 1000 : -100)
                    .opacity(animate ? 0 : 1)
                    .animation(
                        Animation.linear(duration: 2.5)
                            .delay(Double.random(in: 0...0.5))
                            .repeatForever(autoreverses: false),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
    
    private func randomOffset() -> CGFloat {
        CGFloat.random(in: -150...150)
    }
}
