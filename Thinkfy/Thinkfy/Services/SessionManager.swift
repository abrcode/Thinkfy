import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    private let defaults = UserDefaults.standard
    private let hasCompletedOnboardingKey = "hasCompletedOnboarding"
    private let userNameKey = "userName"
    
    private init() {}
    
    var hasCompletedOnboarding: Bool {
        get {
            defaults.bool(forKey: hasCompletedOnboardingKey)
        }
        set {
            defaults.set(newValue, forKey: hasCompletedOnboardingKey)
        }
    }
    
    var userName: String {
        get {
            defaults.string(forKey: userNameKey) ?? ""
        }
        set {
            defaults.set(newValue, forKey: userNameKey)
        }
    }
    
    func completeOnboarding(userName: String) {
        self.userName = userName
        self.hasCompletedOnboarding = true
    }
    
    func clearSession() {
        defaults.removeObject(forKey: hasCompletedOnboardingKey)
        defaults.removeObject(forKey: userNameKey)
    }
} 