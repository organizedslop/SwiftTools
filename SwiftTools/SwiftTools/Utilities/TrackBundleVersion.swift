//
//  TrackBundleVersion.swift
//  SwiftTools
//
//  2023-10-10 Created by Blake.
//

import Foundation




//
// Example usage:
//
//     ContentView()
//         .task {
//             if isNewBundleVersion() {
//                 print("App has been updated.")
//             }
//


public func isNewBundleVersion() -> Bool {

    let oldVersion = UserDefaults.standard.string(forKey: "app_version")
    let newVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    if oldVersion != newVersion {
    
        print("""
            --------------------------------------------------------------------------------
             Bundle version has changed
            --------------------------------------------------------------------------------
             - Previous version: \(oldVersion ?? "nil")
             - Current version:  \(newVersion ?? "nil")
            --------------------------------------------------------------------------------
            """)
        
        // Update UserDefaults version
        UserDefaults.standard.setValue(newVersion, forKey: "app_version")
    
    } else {
        print("Current bundle version: \(newVersion ?? "nil")")
    }
    
    return oldVersion != newVersion
}
