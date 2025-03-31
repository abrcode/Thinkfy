import SwiftUI

struct NameInputView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var nameFieldOffset: CGFloat = 50
    @State private var nameFieldOpacity: Double = 0
    @State private var buttonOffset: CGFloat = 50
    @State private var buttonOpacity: Double = 0
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#007AFF").opacity(0.1),
                    Color(hex: "#34C759").opacity(0.1)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Welcome Icon
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                // Welcome Text
                Text("Welcome to Thinkfy!")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                // Name Input Field
                TextField("Enter your name", text: $viewModel.userName)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(hex: "#007AFF") , lineWidth: 2)
                    }
                    .offset(y: nameFieldOffset)
                    .opacity(nameFieldOpacity)
                    .padding()
                   
                
                // Start Button
                Button(action: {
                    if !viewModel.userName.isEmpty {
                        viewModel.completeOnboarding()
                    }
                }) {
                    Text("Start Quizing!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "#007AFF"),
                                    Color(hex: "#34C759")
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                }
                .disabled(viewModel.userName.isEmpty)
                .offset(y: buttonOffset)
                .opacity(buttonOpacity)
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                nameFieldOffset = 0
                nameFieldOpacity = 1
            }
            
            withAnimation(.easeOut(duration: 0.8).delay(0.5)) {
                buttonOffset = 0
                buttonOpacity = 1
            }
        }
    }
} 
