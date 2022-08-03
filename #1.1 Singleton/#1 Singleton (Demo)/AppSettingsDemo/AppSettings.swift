//
//  AppSettings.swift
//  AppSettingsDemo
//
//  Created by Oles Novikov on 1.08.22.
//  Copyright © 2022 Karoly Nyisztor. All rights reserved.
//

import Foundation

final public class AppSettings {
    
    public static let shared = AppSettings()
    
    private var settings: [String: Any] = [
        "Theme": "Dark",
        "MaxConcurrentDownloads": 4
    ]
    
    private init() {}
    
    public func string(forKey key: String) -> String? {
        return settings[key] as? String
    }
    
    public func int(forKey key: String) -> Int? {
        return settings[key] as? Int
    }
    
}
