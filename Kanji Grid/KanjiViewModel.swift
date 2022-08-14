//
//  KanjiViewModel.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import Foundation
import SwiftyTranslate
import AVFoundation

final class KanjiViewModel: ObservableObject {

    private let kanji: String
    
    @Published var word: String?
    
    init(kanji: String) {
        self.kanji = kanji
        translate()
    }
    
    private func translate() {
        
        SwiftyTranslate.translate(
            text: kanji,
            from: "ja",
            to: "en"
        ) { result in
            
            switch result {
            case .success(let translation):
                
                DispatchQueue.main.async { [weak self] in
                    self?.word = translation.translated
                }
                
            case .failure(let error):
                
                print("Translation Error:", error)
            }
        }
    }
    
    func speak() {
        
        let utterance = AVSpeechUtterance(string: kanji)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}
