//
//  DateExtension.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/19/21

import Foundation

extension Date {
    /// Format a date using the specified format.
    ///   - parameters:
    ///     - format: A date pattern string like "MM dd".
    func formatted(as format: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      return dateFormatter.string(from: self)
    }

    var yearMonthDay: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy MM dd"
      return dateFormatter.string(from: self)
    }

    /// Check another date is the same year, month and day.
    ///   - parameters:
    ///     - day: The other date.
    func isSameDay(as day: Date) -> Bool {
      return self.yearMonthDay == day.yearMonthDay
    }

    var dayName: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE"
      return dateFormatter.string(from: self)
    }

    var truncatedDayName: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEE"
      return dateFormatter.string(from: self)
    }

    var truncatedDayMonth: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd MMM"
      return dateFormatter.string(from: self)
    }

    var lastSevenDays: [Date] { //.current is user's current calendar, .day is the Calendar.Component identifier for a day which is the exact type for the byAdding parameter of this particular date method. public func date(byAdding component: Calendar.Component, value: Int, to date: Date, wrappingComponents: Bool = false) -> Date?
        /* /// Returns a new `Date` representing the date calculated by adding an amount of a specific component to a given date.
         ///
         /// - parameter component: A single component to add.
         /// - parameter value: The value of the specified component to add.
         /// - parameter date: The starting date.
         /// - parameter wrappingComponents: If `true`, the component should be incremented and wrap around to zero/one on overflow, and should not cause higher components to be incremented. The default value is `false`.
         /// - returns: A new date, or nil if a date could not be calculated with the given input.*/
      (-6...0).map { day in
        Calendar.current.date(
          byAdding: .day,
          value: day,
          to: Date()) ?? Date()
      }
    }
}
