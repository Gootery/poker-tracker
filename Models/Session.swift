import Foundation

struct Session: Identifiable, Codable {
    let id: UUID
    let date: Date
    let startTime: Date
    let endTime: Date
    let location: String
    let buyIn: Double
    let cashOut: Double
    let notes: String?

    var profit: Double {
        return cashOut - buyIn
    }

    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime) // In seconds
    }

    var hourlyRate: Double {
        let hours = duration / 3600 // Convert seconds to hours
        return hours > 0 ? profit / hours : 0
    }
}
