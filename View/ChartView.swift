//
//  ChartView.swift
//  Emojion
//
//  Created by Plus1XP on 06/06/2022.
//

import SwiftUI

struct ChartView: View {
    @ObservedObject var entryStore: EntryStore

    var body: some View {
        VStack {
            BarChartViewComponent(data: ChartData(values: entryStore.getPrimaryStats()), title: "Most used Emojions", legend: "\(entryStore.getOldestEntryDate()) to \(entryStore.getNewestEntryDate())", style: Styles.barChartStyleOrangeLight, form: ChartForm.extraLarge, dropShadow: false, cornerImage: Image(systemName: "hand.draw.fill"), valueSpecifier: "%.0f", animatedToBack: true)
        }
        .padding()
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let entryStore = EntryStore()
        ChartView(entryStore: entryStore)
    }
}
