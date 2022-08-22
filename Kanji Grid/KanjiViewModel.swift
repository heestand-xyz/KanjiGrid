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

    private let kanji: Kanji
    
    @Published var word: String?
    
    var hiragana: String!
    
    init(kanji: Kanji) {
        self.kanji = kanji
        translate()
        hiraganize()
    }
    
    private func translate() {
        
        SwiftyTranslate.translate(
            text: kanji.character,
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
    
    enum Kana { case hiragana, katakana }
    
    private func hiraganize() {
    
        let tokenizer: CFStringTokenizer =
        CFStringTokenizerCreate(kCFAllocatorDefault,
                                kanji.character as CFString,
                                CFRangeMake(0, kanji.character.utf16.count),
                                kCFStringTokenizerUnitWordBoundary,
                                Locale(identifier: "ja") as CFLocale)
        hiragana = tokenizer.hiragana
    }
    
    func speak() {
        
        let utterance = AVSpeechUtterance(string: kanji.character)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}

private extension CFStringTokenizer {
    var hiragana: String { string(to: kCFStringTransformLatinHiragana) }
    var katakana: String { string(to: kCFStringTransformLatinKatakana) }
    
    private func string(to transform: CFString) -> String {
        var output: String = ""
        while !CFStringTokenizerAdvanceToNextToken(self).isEmpty {
            output.append(letter(to: transform))
        }
        return output
    }
    
    private func letter(to transform: CFString) -> String {
        let mutableString: NSMutableString =
        CFStringTokenizerCopyCurrentTokenAttribute(self, kCFStringTokenizerAttributeLatinTranscription)
            .flatMap { $0 as? NSString }
            .map { $0.mutableCopy() }
            .flatMap { $0 as? NSMutableString } ?? NSMutableString()
        CFStringTransform(mutableString, nil, transform, false)
        return mutableString as String
    }
}

