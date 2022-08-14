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
                    
                    ForEach(main.kanjis, id: \.self) { kanji in
                        
                        NavigationLink {
                            KaniView(kanji: kanji)
                        } label: {
                            Text(kanji)
                                .foregroundColor(.white)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .foregroundColor(.accentColor)
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
