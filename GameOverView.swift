//
//  GameOverView.swift
//  Vords
//
//  Created by Claudio Marciello on 15/02/24.
//

import SwiftUI
struct GameOverView: View {
    @EnvironmentObject var voiceRecognition: VoiceRecognition
    @Binding var currentState: GameState
    @State private var restartButtonEnabled = false

    @State private var showAlert = false

    let alphabet: [Character] = Array("abcdefghilmnopqrstuvz")
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color.black.ignoresSafeArea()
                ScrollView {
                    HStack{
                        Button(action: {
                            currentState = .startview
                        }) {
                            Text("Back")
                                .padding()
                                .foregroundStyle(.white)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        Text("Guessed Letters:").font(.largeTitle).fontWeight(.bold).foregroundStyle(.white)
                        Spacer()
                        Text("Back")
                            .padding()
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                        .opacity(0)                    }
                    ForEach(voiceRecognition.categories, id: \.self) { category in
                        VStack {
                            HStack {
                                Text(emojiDictionary[category]!)
                                    .font(.system(size: 48))
                                    .accessibilityLabel("\(category) Guessed Letters")
                            .padding(.horizontal)
                                if((voiceRecognition.completedLetters[category]!) != Set(alphabet) ){
                                    VStack {
                                        ForEach(alphabet.indices.filter { $0 % 7 == 0 }, id: \.self) { rowIndex in
                                            let string: String = alphabet.indices.prefix(rowIndex + 7).suffix(7).map { letterIndex in
                                                let letter = alphabet[letterIndex]
                                                if voiceRecognition.completedLetters[category]?.contains(letter) == true {
                                                    return String(letter).uppercased()
                                                } else {
                                                    return "_"
                                                }
                                            }.joined()
                                            
                                            HStack(spacing: 20) {
                                                ForEach(alphabet.indices.prefix(rowIndex + 7).suffix(7), id: \.self) { letterIndex in
                                                    let letter = alphabet[letterIndex]
                                                    if voiceRecognition.completedLetters[category]?.contains(letter) == true {
                                                        Text(String(letter).uppercased())
                                                            .font(.title)
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.white)
                                                    } else {
                                                        Text("_")
                                                            .font(.title)
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.white)
                                                            .accessibilityHidden(true)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }else{
                                    Text("COMPLETED!")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.VordsBlue)
                                }
                                Text(emojiDictionary[category]!)
                                    .font(.system(size: 48))
                                    .opacity(0)
                                    .accessibilityHidden(true)
                            }.accessibilityElement(children: .combine)
                                
                        }
                    }
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    Spacer().frame(height: 200)
                    Button(action: {
                        
                        currentState = .mainScreen
                        voiceRecognition.setupGame()
                    }) {
                        Text("Restart")
                            .font(.system(size: 72))
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .opacity(restartButtonEnabled==true ? 1 : 0.3)

                    }.disabled(!restartButtonEnabled)
                    
                    Spacer()
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Clear Guessings")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Clear Guessings"), message: Text("Are you sure you want to restart and clear your guessings?"), primaryButton: .destructive(Text("Clear")) {
                            clearGuessings()
                            voiceRecognition.saveData()
                        }, secondaryButton: .cancel())
                    }
                }
            }.onAppear{
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    restartButtonEnabled = true
                }
            }
        }
    }

    func clearGuessings() {
        for (key, _) in voiceRecognition.completedLetters {
            voiceRecognition.completedLetters[key] = Set<Character>()

        }
        voiceRecognition.completedLetters["Sports"]?.insert("u")


    }
}

#Preview {
    GameOverView(currentState: .constant(.gameOver)).environmentObject(VoiceRecognition(resetBarsManager: ResetBarsManager()))
}

