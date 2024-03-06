//
//  ChartStatsView.swift
//  Emojion
//
//  Created by nabbit on 26/12/2023.
//

import SwiftUI

struct ChartStatsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @EnvironmentObject var chartStore: ChartStore
    @State var canShowMostUsed: Bool = true
    @State var canShowLeastUsed: Bool = true
    
    var body: some View {
        VStack(alignment: .center, content: {
            HStack {
                if canShowMostUsed {
                    VStack(alignment: .leading, content: {
                        HStack(alignment: .center, content:  {
                            VStack(alignment: .leading, content:  {
                                if canShowLeastUsed {
                                    HStack {
                                        Text("Most Used")
                                            .font(.headline)
                                        Text(chartStore.mostUsedEmoji.emoji)
                                            .font(.title2)
                                        Spacer()
                                        Image(systemName: "chevron.up.circle")
                                            .foregroundStyle(.blue)
                                    }
                                } else {
                                    HStack {
                                        Text("Most Used Emojions")
                                            .font(.headline)
                                        Spacer()
                                        Image(systemName: "chevron.down.circle")
                                            .foregroundStyle(.blue)
                                    }
                                    HStack {
                                        Text(chartStore.mostUsedEmoji.emoji)
                                            .font(.largeTitle)
                                        Text("x\(chartStore.mostUsedEmoji.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                    }
                                    HStack {
                                        Text(chartStore.mostUsedPrimaryFeeling.feeling)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.mostUsedPrimaryFeeling.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                        Spacer()
                                        Text(chartStore.mostUsedDay.weekDay)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.mostUsedDay.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                    }
                                    HStack {
                                        Text(chartStore.mostUsedSecondaryFeeling.feeling)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.mostUsedSecondaryFeeling.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                        Spacer()
                                        Text(chartStore.mostUsedMonth.month)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.mostUsedMonth.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                    }
                                    HStack {
                                        Text(chartStore.mostUsedTertiaryFeeling.feeling)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.mostUsedTertiaryFeeling.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                        Spacer()
                                        Text(chartStore.mostUsedYear.year)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.mostUsedYear.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                    }
                                }
                            })
                            Spacer()
                        })
                    })
                    .padding(10)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(Color(UIColor.quaternarySystemFill))
                    )
                    .onTapGesture(perform: {
                        canShowLeastUsed = !canShowLeastUsed
                    })
                }
                if canShowLeastUsed {
                    VStack(alignment: .leading, content: {
                        HStack(alignment: .center, content:  {
                            VStack(alignment: .leading, content:  {
                                if canShowMostUsed {
                                    HStack {
                                        Text("Least Used")
                                            .font(.headline)
                                        Text(chartStore.leastUsedEmoji.emoji)
                                            .font(.title2)
                                        Spacer()
                                        Image(systemName: "chevron.up.circle")
                                            .foregroundStyle(.blue)
                                    }
                                } else {
                                    HStack {
                                        Text("Least Used Emojions")
                                            .font(.headline)
                                        Spacer()
                                        Image(systemName: "chevron.down.circle")
                                            .foregroundStyle(.blue)
                                    }
                                    HStack {
                                        Text(chartStore.leastUsedEmoji.emoji)
                                            .font(.largeTitle)
                                        Text("x\(chartStore.leastUsedEmoji.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                    }
                                    HStack {
                                        Text(chartStore.leastUsedPrimaryFeeling.feeling)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.leastUsedPrimaryFeeling.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                        Spacer()
                                        Text(chartStore.leastUsedDay.weekDay)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.leastUsedDay.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                    }
                                    HStack {
                                        Text(chartStore.leastUsedSecondaryFeeling.feeling)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.leastUsedSecondaryFeeling.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                        Spacer()
                                        Text(chartStore.leastUsedMonth.month)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.leastUsedMonth.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                    }
                                    HStack {
                                        Text(chartStore.leastUsedTertiaryFeeling.feeling)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.leastUsedTertiaryFeeling.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                        Spacer()
                                        Text(chartStore.leastUsedYear.year)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("x\(chartStore.leastUsedYear.tally)")
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .italic()
                                            .foregroundStyle(.blue)
                                            .shadow(color: colorScheme == .light ? .indigo.opacity(0.8) : .white.opacity(0.6), radius: 1)
                                    }
                                }
                            })
                            Spacer()
                        })
                    })
                    .padding(10)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(Color(UIColor.quaternarySystemFill))
                    )
                    .onTapGesture(perform: {
                        canShowMostUsed = !canShowMostUsed
                    })
                }
            }
            .padding([.leading, .trailing], 10)
            .padding(.top, 10)
            HStack {
                Text("First Entry:")
                    .font(.footnote)
                    .fontWeight(.medium)
                Text(chartStore.oldestEntryDate)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text("Last Entry:")
                    .font(.footnote)
                    .fontWeight(.medium)
                Text(chartStore.newestEntryDate)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(10)
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                .fill(Color(UIColor.quaternarySystemFill))
            )
            .padding([.leading, .trailing], 10)
            Divider()
            //MARK: Refactor ForEach Loop
            VStack(alignment: .center, content: {
                HStack {
                    ForEach(chartStore.feelingData, id: \.id) { feeling in
                        if feeling.type == .Angry || feeling.type == .Bad || feeling.type == .Disgusted || feeling.type == .Fearful {
                            VStack(alignment: .center, content: {
                                Text("\(feeling.count)")
                                    .font(GetEmojionCountFontSize())
                                    .fontWeight(.bold)
                                Text("\(feeling.type.rawValue)")
                                    .font(.footnote)
                            })
                            .frame(width: GetEmojionFrameWidthSize(), height: 75)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(feeling.color)
                            )
                        }
                    }
                }
                
                HStack {
                    ForEach(chartStore.feelingData, id: \.id) { feeling in
                        if feeling.type == .Happy || feeling.type == .Sad || feeling.type == .Surprised {
                            VStack(alignment: .center, content: {
                                Text("\(feeling.count)")
                                    .font(GetEmojionCountFontSize())
                                    .fontWeight(.bold)
                                Text("\(feeling.type.rawValue)")
                                    .font(.footnote)
                            })
                            .frame(width: GetEmojionFrameWidthSize(), height: 75)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(feeling.color)
                            )
                        }
                    }
                    VStack(alignment: .center, content: {
                        Text("\(entryStore.entries.count)")
                            .font(GetEmojionCountFontSize())
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("Total")
                            .font(.footnote)
                    })
                    .frame(width: GetEmojionFrameWidthSize(), height: 75)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.primary, lineWidth: 2)
                    )
                    .shadow(radius: 2)
                }
            })
            .padding(.bottom, 10)
        })
    }
    
    func GetEmojionFrameWidthSize() -> CGFloat {
        if UIDevice.current.name.contains("Pro Max") {
            return 85
        } else {
            return 75
        }
    }
    
    func GetEmojionCountFontSize() -> Font {
        if entryStore.entries.count < 1000 {
            return .title
        } else {
            return .title2
        }
    }
}

#Preview {
    ChartStatsView()
        .environmentObject(EntryStore())
        .environmentObject(ChartStore())
        .preferredColorScheme(.light)
}

#Preview {
    ChartStatsView()
        .environmentObject(EntryStore())
        .environmentObject(ChartStore())
        .preferredColorScheme(.dark)
}
