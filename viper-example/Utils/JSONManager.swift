//
//  JSONManager.swift
//  viper-example
//
//  Created by Revan Sadigli on 12.11.2023.
//

import Foundation


class JSONManager: NSObject {
    
    let encoder: JSONEncoder = JSONEncoder()
    let decoder: JSONDecoder = JSONDecoder()
    
    
    override init() {
        super.init()
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        
        encoder.dateEncodingStrategy = .formatted(formatter)
        decoder.dateDecodingStrategy = .custom({ (decod) -> Date in
            do {
                let container = try decod.singleValueContainer()
                let dateStr = try container.decode(String.self)
                
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                
                if #available(iOS 10.0, *) {
                    if let date = ISO8601DateFormatter().date(from: dateStr) {
                        return date
                    }
                } else {
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                    if let date = formatter.date(from: dateStr) {
                        return date
                    }
                }
                
            } catch {
                print("Date Error: \(error)")
            }
            
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.date(from: "1900-01-01")!
        })
        
    }
}
