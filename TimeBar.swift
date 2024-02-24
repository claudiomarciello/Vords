import SwiftUI

struct TimeBar: View {
    @State var id: Int
    @Binding var disableValue: Bool
    @Binding var resetValue: Bool
    @State private var progress: Double = 0.0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @EnvironmentObject var voiceRecognition: VoiceRecognition
    @Binding var currentState: GameState

    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(                
                    voiceRecognition.resetBarsManager.disabledBars[id]==true ? Color.black : Color.gray)
                    .frame(width: geometry.size.width, height: 10)
                Rectangle()
                    .foregroundColor(self.getColor())
                    .frame(width: self.getProgressWidth(geometryWidth: geometry.size.width), height: 10)
                    .animation(.linear(duration: 1.0))
            }
        }
        .onReceive(timer) { _ in
            if(voiceRecognition.currentLetters[id] != " "){
                self.progress += 0.066
                if self.progress >= 1 {
                    voiceRecognition.resetBarsManager.disabledBars[id] = true
                    voiceRecognition.opacityChange.toggle()
                    self.timer.upstream.connect().cancel()
                }}
            if voiceRecognition.resetBarsManager.disabledBars[0] == true && voiceRecognition.resetBarsManager.disabledBars[1] == true && voiceRecognition.resetBarsManager.disabledBars[2] == true && voiceRecognition.resetBarsManager.disabledBars[3] == true {
                voiceRecognition.saveData()
                currentState = .gameOver                    }

                
        }
        .onChange(of: resetValue) { _ in
            if                 voiceRecognition.resetBarsManager.disabledBars[id] != true
            {
                self.progress = 0.0
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
            voiceRecognition.resetBarsManager.disabledBars[id]=true
            return Color.black 
            
            
        } else if percent > 50 {
            return Color(red: 1, green: 1 - (percent - 50) / 50, blue: 0)
        } else {
            return Color(red: percent / 50, green: 1, blue: 0)
        }
    }

    

}



#Preview {
        ContentView(currentState: .constant(.startview))
  

}
