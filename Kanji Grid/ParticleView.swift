//
//  ParticleView.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import SwiftUI

struct ParticleView: View {
    
    let kanji: Kanji
    
    @StateObject var viewModel: KanjiViewModel
    
    init(kanji: Kanji) {
        self.kanji = kanji
        _viewModel = StateObject(wrappedValue: KanjiViewModel(kanji: kanji))
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text(kanji.character)
                .font(.title)
            
            if let word = viewModel.word {
                Text(word)
            } else {
                ProgressView()
            }
        }
    }
}

struct ParticleView_Previews: PreviewProvider {
    static var previews: some View {
        ParticleView(kanji: Kanji(character: "人", particles: []))
    }
}
