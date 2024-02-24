//
//  TutorialTimeBar.swift
//  Vords
//
//  Created by Claudio Marciello on 15/02/24.
//

import SwiftUI

struct TutorialTimeBar: View {
    @State var step: Int = 1
    @State var id: Int
    @Binding var tutorialState: Int
    @Binding var disableValue: Bool
    @Binding var resetValue: Bool
    @State private var progress: Double = 0.0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @ObservedObject var voiceRecognition: VoiceRecognition
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray)
                    .frame(width: geometry.size.width, height: 10)
                Rectangle()
                    .foregroundColor(self.getColor())
                    .frame(width: self.getProgressWidth(geometryWidth: geometry.size.width), height: 10)
                    .animation(.linear(duration: 1.0))
            }
        }
        .onReceive(timer) { _ in

            if tutorialState==1 {
                self.progress = 0.2
            }
            if tutorialState==2 {
                self.progress = 0.4
            }
            if tutorialState==3{
                self.progress=0.6
            }
            if tutorialState==4 {
                self.progress = 0.8
            }
            }
        


    }
    
    func getProgressWidth(geometryWidth: CGFloat) -> CGFloat {
        let width = CGFloat(progress) * geometryWidth
        return width > geometryWidth ? geometryWidth : width
    }
    
    func getColor() -> Color {
        
        let percent = progress * 100
        if percent >= 100 {
            return Color.black 
            
        } else if percent > 50 {
            return Color(red: 1, green: 1 - (percent - 50) / 50, blue: 0)
        } else {
            return Color(red: percent / 50, green: 1, blue: 0)
        }
    }

    

}


