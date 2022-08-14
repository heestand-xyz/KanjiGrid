//
//  ContentView.swift
//  Kanji Grid
//
//  Created by Anton Heestand on 2022-08-14.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var main: MainViewModel
    
    var body: some View {
        
        NavigationView {
    
            ScrollView {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                    
                    ForEach(main.kanjis) { kanji in
                        
                        NavigationLink {
                            KaniView(main: main, kanji: kanji)
                        } label: {
                            Text(kanji.character)
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(.white)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .foregroundColor(main.checked.contains(kanji.character) ? .accentColor : .gray)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Kanji Grid")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(main: MainViewModel())
    }
}
