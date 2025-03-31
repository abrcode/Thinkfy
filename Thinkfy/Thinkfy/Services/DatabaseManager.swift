import Foundation
import SQLite3

class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    
    private init() {
        setupDatabase()
        seedInitialData()
    }
    
    private func setupDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("quizDatabase.sqlite")
        
        print("Database file path: \(fileURL.path)")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
            return
        }
        
        createTables()
    }
    
    private func createTables() {
        // Create tables for categories, quizzes, and results
        let createCategoryTable = """
        CREATE TABLE IF NOT EXISTS categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            icon TEXT NOT NULL,
            color TEXT NOT NULL
        );
        """
        
        let createQuizTable = """
        CREATE TABLE IF NOT EXISTS quizzes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_id INTEGER,
            question TEXT NOT NULL,
            options TEXT NOT NULL,
            correct_answer TEXT NOT NULL,
            explanation TEXT,
            FOREIGN KEY(category_id) REFERENCES categories(id)
        );
        """
        
        let createResultTable = """
        CREATE TABLE IF NOT EXISTS results (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_id INTEGER,
            score INTEGER NOT NULL,
            total_questions INTEGER NOT NULL,
            date TEXT NOT NULL,
            FOREIGN KEY(category_id) REFERENCES categories(id)
        );
        """
        
        executeSQLStatement(createCategoryTable)
        executeSQLStatement(createQuizTable)
        executeSQLStatement(createResultTable)
    }
    
    private func executeSQLStatement(_ sql: String) {
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Successfully executed statement")
            }
        }
        sqlite3_finalize(statement)
    }
    
    // MARK: - Data Seeding
    private func seedInitialData() {
        // Check if categories table is empty
        let query = "SELECT COUNT(*) FROM categories"
        var statement: OpaquePointer?
        var count: Int32 = 0
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                count = sqlite3_column_int(statement, 0)
            }
        }
        sqlite3_finalize(statement)
        
        if count == 0 {
            // Seed categories
            for category in SeedData.categories {
                insertCategory(name: category.name, icon: category.icon, color: category.color)
            }
            
            // Seed questions with shuffled options
            for question in SeedData.questions {
                let (shuffledOptions, correctAnswer) = SeedData.shuffleOptions(options: question.options, correctAnswer: question.correctAnswer)
                insertQuestion(
                    categoryName: question.category,
                    question: question.question,
                    options: shuffledOptions,
                    correctAnswer: correctAnswer
                )
            }
        }
    }
    
    // MARK: - CRUD Operations
    func insertCategory(name: String, icon: String, color: String) -> Int64? {
        let sql = "INSERT INTO categories (name, icon, color) VALUES (?, ?, ?)"
        var statement: OpaquePointer?
        var lastId: Int64?
        
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (icon as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (color as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                lastId = sqlite3_last_insert_rowid(db)
            }
        }
        sqlite3_finalize(statement)
        return lastId
    }
    
    func insertQuestion(categoryName: String, question: String, options: [String], correctAnswer: String) {
        // Get category ID
        let getCategoryIdSQL = "SELECT id FROM categories WHERE name = ?"
        var statement: OpaquePointer?
        var categoryId: Int32 = 0
        
        if sqlite3_prepare_v2(db, getCategoryIdSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (categoryName as NSString).utf8String, -1, nil)
            if sqlite3_step(statement) == SQLITE_ROW {
                categoryId = sqlite3_column_int(statement, 0)
            }
        }
        sqlite3_finalize(statement)
        
        // Insert question
        let optionsJson = try? JSONSerialization.data(withJSONObject: options, options: [])
        let optionsString = String(data: optionsJson ?? Data(), encoding: .utf8) ?? ""
        
        let sql = "INSERT INTO quizzes (category_id, question, options, correct_answer) VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, categoryId)
            sqlite3_bind_text(statement, 2, (question as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (optionsString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (correctAnswer as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Successfully inserted question")
            }
        }
        sqlite3_finalize(statement)
    }
    
    func getAllCategories() -> [Category] {
        var categories: [Category] = []
        let sql = "SELECT * FROM categories"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = sqlite3_column_int(statement, 0)
                let name = String(cString: sqlite3_column_text(statement, 1))
                let icon = String(cString: sqlite3_column_text(statement, 2))
                let color = String(cString: sqlite3_column_text(statement, 3))
                
                categories.append(Category(id: Int(id), name: name, icon: icon, color: color))
            }
        }
        sqlite3_finalize(statement)
        return categories
    }
    
    func getQuestions(for categoryId: Int) -> [QuizQuestion] {
        var questions: [QuizQuestion] = []
        let sql = "SELECT question, options, correct_answer FROM quizzes WHERE category_id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(categoryId))
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let question = String(cString: sqlite3_column_text(statement, 0))
                let optionsString = String(cString: sqlite3_column_text(statement, 1))
                let correctAnswer = String(cString: sqlite3_column_text(statement, 2))
                
                if let optionsData = optionsString.data(using: .utf8),
                   let options = try? JSONSerialization.jsonObject(with: optionsData) as? [String] {
                    questions.append(QuizQuestion(question: question, options: options, correctAnswer: correctAnswer))
                }
            }
        }
        sqlite3_finalize(statement)
        return questions
    }
    
    func saveQuizResult(categoryId: Int, score: Int, totalQuestions: Int) {
        let sql = "INSERT INTO results (category_id, score, total_questions, date) VALUES (?, ?, ?, ?)"
        var statement: OpaquePointer?
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(categoryId))
            sqlite3_bind_int(statement, 2, Int32(score))
            sqlite3_bind_int(statement, 3, Int32(totalQuestions))
            sqlite3_bind_text(statement, 4, (dateString as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Successfully saved quiz result")
            }
        }
        sqlite3_finalize(statement)
    }
    
    func getRecentResults(limit: Int = 5) -> [QuizResult] {
        var results: [QuizResult] = []
        let sql = """
            SELECT c.name, r.score, r.total_questions, r.date 
            FROM results r 
            JOIN categories c ON r.category_id = c.id 
            ORDER BY r.date DESC LIMIT ?
            """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(limit))
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let categoryName = String(cString: sqlite3_column_text(statement, 0))
                let score = sqlite3_column_int(statement, 1)
                let totalQuestions = sqlite3_column_int(statement, 2)
                let dateString = String(cString: sqlite3_column_text(statement, 3))
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dateFormatter.date(from: dateString) ?? Date()
                
                results.append(QuizResult(
                    categoryName: categoryName,
                    score: Int(score),
                    totalQuestions: Int(totalQuestions),
                    date: date
                ))
            }
        }
        sqlite3_finalize(statement)
        return results
    }
    
    func updateQuizResult(categoryId: Int, score: Int, totalQuestions: Int) {
        let sql = """
            UPDATE results 
            SET score = ?, total_questions = ?, date = ? 
            WHERE category_id = ? 
            ORDER BY date DESC LIMIT 1
            """
        var statement: OpaquePointer?
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(score))
            sqlite3_bind_int(statement, 2, Int32(totalQuestions))
            sqlite3_bind_text(statement, 3, (dateString as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, Int32(categoryId))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Successfully updated quiz result")
            }
        }
        sqlite3_finalize(statement)
    }
}
