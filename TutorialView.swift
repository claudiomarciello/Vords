//
//  TutorialView.swift
//  Vords
//
//  Created by Claudio Marciello on 13/02/24.
//

import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var voiceRecognition: VoiceRecognition
    @Binding var currentState: GameState
    @State var TutorialState: Int = 1
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            HStack{
                Spacer()
                VStack{
                    Button(action: {
                        voiceRecognition.tutorialComplete = true
                        currentState = .startview
                    }) {
                        Text("Skip")
                            .padding()
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel("Skip")
                    Spacer()
                }
            }
            VStack {
                Text("A")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .opacity(TutorialState==1 ? 0.2 : 1)
                
                
                
                TutorialTimeBar(id: 0, tutorialState: $TutorialState, disableValue: .constant(true), resetValue: .constant(false), voiceRecognition: voiceRecognition)
                    .frame(height: 20)
                    .opacity(TutorialState != 5 ? 0.2 : 1)
                Spacer()
                
                Text("\(voiceRecognition.lastWord)")
                
                
                TutorialTimeBar(id: 2, tutorialState: $TutorialState, disableValue: .constant(false), resetValue: .constant(false), voiceRecognition: voiceRecognition)
                    .frame(height: 20)
                    .opacity(TutorialState != 5 ? 0.2 : 1)
                                
                Text("C")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .opacity(TutorialState==1 ? 0.2 : 1)
                
                
            }
            
            HStack{
                
                TutorialTimeBar(id: 1, tutorialState: $TutorialState, disableValue: .constant(true), resetValue: .constant(false), voiceRecognition: voiceRecognition)
                    .frame(height: 20)
                    .opacity(TutorialState != 5 ? 0.2 : 1)
                
                    .rotationEffect(Angle.degrees(270))
                
                
                
                
                TutorialTimeBar(id: 3, tutorialState: $TutorialState, disableValue: .constant(true), resetValue: .constant(false), voiceRecognition: voiceRecognition)
                    .frame(height: 20)
                    .opacity(TutorialState != 5 ? 0.2 : 1)
                
                    .rotationEffect(Angle.degrees(270))
            }
            
            HStack{
                Text("B")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .opacity(TutorialState==1 ? 0.2 : 1)
                    .padding()
                
                Spacer()
                VStack{
                    Text("😽")
                        .font(.system(size: 100))
                        .accessibilityLabel("Category")
                    Text("Animals")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                    .fontWeight(.bold)}
                .accessibilityElement(children: .combine)
                Spacer()
                Text("D")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .opacity(TutorialState==1 ? 0.2 : 1)
                    .padding()
            }
        }.onAppear{
            voiceRecognition.startRecognizing()
        }
        .overlay(){
            if TutorialState == 1{
                ZStack{
                    VStack{
                        Spacer().frame(height: 200)
                        Text("This is the current category")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Spacer()}
                    VStack{
                        Spacer()
                        Button(action: {
                            TutorialState=2
                            
                        })
                        {
                            
                            Text("Next")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                        .shadow(color: .gray, radius: 5, x: 0, y: 2)
                                )
                                .frame(width: 200, height: 60)
                            
                        }
                        .padding(.bottom, 300)
                    }
                    
                    
                }}
            if TutorialState == 2 {
                ZStack{
                    VStack {
                        Spacer().frame(height: 200)
                        VStack{Text("Using the letters on screen's borders:")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                            
                            Text("Say a name related to the current Category")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }.accessibilityElement(children: .combine)
                        .padding()
                        
                    }
                    VStack{
                        Spacer()
                        Button(action: {
                            TutorialState=3
                            
                        })
                        {
                            
                            Text("Next")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                        .shadow(color: .gray, radius: 5, x: 0, y: 2)
                                )
                                .frame(width: 200, height: 60)
                            
                        }
                        .padding(.bottom, 300)
                    }
                }
            }
            if TutorialState == 3 {
                ZStack{
                    VStack{
                        Image(systemName: "arrow.up")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white)
                        
                        
                        Spacer()
                        HStack{
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.white)
                            
                            
                            Spacer()
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.white)
                            
                        }
                        Spacer()
                        Image(systemName: "arrow.down")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white)
                        
                    }.padding(100)
                    VStack {
                        Spacer().frame(height: 300)
                        VStack{Text("The current letters are:")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Text("A, B, C, D")
                                .font(.title)
                                .fontWeight(.bold)
                            .foregroundStyle(.white)}.accessibilityElement(children: .combine)
                        Spacer()
                        .padding()}
                    VStack{Spacer()
                        Button(action: {
                            TutorialState+=1
                            
                        })
                        {
                            
                            Text("Next")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                        .shadow(color: .gray, radius: 5, x: 0, y: 2)
                                )
                                .frame(width: 200, height: 60)
                            
                        }
                        .padding(.bottom, 300)
                    }
                }
            }
            if TutorialState == 4{
                ZStack{
                    VStack {
                        Spacer().frame(height: 200)
                        VStack{
                            Text("Try to say")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .multilineTextAlignment(.center)
                            Text("Alpaca, Bunny, Cat or Dog")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .multilineTextAlignment(.center)
                            Spacer()

                        }.accessibilityElement(children: .combine)
                        .padding()
                    }
                    
                    VStack{
                        Spacer()
                        Button(action: {
                            TutorialState+=1
                            
                        })
                        {
                            
                            Text("Next")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .opacity(voiceRecognition.tutorialComplete ? 1 : 0.2)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(voiceRecognition.tutorialComplete==true ? .green : .white))
                                .frame(width: 200, height: 60)
                            
                        }
                        .padding(.bottom, 300)
                        .disabled(voiceRecognition.tutorialComplete==false ? true : false)
                    }
                }
            }
            if TutorialState == 5{
                ZStack{
                    VStack{
                        Spacer().frame(height: 200)
                        Text("Congratulations!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Spacer()

                    }
                    VStack{
                        Spacer()
                    Button(action: {
                        currentState = .startview
                    })
                    {
                        
                            Text("End")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                        .shadow(color: .gray, radius: 5, x: 0, y: 2)
                                )
                                .frame(width: 200, height: 60)
                            
                        }
                        .padding(.bottom, 300)
                    }
                }
            }
        }
    }}

        
        


#Preview{
    TutorialView(currentState: .constant(.tutorial)).environmentObject(VoiceRecognition(resetBarsManager: ResetBarsManager()))
}



