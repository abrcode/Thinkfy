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
                            Text("Great to see you again!")
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
                    HStack {
                        Spacer()
                        VStack {
                            Text("\(quizViewModel.userPoints)")
                                .font(.title2)
                                .bold()
                            Text("points")
                                .foregroundColor(.gray)
                        }
//                        Divider()
//                            .frame(height: 40)
//                        VStack {
//                            Text("\(quizViewModel.userRanking)")
//                                .font(.title2)
//                                .bold()
//                            Text("Ranking")
//                                .foregroundColor(.gray)
//                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemOrange).opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
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
