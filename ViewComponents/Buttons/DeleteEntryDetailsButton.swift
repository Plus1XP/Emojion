//
//  DeleteEntryDetailsButton.swift
//  Emojion
//
//  Created by nabbit on 20/08/2024.
//

import SwiftUI

struct DeleteEntryDetailsButton: View {
    @Environment(\.presentationMode) var presentaionMode
    @EnvironmentObject var entryStore: EntryStore
    @State var confirmDeletion: Bool = false
    @State var animate: Bool = false
    let entry: Entry

    var body: some View {
        Button(action: {
            self.animate.toggle()
            self.confirmDeletion = true
        }, label: {
            Image(systemName: self.confirmDeletion ? "trash.fill" : "trash")
                .font(.headline)
                .foregroundStyle(.red)
                .symbolEffect(.pulse.wholeSymbol, options: .repeat(3), value: self.animate)
                .contentTransition(.symbolEffect(.replace))
        })
        .alert("Confirm Deletion", isPresented: $confirmDeletion) {
            Button("Cancel", role: .cancel) {
                self.confirmDeletion = false
            }
            Button("Delete", role: .destructive) {
                let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                feedbackGenerator?.notificationOccurred(.success)
                entryStore.deleteEntry(entry: entry)
                self.confirmDeletion = false
                self.presentaionMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Are you sure you want to delete the Entry?")
        }
    }
}

#Preview {
    DeleteEntryDetailsButton(entry: PersistenceController.preview.sampleEntry)
        .environmentObject(EntryStore())
}
