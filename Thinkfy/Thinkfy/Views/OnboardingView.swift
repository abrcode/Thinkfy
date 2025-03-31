import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Background color based on current slide
            Color(hex: viewModel.slides[viewModel.currentSlide].color)
                .opacity(0.1)
                .ignoresSafeArea()
            
            VStack {
                // Page Control
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.slides.count) { index in
                        Circle()
                            .fill(viewModel.currentSlide == index ? Color(hex: viewModel.slides[index].color) : Color.gray.opacity(0.5))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 50)
                
                // Slides
                TabView(selection: $viewModel.currentSlide) {
                    ForEach(Array(viewModel.slides.enumerated()), id: \.element.id) { index, slide in
                        VStack(spacing: 20) {
                            Image(systemName: slide.image)
                                .font(.system(size: 100))
                                .foregroundColor(Color(hex: slide.color))
                                .padding(.bottom, 20)
                            
                            Text(slide.title)
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Text(slide.description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 32)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: viewModel.currentSlide)
                
                Spacer()
                
                // Navigation Buttons
                HStack {
                    if viewModel.currentSlide > 0 {
                        Button(action: viewModel.previousSlide) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: viewModel.nextSlide) {
                        Text(viewModel.currentSlide == viewModel.slides.count - 1 ? "Get Started" : "Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 120)
                            .padding()
                            .background(Color(hex: viewModel.slides[viewModel.currentSlide].color))
                            .cornerRadius(25)
                    }
                    .padding()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
        }
    }
} 