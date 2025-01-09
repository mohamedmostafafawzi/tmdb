// 
//  String+Extensions.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 09/01/2025.
//

import Foundation

extension String {
    func toYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        }
        return "Unknown"
    }
    
    func toFormattedDate() -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = inputFormatter.date(from: self) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateStyle = .long
                outputFormatter.timeStyle = .none
                return outputFormatter.string(from: date)
            }
            
            return "Unknown"
        }
}
