//
//  ContentView.swift
//  Thinkfy
//
//  Created by Aniket Rao on 27/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var quizViewModel = QuizViewModel()
    private let sessionManager = SessionManager.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("👋 Hi \(sessionManager.userName),")
                                .font(.title2)
                                .bold()
                            Text(sessionManager.hasCompletedOnboarding ? "Ready to Train Your Brain?" : "Welcome to Thinkfy!")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image("profile")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .padding()
                    
                    // Stats Card
                    StatsCardView(quizViewModel: quizViewModel)
                    
                    // Categories
                    VStack(alignment: .leading) {
                        Text("Featured Categories")
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 15) {
                            ForEach(quizViewModel.categories) { category in
                                NavigationLink(destination: QuizView(category: category)
                                    .environmentObject(quizViewModel)) {
                                    CategoryCard(category: category)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Recent Results
                    VStack(alignment: .leading) {
                        Text("Recent Results")
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)
                        
                        if quizViewModel.recentResults.isEmpty {
                            EmptyResultsView(vm: quizViewModel)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 2)
                                .padding(.horizontal)
                        } else {
                            ForEach(quizViewModel.recentResults) { result in
                                ResultCard(result: result)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                quizViewModel.loadUserData()
            }
        }
    }
}

struct StatsCardView : View {
    
    @ObservedObject var quizViewModel = QuizViewModel()
    
    var body: some View {
        HStack(spacing: 20) {
            // Left square box with current score
            VStack {
                Text("\(quizViewModel.userPoints)")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                Text("Current\nScore")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 100, height: 100)
            .background(Color.white)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 4)
            
            // Right side with total questions and progress
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Total Questions")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(quizViewModel.recentResults.reduce(0) { $0 + $1.totalQuestions })")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.orange)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Progress")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black.opacity(0.8))
                    
                    let totalAnswered = quizViewModel.recentResults.reduce(0) { $0 + $1.score }
                    let totalQuestions = quizViewModel.recentResults.reduce(0) { $0 + $1.totalQuestions }
                    let progress = totalQuestions > 0 ? Double(totalAnswered) / Double(totalQuestions) : 0
                    
                    ProgressView(value: progress)
                        .tint(.orange)
                    
                    HStack {
                        Text("\(totalAnswered)/\(totalQuestions)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray.opacity(0.8))
                        Spacer()
                        Text(String(format: "%.0f%%", progress * 100))
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                    }
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 4)
        .padding(.horizontal)
    }
}


struct CategoryCard: View {
    let category: Category
    
    var body: some View {
        VStack {
            Image(systemName: category.icon)
                .font(.largeTitle)
                .foregroundColor(Color(hex: category.color))
            Text(category.name)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct ResultCard: View {
    let result: QuizResult
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.purple.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Text("\(result.score)")
                        .foregroundColor(.purple)
                )
            
            VStack(alignment: .leading) {
                Text(result.categoryName)
                    .font(.headline)
                ProgressView(value: result.percentage)
                    .progressViewStyle(LinearProgressViewStyle())
            }
            
            Spacer()
            
            Text("\(result.score)/\(result.totalQuestions)")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
