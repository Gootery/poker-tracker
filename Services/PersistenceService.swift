import Foundation

class PersistenceService {
    static let shared = PersistenceService()
    private let userDefaultsKey = "sessions"

    func saveSessions(_ sessions: [Session]) {
        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func loadSessions() -> [Session] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let sessions = try? JSONDecoder().decode([Session].self, from: data) {
            return sessions
        }
        return []
    }
}
