//
//  KaniView.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import SwiftUI

struct KaniView: View {
    
    let kanji: String
    
    @StateObject var viewModel: KanjiViewModel
    
    init(kanji: String) {
        self.kanji = kanji
        _viewModel = StateObject(wrappedValue: KanjiViewModel(kanji: kanji))
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Button {
                viewModel.speak()
            } label: {
                Image(systemName: "speaker.wave.2.fill")
                    .imageScale(.large)
            }
            
            Text(kanji)
                .font(.largeTitle)
            
            if let word = viewModel.word {
                Text(word)
            } else {
                HStack {
                    ProgressView()
                    Text("Translating...")
                }
            }
        }
    }
}

struct KaniView_Previews: PreviewProvider {
    static var previews: some View {
        KaniView(kanji: "人")
    }
}
