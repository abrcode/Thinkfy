import SwiftUI

struct QuizView: View {
    let category: Category
    @StateObject private var viewModel = QuizViewModel()
    @State private var currentQuestionIndex = 0
    @State private var correctAnswers = 0
    @State private var showingScore = false
    @State private var questions: [QuizQuestion] = []
    @State private var selectedAnswer: String? = nil
    @State private var showFeedback = false
    @State private var isCorrect = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background color
            Color(hex: category.color)
                .opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Top Stats
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                            .font(.title3)
                            .foregroundColor(.gray)
                        ProgressView(value: Double(currentQuestionIndex + 1), total: Double(questions.count))
                            .tint(Color(hex: category.color))
                    }
                    // Score
                    Text("Score: \(correctAnswers)")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                if !questions.isEmpty {
                    ScrollView {
                        VStack(spacing: 32) {
                            // Question Card
                            VStack(spacing: 16) {
                                Image(systemName: category.icon)
                                    .font(.system(size: 40))
                                    .foregroundColor(Color(hex: category.color))
                                
                                Text(questions[currentQuestionIndex].question)
                                    .font(.title2)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 32)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                            
                            // Options
                            VStack(spacing: 16) {
                                ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                                    AnswerButton(
                                        text: option,
                                        isSelected: selectedAnswer == option,
                                        isCorrect: showFeedback ? option == questions[currentQuestionIndex].correctAnswer : nil,
                                        isWrong: showFeedback ? selectedAnswer == option && option != questions[currentQuestionIndex].correctAnswer : nil,
                                        action: {
                                            if !showFeedback {
                                                selectedAnswer = option
                                                isCorrect = option == questions[currentQuestionIndex].correctAnswer
                                                showFeedback = true
                                                
                                                // Wait for 1.5 seconds before moving to next question
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                    moveToNextQuestion()
                                                }
                                            }
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationBarTitleDisplayMode(.inline)
        .overlay {
            if showingScore {
                QuizCompletionView(
                    score: correctAnswers,
                    totalQuestions: questions.count,
                    category: category
                ) {
                    viewModel.saveQuizResult(
                        category: category,
                        score: correctAnswers,
                        totalQuestions: questions.count
                    )
                    dismiss()
                }
            }
        }
        .onAppear {
            questions = viewModel.getQuestions(for: category)
        }
    }
    
    private func moveToNextQuestion() {
        if isCorrect {
            correctAnswers += 1
        }
        
        if currentQuestionIndex + 1 < questions.count {
            withAnimation {
                currentQuestionIndex += 1
                selectedAnswer = nil
                showFeedback = false
            }
        } else {
            showingScore = true
        }
    }
}

struct AnswerButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool?
    let isWrong: Bool?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.title3)
                    .padding()
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if isCorrect == true {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                } else if isWrong == true {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .font(.title2)
                }
            }
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(borderColor, lineWidth: isSelected ? 2 : 1)
            )
        }
        .disabled(isCorrect != nil || isWrong != nil)
    }
    
    private var backgroundColor: Color {
        if isCorrect == true {
            return Color.green.opacity(0.2)
        } else if isWrong == true {
            return Color.red.opacity(0.2)
        } else {
            return isSelected ? Color.blue.opacity(0.1) : Color.white
        }
    }
    
    private var borderColor: Color {
        if isCorrect == true {
            return .green
        } else if isWrong == true {
            return .red
        } else {
            return isSelected ? .blue : Color.gray.opacity(0.3)
        }
    }
}
