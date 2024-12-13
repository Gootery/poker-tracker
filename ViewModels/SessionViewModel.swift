import Foundation

class SessionViewModel: ObservableObject {
    @Published var sessions: [Session] = []
    @Published var cumulativePnL: [PnLData] = []

    init() {
        loadSessions()
        calculateCumulativePnL()
    }

    func addSession(session: Session) {
        sessions.append(session)
        saveSessions()
        calculateCumulativePnL()
    }

    func deleteSessions(at offsets: IndexSet) {
        sessions.remove(atOffsets: offsets) // Remove sessions from the array
        saveSessions() // Save updated sessions to persistence
        calculateCumulativePnL() // Recalculate cumulative PnL for the graph
    }

    func saveSessions() {
        PersistenceService.shared.saveSessions(sessions)
    }

    func loadSessions() {
        sessions = PersistenceService.shared.loadSessions()
        calculateCumulativePnL()
    }

    private func calculateCumulativePnL() {
        var runningTotal: Double = 0
        cumulativePnL = sessions.map { session in
            runningTotal += session.profit
            return PnLData(date: session.date, cumulativeProfit: runningTotal)
        }
    }
}


struct PnLData: Identifiable {
    let id = UUID()
    let date: Date
    let cumulativeProfit: Double
}
