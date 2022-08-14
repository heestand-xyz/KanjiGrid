//
//  KaniView.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import SwiftUI

struct KaniView: View {
    
    @ObservedObject var main: MainViewModel
    
    let kanji: Kanji
    
    @StateObject var viewModel: KanjiViewModel
    
    init(main: MainViewModel, kanji: Kanji) {
        self.main = main
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
            
            Text(kanji.character)
                .font(.largeTitle)
            
            if let word = viewModel.word {
                Text(word)
            } else {
                ProgressView()
            }
            
            Divider()
                .frame(width: 100)
            
            HStack {
                
                ForEach(kanji.particles) { particle in
                
                    NavigationLink {
                        KaniView(main: main, kanji: particle)
                    } label: {
                        ParticleView(kanji: particle)
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.plain)
                    
                    if particle.character != kanji.particles.last?.character {
                        Divider()
                            .frame(height: 20)
                    }
                }
            }
        }
        .navigationTitle(kanji.character)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            main.checked.insert(kanji.character)
        }
    }
}

struct KaniView_Previews: PreviewProvider {
    static var previews: some View {
        KaniView(main: MainViewModel(), kanji: Kanji(character: "人", particles: []))
    }
}
