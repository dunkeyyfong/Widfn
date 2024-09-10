//
//  WidfnWidget.swift
//  WidfnWidget
//
//  Created by dunkeyyfong on 10/09/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
}

struct WidfnWidgetEntryView : View {
    var entry: DayEntry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.white.gradient)
            
            VStack {
                HStack {
                    Text("🦊")
                        .font(.title)
                    Text(entry.date.weekdayDisplayFormat)
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.4))
                        .font(.title3)
                        .minimumScaleFactor(0.9)
                    Spacer(minLength: 6)
                }
                CalendarView()
            }
            .padding()
        }
    }
}

struct WidfnWidget: Widget {
    let kind: String = "WidfnWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidfnWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Widfn")
        .description("The theme widget date")
        .supportedFamilies([.systemLarge])
    }
}

struct WidfnWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidfnWidgetEntryView(entry: DayEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}
