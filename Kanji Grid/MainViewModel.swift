//
//  MainViewModel.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    static let characters: [String] = {
        guard let url = Bundle.main.url(forResource: "aozora", withExtension: "txt") else {
            fatalError()
        }
        let text = try! String(contentsOf: url)
        return text.split(separator: "\n").map(String.init)
    }()
    
    static let particles: [(String, [String])] = {
        guard let url = Bundle.main.url(forResource: "1-to-N", withExtension: "txt") else {
            fatalError()
        }
        let text = try! String(contentsOf: url)
        return text.split(separator: "\n").map { row in
            let character = String(row.first!)
            let particles = String(row.dropFirst())
            if particles == "0" {
                return (character, [])
            } else {
                return (character, Array(particles).map(String.init))
            }
        }
    }()
    
    let kanjis: [Kanji] = {
        var kanjis: [Kanji] = []
        for character in MainViewModel.characters {
            var particles: [Kanji] = []
            if let particleCharacters: [String] = MainViewModel.particles.first(where: { $0.0 == character })?.1 {
                particles = particleCharacters.compactMap { particleCharacter in
                    kanjis.first(where: { $0.character == particleCharacter })
                }
            }
            let kanji = Kanji(character: character, particles: particles)
            kanjis.append(kanji)
        }
        return kanjis
    }()
    
    @Published var checked: Set<String> = {
        guard let json = UserDefaults.standard.string(forKey: "kanji") else { return [] }
        guard let data = json.data(using: .utf8) else { return [] }
        return (try? JSONDecoder().decode(Set<String>.self, from: data)) ?? []
    }() {
        didSet {
            guard let data = try? JSONEncoder().encode(checked) else { return }
            let json = String(data: data, encoding: .utf8)
            UserDefaults.standard.set(json, forKey: "kanji")
        }
    }
}
