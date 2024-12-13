import SwiftUI

struct AddSessionView: View {
    @ObservedObject var sessionViewModel: SessionViewModel

    @State private var location: String = ""
    @State private var buyIn: String = ""
    @State private var cashOut: String = ""
    @State private var notes: String = ""
    @State private var date: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            // Session Details
            Section(header: Text("Session Details")) {
                TextField("Location", text: $location)
                TextField("Buy-In", text: $buyIn)
                    .keyboardType(.decimalPad)
                TextField("Cash-Out", text: $cashOut)
                    .keyboardType(.decimalPad)
                TextField("Notes", text: $notes)
            }

            // Date and Time Inputs
            Section(header: Text("Date & Time")) {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
            }

            // Submit Button
            Button(action: addSession) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Add Session")
    }

    private func addSession() {
        guard let buyInValue = Double(buyIn), let cashOutValue = Double(cashOut), endTime > startTime else { return }

        let session = Session(
            id: UUID(),
            date: date,
            startTime: startTime,
            endTime: endTime,
            location: location,
            buyIn: buyInValue,
            cashOut: cashOutValue,
            notes: notes
        )
        sessionViewModel.addSession(session: session)
        presentationMode.wrappedValue.dismiss()
    }
}
