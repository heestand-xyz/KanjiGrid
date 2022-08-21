//
//  Kanji.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import Foundation

class Kanji: Identifiable {
    
    var id: String { character }
    
    let character: String
    
    let particles: [Kanji]
    var components: [Kanji] = []
    
    init(character: String, particles: [Kanji]) {
        self.character = character
        self.particles = particles
    }
}
