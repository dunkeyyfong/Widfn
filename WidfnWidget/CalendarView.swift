//
//  CalendarView.swift
//  WidfnWidgetExtension
//
//  Created by dunkeyyfong on 10/09/2024.
//

import SwiftUI

struct CalendarView: View {
    let currentDate = Date()
    
    var body: some View {
        VStack {
            // Weekday headers
            let days = Calendar.current.shortWeekdaySymbols
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                }
            }
            
            // Days of the month
            let daysInMonth = daysInCurrentMonth()
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns) {
                ForEach(daysInMonth, id: \.self) { day in
                    let isToday = isSameDay(date: currentDate, day: day)
                    
                    Text("\(day)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(4)
                        .background(isToday ? Color.blue.opacity(0.8) : Color.clear)
                        .foregroundColor(isToday ? .white : .primary)
                        .clipShape(Circle())
                }
            }
        }
        .padding(4)
    }
    func daysInCurrentMonth() -> [Int] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        return Array(range)
    }
    
    func isSameDay(date: Date, day: Int) -> Bool {
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: date)
        return currentDay == day
    }
}

