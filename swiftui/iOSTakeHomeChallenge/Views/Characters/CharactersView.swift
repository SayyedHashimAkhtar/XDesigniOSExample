//
//  CharactersView.swift
//  iOSTakeHomeChallenge
//
//  Created by Martin Rist on 19/10/2022.
//

import SwiftUI

struct CharactersView: View {
    @State var characters: [Character] = []
    var previewMode: Bool
    @State private var searchText: String = ""
    @State private var hideProgressView: Bool = false

    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    
    
    var searchResults: [Character] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.contains(searchText) }
        }
    }
    
    init(previewMode: Bool = false) {
        self.previewMode = previewMode
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("imgCharacters")
                    .resizable()
                ProgressView("Loading").isHidden($hideProgressView)
                
                ScrollView {
                    VStack {
                        ForEach(searchResults, id: \.self) { character in
                            VStack(alignment: .leading , spacing: 4) {
                                HStack {
                                    Text(character.name)
                                        .font(.title3)
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("Seasons").bold()
                                        Text(getSeasons(for: character)).foregroundColor(.secondary)
                                    }
                                }.padding()
                                
                                HStack {
                                    Text("Culture:").bold()
                                    Text(character.culture).foregroundColor(.secondary)
                                }.padding(.horizontal)
                                
                                HStack {
                                    Text("Born:").bold()
                                    Text(character.born).foregroundColor(.secondary)
                                }.padding(.horizontal)
                                
                                HStack {
                                    Text("Died:").bold()
                                    Text(character.died).foregroundColor(.secondary)
                                }.padding(.horizontal)
                            }
                            Divider()
                                .border(.white)
                        }
                    }
                }
                .padding()
            }
        }
        .searchable(text: $searchText)
        .onAppear(perform: loadData)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                showAlert.toggle()
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    func loadData() {
        if(!previewMode) {
            //Play background sound
            SoundPlayer.introSound()
        }
        
        getCharacters()
    }
    
    func getSeasons(for character: Character) -> String {
        var seasons = ""

        for season in character.tvSeries {
            if season == "Season 1" {
                seasons.append("I ")
            } else if season == "Season 2" {
                seasons.append("II, ")
            } else if season == "Season 3" {
                seasons.append("III, ")
            } else if season == "Season 4" {
                seasons.append("IV, ")
            } else if season == "Season 5" {
                seasons.append("V, ")
            } else if season == "Season 6" {
                seasons.append("VI, ")
            } else if season == "Season 7" {
                seasons.append("VII, ")
            } else if season == "Season 8" {
                seasons.append("VIII")
            }
        }

        return seasons
    }

    func getCharacters() {
        if previewMode {
            characters = Character.examples
            hideProgressView = true
            return
        }

        hideProgressView = false
        
        CharacterAPI.fetchCharacters { characters in
            
            guard let characters = characters else {
                alertTitle = "Oops"
                alertMessage = "Could not connect to server. Please try again later."
                self.showAlert.toggle()
                SoundPlayer.errorSound()
                self.hideProgressView = true
                return
            }
            
            self.characters = characters
            self.hideProgressView = true
        }

    }
}

#Preview {
    CharactersView(previewMode: true)
        .preferredColorScheme(.dark)
}
