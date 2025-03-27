import SwiftUI

struct QuizView: View {
    let category: Category
    @State private var currentQuestion = 1
    @State private var totalQuestions = 20
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            // Progress Header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("\(currentQuestion)/\(totalQuestions)")
                    .foregroundColor(.green)
                
                Spacer()
                
                Button("Skip") {
                    // Handle skip
                }
                .foregroundColor(.orange)
            }
            .padding()
            
            // Progress Bar
            ProgressView(value: Float(currentQuestion) / Float(totalQuestions))
                .progressViewStyle(LinearProgressViewStyle())
                .padding(.horizontal)
            
            // Question
            Text("If the area of a square is 64 square units, what is the length of one of its sides?")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            // Options
            VStack(spacing: 15) {
                AnswerButton(text: "8 Units", isSelected: true, isCorrect: true)
                AnswerButton(text: "12 Units", isSelected: false, isCorrect: false)
                AnswerButton(text: "4 Units", isSelected: false, isCorrect: false)
                AnswerButton(text: "16 Units", isSelected: false, isCorrect: false)
            }
            .padding()
            
            Spacer()
            
            // Report Question
            Button(action: {}) {
                HStack {
                    Image(systemName: "exclamationmark.circle")
                    Text("Report Question")
                }
                .foregroundColor(.gray)
            }
            .padding(.bottom)
        }
        .navigationBarHidden(true)
    }
}

struct AnswerButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    
    var backgroundColor: Color {
        if isSelected {
            return isCorrect ? .green : .red
        }
        return Color(.systemOrange).opacity(0.2)
    }
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(isSelected ? .white : .black)
            Spacer()
            if isSelected && isCorrect {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

#Preview {
    QuizView(category: Category(id: 1, name: "Math", icon: "ruler.fill", color: "#80FFB0"))
}
