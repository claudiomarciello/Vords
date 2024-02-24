import SwiftUI

struct ContentView: View {
    @EnvironmentObject var voiceRecognition: VoiceRecognition
    @Binding var currentState: GameState
    @State var isOverlayVisible = true
    @State var hintUsed: [Int: Bool] = [0:false, 1:false, 2:false, 3:false]
    @State var hint: String = " "
    @State var opacities: [Double] = [1,1,1,1]
    

    
    var body: some View {
        ZStack{
            Color.black
                            .ignoresSafeArea()
            
            VStack {
                HStack{
                    if voiceRecognition.currentLetters[0] != " " && voiceRecognition.resetBarsManager.disabledBars[0] != true{
                        Text("\(String(voiceRecognition.currentLetters[0]).uppercased())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .animation(.easeOut)

                        Button(action: {
                            voiceRecognition.hintConsumed=true
                            hint = voiceRecognition.getHint(startingWith: voiceRecognition.currentLetters[0], of: voiceRecognition.currentCategory)
                            voiceRecognition.hintActive=true
                        }
                        )
                        {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(voiceRecognition.hintConsumed ? .gray : .yellow)
                                .opacity(voiceRecognition.hintConsumed ? 0.2 : 1)
                                .padding()
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Hint")
                        }.disabled(voiceRecognition.hintConsumed ? true : false)
                    }
                    else{Text("\(String(voiceRecognition.currentLetters[0]).uppercased())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .opacity(0)
                            .animation(.easeOut)
                        Button(action: {
                            voiceRecognition.hintConsumed=true
                            hint = voiceRecognition.getHint(startingWith: voiceRecognition.currentLetters[0], of: voiceRecognition.currentCategory)
                            voiceRecognition.hintActive=true
                        }
                        )
                        {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(voiceRecognition.hintConsumed ? .gray : .yellow)
                                .opacity(0)
                                .padding()
                                
                        }
                        .disabled(true)
                    }
                }
                           

                TimeBar(id: 0, disableValue: $voiceRecognition.resetBarsManager.disabledBars[0], resetValue: $voiceRecognition.resetBarsManager.resetBars[0], currentState: $currentState)
                    .frame(height: 20).environmentObject(voiceRecognition)
                Text("Hint: \(hint)").font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .opacity(voiceRecognition.hintActive ? 1 : 0)
                Spacer()
                HStack{
                    Text("Your last word:").font(.title).foregroundStyle(.white)
                    Text("\(voiceRecognition.lastWord)").font(.title).foregroundStyle(voiceRecognition.lastWordCorrect ? .green : .white)
                }
                .accessibilityElement(children: .combine)
                
                
                TimeBar(id: 2, disableValue: $voiceRecognition.resetBarsManager.disabledBars[2], resetValue: $voiceRecognition.resetBarsManager.resetBars[2], currentState: $currentState).environmentObject(voiceRecognition)
                    .frame(height: 20)
                HStack{
                    if voiceRecognition.currentLetters[2] != " " && voiceRecognition.resetBarsManager.disabledBars[2] != true{
                        Text("\(String(voiceRecognition.currentLetters[2]).uppercased())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .animation(.easeOut)
                        Button(action: {
                            voiceRecognition.hintConsumed=true
                            hint = voiceRecognition.getHint(startingWith: voiceRecognition.currentLetters[2], of: voiceRecognition.currentCategory)
                            voiceRecognition.hintActive=true
                        }
                        )
                        {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(voiceRecognition.hintConsumed ? .gray : .yellow)
                                .opacity(voiceRecognition.hintConsumed ? 0.2 : 1)
                                .padding() 
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Hint")
                        }.disabled(voiceRecognition.hintConsumed ? true : false)
                    }
                    else{Text("\(String(voiceRecognition.currentLetters[2]).uppercased())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .opacity(0)
                            .animation(.easeOut)
                        Button(action: {
                            voiceRecognition.hintConsumed=true
                            hint = voiceRecognition.getHint(startingWith: voiceRecognition.currentLetters[2], of: voiceRecognition.currentCategory)
                            voiceRecognition.hintActive=true
                        }
                        )
                        {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(voiceRecognition.hintConsumed ? .gray : .yellow)
                                .opacity(0)
                                .padding()
                        }
                        .disabled(true)
                    }
                }

            }
            
            HStack{
                
                TimeBar(id: 1, disableValue: $voiceRecognition.resetBarsManager.disabledBars[1], resetValue: $voiceRecognition.resetBarsManager.resetBars[1], currentState: $currentState).environmentObject(voiceRecognition)
                    .frame(height: 20)
                    .rotationEffect(Angle.degrees(270))
                
                
                
                
                TimeBar(id: 3, disableValue: $voiceRecognition.resetBarsManager.disabledBars[3], resetValue: $voiceRecognition.resetBarsManager.resetBars[3], currentState: $currentState).environmentObject(voiceRecognition)
                    .frame(height: 20)
                    .rotationEffect(Angle.degrees(270))
                
                
                
                
                
            }
            
            HStack{
                VStack{
                    if voiceRecognition.currentLetters[1] != " " && voiceRecognition.resetBarsManager.disabledBars[1] != true{
                        Text("\(String(voiceRecognition.currentLetters[1]).uppercased())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .animation(.easeOut)
                        Button(action: {
                            voiceRecognition.hintConsumed=true
                            hint = voiceRecognition.getHint(startingWith: voiceRecognition.currentLetters[1], of: voiceRecognition.currentCategory)
                            voiceRecognition.hintActive=true
                        }
                        )
                        {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(voiceRecognition.hintConsumed ? .gray : .yellow)
                                .opacity(voiceRecognition.hintConsumed ? 0.2 : 1)
                                .padding()
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Hint")
                        }.disabled(voiceRecognition.hintConsumed ? true : false)
                    }
                    else{Text("\(String(voiceRecognition.currentLetters[1]).uppercased())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .opacity(0)
                            .animation(.easeOut)
                        Button(action: {
                            voiceRecognition.hintConsumed=true
                            hint = voiceRecognition.getHint(startingWith: voiceRecognition.currentLetters[1], of: voiceRecognition.currentCategory)
                            voiceRecognition.hintActive=true
                        }
                        )
                        {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(voiceRecognition.hintConsumed ? .gray : .yellow)
                                .opacity(0)
                                .padding()
                        }
                        .disabled(true)
                    }
                }
                
                    .padding()
                
                Spacer()
                ZStack{
                    
                    VStack{
                        Text(emojiDictionary[voiceRecognition.currentCategory]!)
                            .font(.system(size: 100))
                            .accessibilityLabel("Category")
                        Text(voiceRecognition.currentCategory)
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                        .fontWeight(.bold)}
                    .accessibilityElement(children: .combine)
                    
                }
                                Spacer()
                
                VStack{
                    if voiceRecognition.currentLetters[3] != " " && voiceRecognition.resetBarsManager.disabledBars[3] != true{
                        Text("\(String(voiceRecognition.currentLetters[3]).uppercased())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .animation(.easeOut)
                        Button(action: {
                            voiceRecognition.hintConsumed=true
                            hint = voiceRecognition.getHint(startingWith: voiceRecognition.currentLetters[3], of: voiceRecognition.currentCategory)
                            voiceRecognition.hintActive=true
                        }
                        )
                        {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(voiceRecognition.hintConsumed ? .gray : .yellow)
                                .opacity(voiceRecognition.hintConsumed ? 0.2 : 1)
                                .padding()
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Hint")
                        }.disabled(voiceRecognition.hintConsumed ? true : false)
                    }
                    else{Text("\(String(voiceRecognition.currentLetters[3]).uppercased())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .opacity(0)
                            .animation(.easeOut)
                        Button(action: {
                            voiceRecognition.hintConsumed=true
                            hint = voiceRecognition.getHint(startingWith: voiceRecognition.currentLetters[3], of: voiceRecognition.currentCategory)
                            voiceRecognition.hintActive=true
                        }
                        )
                        {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(voiceRecognition.hintConsumed ? .gray : .yellow)
                                .opacity(0)
                                .padding()
                        }
                        .disabled(true)
                    }
                }
                    .padding()
                
            }
            
            
            
            
        }.onAppear(){
            voiceRecognition.startRecognizing()

        }
        

    }
}

