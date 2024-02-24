//
//  Onboarding.swift
//  Vords
//
//  Created by Claudio Marciello on 13/02/24.
//

import Foundation
import SwiftUI

extension Color {
    static let VordsBlue = Color(red: 192/255, green: 210/255, blue: 218/255, opacity: 1)
}

extension Text {
    func foregroundLinearGradient(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
            .mask(self)
    }
}

struct StartView: View {    
    @EnvironmentObject var voiceRecognition: VoiceRecognition
    @Binding var currentState: GameState
    @State private var shouldAnimate = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                VStack{
                    Text("Welcome to")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaleEffect(shouldAnimate ? 1.2 : 0.8)
                        .padding()
                    
                    Text("Vords!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundLinearGradient(colors: [Color.white, Color.VordsBlue])
                        .scaleEffect(shouldAnimate ? 1.2 : 1)
                        .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                        .onAppear() {
                            self.shouldAnimate = true
                        }}
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("Welcome to Vords!")
                Spacer()
                Text("Guess the words with your voice!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Do you know a word for each letter in each category?")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.VordsBlue)
                    .multilineTextAlignment(.center)
                Button(action: {
                    currentState = .mainScreen
                    
                }) {
                    Text("Start")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                                .shadow(color: .gray, radius: 5, x: 0, y: 2)
                        )
                        .frame(width: 240, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                                .blendMode(.overlay)
                                .padding(-4)
                        )
                }.padding()
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel("Start")
                Button(action: {
                    currentState = .tutorial
                }) {
                    Text("Tutorial")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.VordsBlue)
                                .shadow(color: .VordsBlue, radius: 5, x: 0, y: 2)
                        )
                        .frame(width: 300, height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.VordsBlue, lineWidth: 2)
                                .blendMode(.overlay)
                                .padding(-4)
                        )
                }.padding(.bottom, 150)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel("Tutorial")
                
                Button(action: {
                    voiceRecognition.loadData()
                    currentState = .gameOver
                }) {
                    Text("Guessed Letters")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.VordsBlue)
                                .shadow(color: .VordsBlue, radius: 5, x: 0, y: 2)
                        )
                        .frame(width: 300, height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.VordsBlue, lineWidth: 2)
                                .blendMode(.overlay)
                                .padding(-4)
                        )
                }.padding(.bottom, 150)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel("Guessed Letters")
            }
        }
        }
    }
        

#Preview {
    StartView(currentState: .constant(.startview))
}



