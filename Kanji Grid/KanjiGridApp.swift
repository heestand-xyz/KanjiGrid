//
//  Kanji_GridApp.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import SwiftUI

@main
struct KanjiGridApp: App {
    
    @StateObject var main = MainViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            
            ContentView(main: main)
        }
    }
}
