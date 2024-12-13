import Foundation
import SwiftUI

struct SessionsListView: View {
    @ObservedObject var sessionViewModel: SessionViewModel

    var body: some View {
        List {
            ForEach(sessionViewModel.sessions) { session in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(session.location)
                            .font(.headline)
                        Spacer()
                        Text(session.date.shortFormat())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Buy-In: \(session.buyIn, specifier: "%.2f")")
                            .foregroundColor(.red)
                        Spacer()
                        Text("Cash-Out: \(session.cashOut, specifier: "%.2f")")
                            .foregroundColor(.green)
                    }

                    Text("Profit: \(session.profit, specifier: "%.2f")")
                        .foregroundColor(session.profit >= 0 ? .blue : .red)

                    Text("Hourly Rate: \(session.hourlyRate, specifier: "%.2f")/hour")
                        .font(.footnote)
                        .foregroundColor(.purple)

                    if let notes = session.notes, !notes.isEmpty {
                        Text("Notes: \(notes)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
            .onDelete(perform: deleteSession) // Swipe-to-delete feature
        }
        .navigationTitle("Past Sessions")
        .toolbar {
            EditButton() // Adds the edit button to toggle delete mode
        }
    }

    // Function to handle deletion
    private func deleteSession(at offsets: IndexSet) {
        sessionViewModel.deleteSessions(at: offsets)
    }
}
