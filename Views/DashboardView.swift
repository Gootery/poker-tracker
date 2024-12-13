import SwiftUI
import Charts

struct DashboardView: View {
    @StateObject private var sessionViewModel = SessionViewModel()

    var averageHourlyRate: Double {
        let totalHours = sessionViewModel.sessions.reduce(0) { $0 + $1.duration / 3600 }
        let totalProfit = sessionViewModel.sessions.reduce(0) { $0 + $1.profit }
        return totalHours > 0 ? totalProfit / totalHours : 0
    }

    var body: some View {
        NavigationView {
            VStack {
                // Add Logo
                Image("PokerTrackerLogo") // Replace with your logo's name in Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom)

                // Title
                Text("Poker Tracker")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                // Display Summary Stats
                VStack(alignment: .leading) {
                    Text("Total Profit: \(sessionViewModel.sessions.reduce(0) { $0 + $1.profit }, specifier: "%.2f")")
                        .font(.headline)
                    Text("Sessions Played: \(sessionViewModel.sessions.count)")
                        .font(.subheadline)
                    Text("Average Hourly Rate: \(averageHourlyRate, specifier: "%.2f")/hour")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding()

                // Chart
                if sessionViewModel.cumulativePnL.isEmpty {
                    Text("No data to display")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    Chart(sessionViewModel.cumulativePnL) { dataPoint in
                        LineMark(
                            x: .value("Date", dataPoint.date.shortFormat()),
                            y: .value("Cumulative PnL", dataPoint.cumulativeProfit)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(Color.blue)
                    }
                    .frame(height: 300)
                    .padding()
                }

                // Buttons
                NavigationLink(destination: AddSessionView(sessionViewModel: sessionViewModel)) {
                    Text("Add Session")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.vertical)

                NavigationLink(destination: SessionsListView(sessionViewModel: sessionViewModel)) {
                    Text("View Past Sessions")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}

