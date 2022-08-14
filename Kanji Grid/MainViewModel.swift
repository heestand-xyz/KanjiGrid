//
//  MainViewModel.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    let kanjis: [String] = {
        guard let url = Bundle.main.url(forResource: "aozora", withExtension: "txt") else {
            fatalError()
        }
        let text = try! String(contentsOf: url)
        return text.split(separator: "\n").map(String.init)
    }()
    
}
