import Foundation
import SQLite3

class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    
    private init() {
        setupDatabase()
    }
    
    private func setupDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("quizDatabase.sqlite")
        
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
}