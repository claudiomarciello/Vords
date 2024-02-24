//
//  ContainerView.swift
//  Vords
//
//  Created by Claudio Marciello on 13/02/24.
//

import SwiftUI

enum GameState {
    case startview
    case mainScreen
    case tutorial
    case gameOver
}

class ResetBarsManager: ObservableObject {
    @Published var resetBars = [false, false, false, false]
    @Published var disabledBars = [false, false, false, false]
}    

struct ContainerView: View {
    
    
    @ObservedObject var voiceRecognition: VoiceRecognition = VoiceRecognition(resetBarsManager: ResetBarsManager())
    @State var currentState: GameState = .startview

    
    var body: some View {

        switch currentState {
        case .startview:
            StartView(currentState: $currentState).environmentObject(voiceRecognition)
        case .gameOver:
            GameOverView(currentState: $currentState)
                .environmentObject(voiceRecognition)
        case .tutorial:
            TutorialView(currentState: $currentState)
                .environmentObject(voiceRecognition)
        default:
            ContentView(currentState: $currentState).environmentObject(voiceRecognition)

        }
    }}
