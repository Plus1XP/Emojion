//
//  EntryListView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct CardView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @State private var editMode: EditMode = .inactive
    @State private var canShowAddEntryView: Bool = false
    @State private var canAutoCompleteSearch: Bool = false
    @State private var confirmDeletion: Bool = false
    @State private var canResetDate: Bool = false
    @State private var calendarId: UUID = UUID()
    
    var body: some View {
        List(selection: $entryStore.entrySelection) {
            if entryStore.entries.isEmpty {
                ContentUnavailableView("How are you feeling?...", systemImage: "ellipsis.message")
            } else {
                ForEach(entryStore.getSectionHeadersFromSearchResults().keys.sorted(by: { $0 > $1 }), id: \.self) { key in
                    // Removed ! after [key] due to xcode 14.3 update
                    if let entries = entryStore.getSectionHeadersFromSearchResults()[key]
                    {
                        Section(header: Text("\(Formatter.longDayFormat.string(from: key))")) {
                            ForEach(entries, id: \.self){ entry in
                                Section {
                                    // This Hack removes the Details Disclosure chevron from list view.
                                    ZStack {
                                        HStack(alignment: .top) {
                                            if !self.editMode.isEditing {
                                                DateRowView(index: entryStore.entries.firstIndex(of: entry)!)
                                            }
                                            CardRowView(index: entryStore.entries.firstIndex(of: entry)!)
                                                .padding(.leading, self.editMode.isEditing ? 10 : 0)
                                        }
                                        if let entryIndex = entryStore.entries.firstIndex(of: entry) {
                                            NavigationLink(destination: EntryDetailsView(index: Binding(get: {entryIndex}, set: {_ in entryIndex}))) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
//                                        NavigationLink(destination: EntryDetailsView(index: Binding(get: {entryStore.entries.firstIndex(of: entry)!}, set: {_ in entryStore.entries.firstIndex(of: entry)}))) {
//                                            EmptyView()
//                                        }
//                                        .opacity(0)
                                    }
                                }
                                .listRowSeparator(.hidden)
//                              .listRowInsets(EdgeInsets())
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                                            feedbackGenerator?.notificationOccurred(.success)
                                            entryStore.deleteEntry(entry: entry)
                                            self.entryStore.entrySelection.removeAll()
                                        }
                                    } label: {
                                        Label("", systemImage: "trash")
                                            .foregroundStyle(.red, .red)
                                    }
                                    .tint(.clear)
                                }
                            }
                        }
                    }
                }
                .listRowBackground(
                    Rectangle()
                        .fill(Color(.clear).opacity(1))
                )
            }
        }
        .searchable(text: $entryStore.searchText, prompt: "Search Emojions") {
            if canAutoCompleteSearch && entryStore.searchText.count > 2 {
                ForEach(entryStore.searchResults, id: \.self) { entry in
                    Text(entry.event!).searchCompletion(entry.event!)
                }
            }
        }
        .disableAutocorrection(true)
        .navigationBarItems(
            leading:
                HStack {
                    DatePicker("Please enter a date", selection: $entryStore.searchDate, displayedComponents: .date)
                        .labelsHidden()
                        .id(calendarId)
                    // Needed to close calendar picker after selection
                        .onChange(of: Calendar.current.component(.day, from: entryStore.searchDate)) {
                            calendarId = UUID()
                            if !canResetDate {
                                entryStore.isSearchingDate = true
                            } else {
                                canResetDate = false
                            }
                        }
                    
                    if entryStore.isSearchingDate {
                        Button(action: {
                            entryStore.isSearchingDate = false
                            canResetDate = true
                            entryStore.searchDate = Date.now
                        }) {
                            Label("Reset Calendar", systemImage: "xmark")
                                .foregroundStyle(.red, .primary)
                        }
                    }
                    
                    if self.editMode == .active {
                        Button(action: {
                            if self.entryStore.entrySelection.isEmpty {
                                for entry in self.entryStore.entries {
                                    self.entryStore.entrySelection.insert(entry)
                                }
                            } else {
                                self.entryStore.entrySelection.removeAll()
                            }
                        }) {
                            Image(systemName: self.entryStore.entrySelection.isEmpty ? "checklist.unchecked" : "checklist.checked")
                                .symbolEffect(.bounce, value: self.entryStore.entrySelection.isEmpty)
                                .contentTransition(.symbolEffect(.replace))
                        }
                        .foregroundStyle(.blue, setFontColor(colorScheme: colorScheme))
                        .disabled(editMode == .inactive ? true : false)
                        
                        Button(action: {
                            self.confirmDeletion = true
                        }) {
                            Label("Delete", systemImage: self.confirmDeletion ? "trash.fill" : "trash")
                                .symbolEffect(.pulse.wholeSymbol, options: .repeating, value: self.confirmDeletion)
                                .contentTransition(.symbolEffect(.replace))
                        }
                        .foregroundStyle(self.entryStore.entrySelection.isEmpty ? .gray : .red, .blue)
                        .disabled(self.entryStore.entrySelection.isEmpty)
                    }
                    // For Internal debugging
#if DEBUG
                    EntryDebugButtons()
#endif
                },
            trailing:
                HStack {
                    Button {
                        if self.editMode == .inactive {
                            self.editMode = .active
                        }
                        else if self.editMode == .active {
                            self.editMode = .inactive
                            self.entryStore.entrySelection.removeAll()
                        }
                    } label: {
                        if self.editMode.isEditing {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.white, .blue)
                        } else {
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.gray, .blue)
                        }
                    }
                    .scaleEffect(self.editMode.isEditing ? 1.5 : 1)
                    .animation(.bouncy, value: self.editMode.isEditing)

                    Button(action: {
                        self.canShowAddEntryView.toggle()
                    }) {
                        Label("Add Item", systemImage: canShowAddEntryView ? "plus.circle.fill" : "plus")
                            .rotationEffect(.degrees(self.canShowAddEntryView ? 360 : 0))
                            .scaleEffect(self.canShowAddEntryView ? 1.5 : 1)
                            .animation(.easeInOut, value: self.canShowAddEntryView)
                    }
                }
        )
        .environment(\.editMode, $editMode)
        .alert("Confirm Deletion", isPresented: $confirmDeletion) {
            Button("Cancel", role: .cancel) {
                self.entryStore.entrySelection.removeAll()
                self.editMode = .inactive
                self.confirmDeletion = false
            }
            Button("Delete", role: .destructive) {
                let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                feedbackGenerator?.notificationOccurred(.success)
                entryStore.deleteEntrySelectionEntries()
                self.editMode = .inactive
                self.confirmDeletion = false
            }
        } message: {
            Text("Are you sure you want to delete the Entry?")
        }
        .onAppear {
            entryStore.fetchEntries()
        }
        .onDisappear(perform: {
            self.editMode = .inactive
            self.entryStore.entrySelection.removeAll()

        })
        .refreshable {
            entryStore.fetchEntries()
        }
        .sheet(isPresented: $canShowAddEntryView) {
            AddEntryView()
        }
    }
}

func setFontColor(colorScheme: ColorScheme) -> Color {
    return colorScheme == .light ? .black : .white
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .environmentObject(EntryStore())
    }
}
