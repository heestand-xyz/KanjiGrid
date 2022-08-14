//
//  Kanji.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import Foundation

struct Kanji: Identifiable {
    var id: String { character }
    let character: String
    let particles: [Kanji]
}
