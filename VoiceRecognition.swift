import SwiftUI
import AVFoundation
import Speech
import SwiftData

import Foundation

extension Dictionary {
       
   var jsonData: Data? {
      return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
   }
       
   func toJSONString() -> String? {
      if let jsonData = jsonData {
         let jsonString = String(data: jsonData, encoding: .utf8)
         return jsonString
      }
      return nil
   }
}

func convertDictionaryToJSONAndSaveToFile(_ dictionary: [String: Any], fileName: String) {
    var serializableDictionary = dictionary
    
    // Convert sets to arrays of strings in the dictionary
    for (key, value) in serializableDictionary {
        if let set = value as? Set<Character> {
            let array = Array(set).map { String($0) }
            serializableDictionary[key] = array
        }
    }

    // Convert dictionary to JSON string
    guard let jsonData = try? JSONSerialization.data(withJSONObject: serializableDictionary, options: []),
          let jsonString = String(data: jsonData, encoding: .utf8) else {
        print("Failed to convert dictionary to JSON string.")
        return
    }

    // Save JSON string to file
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName + ".json")
    do {
        try jsonString.write(to: fileURL!, atomically: true, encoding: .utf8)
        print("JSON data saved to file:", fileURL!)
    } catch {
        print("Error saving JSON data to file:", error)
    }
}

func loadJSONFromFile(fileName: String) -> [String: Any]? {
    // Get the URL of the JSON file in the app's document directory
    guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName + ".json") else {
        print("Failed to get file URL.")
        return nil
    }

    do {
        // Read the JSON data from the file
        let jsonData = try Data(contentsOf: fileURL)
        
        // Decode the JSON data into a dictionary
        guard let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            print("Failed to decode JSON data into a dictionary.")
            return nil
        }
        
        return jsonDictionary
    } catch {
        print("Error reading JSON file:", error)
        return nil
    }
}




class VoiceRecognition: ObservableObject {
    
    @Published var opacityChange: Bool = false
    
    
    @Published var tutorialComplete = false
    
    let alphabetSet: Set<Character> = Set("abcdefghilmnopqrstuvz")
    @Published var availableLetters: Set<Character> = []
    @Published var currentLetters: [Character] = [" ", " ", " ", " "]
    
    @Published var currentHints: [String] = [" "," "," "," "]
    @Published var hintActive: Bool = false
    @Published var hintConsumed: Bool = false

    
    @Published var currentCategory: String = "Animals"
    @Published var categories: [String] = ["Animals", "Jobs", "Fruits", "Sports"]
    @Published var getCategory: [String: Set<String>] = ["Animals": Animals, "Fruits": Fruits, "Jobs": Jobs, "Sports": Sports]
    @Published var completedLetters: [String: Set<Character>] = ["Animals": Set(""),"Fruits": Set(""),"Jobs": Set(""),"Sports": Set("u")]
    @Published var lastWord: String = ""
    @Published var lastWordCorrect = false
    @ObservedObject var resetBarsManager: ResetBarsManager
    
    init(resetBarsManager: ResetBarsManager) {
        self.resetBarsManager = resetBarsManager
        startCategoryTimer()
        
    }
    
    private var transcription = ""
    private var audioEngine: AVAudioEngine!
    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioInputNode: AVAudioInputNode?
    
    func stopListening() {
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
    }
    
    func startRecognizing() {
        setupGame()
        audioEngine = AVAudioEngine()
        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        
        do {
            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                self.recognitionRequest?.append(buffer)
            }
            
            try audioEngine.start()
            print("Engine started")
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!, resultHandler: { (result, error) in
                if let result = result {
                    if let last = result.bestTranscription.segments.last?.substring {
                        let last = last.lowercased()
                        if correctors.keys.contains(last.lowercased()){
                            self.lastWord = correctors[last.lowercased()]!}
                        else{
                            self.lastWord = last}

                        let firstLetter = self.lastWord.first

                        print("Last Word: \(self.lastWord)")
                        if (self.lastWord == "cat" || self.lastWord == "alpaca" || self.lastWord == "dog" || self.lastWord == "bunny") && self.tutorialComplete==false{
                            self.tutorialComplete = true
                        }
                        if self.getCategory[self.currentCategory]?.contains(self.lastWord)==true  {
                            self.lastWordCorrect = true
                            self.completedLetters[self.currentCategory]?.insert(firstLetter!)
                            self.availableLetters = self.alphabetSet.subtracting(self.completedLetters[self.currentCategory]!).subtracting(Set<Character>(self.currentLetters))
                            if(self.availableLetters.count>4){
                                self.changeFirstOccurrence(of: firstLetter!, in: &self.currentLetters, to: self.selectRandomLetter()!)}
                            else{
                                self.changeFirstOccurrence(of: firstLetter!, in: &self.currentLetters, to: " ")
                            }
                            self.transcription = result.bestTranscription.formattedString.lowercased()
                            self.tutorialComplete = true
                        }
                        else{self.lastWordCorrect = false}
                        if self.lastWord != ""{ self.lastWord=self.lastWord.prefix(1).uppercased()+self.lastWord.suffix(self.lastWord.count-1)}
                        
                    }
                } else if let error = error {
                    print("Recognition error: \(error)")
                }
            })
        } catch {
            print("Audio engine setup error: \(error)")
        }
        
        
        
    }
    
    
    func transcriptionContainsLastWord(transcription: String, lastWord: String) -> Bool {
        let range = transcription.range(of: lastWord)
        return range != nil
    }
    
    func selectRandomLetter() -> Character? {
        guard !self.availableLetters.isEmpty else {
            return nil
        }
        let randomIndex = Int.random(in: 0..<availableLetters.count)
        let randomLetter = availableLetters[availableLetters.index(availableLetters.startIndex, offsetBy: randomIndex)]
        return randomLetter
    }
    
    func changeLetter(in array: inout [Character], atIndex index: Int, to newLetter: Character) {
        guard index >= 0 && index < array.count else {
            print("Index out of bounds")
            return
        }
        
        resetBarsManager.resetBars[index].toggle()
        
        array[index] = newLetter
        
        print("Letter changed in \(newLetter)")
        
        
    }
    
    func changeFirstOccurrence(of targetLetter: Character, in array: inout [Character], to newLetter: Character) {
        if let index = array.firstIndex(of: targetLetter) {
            
            changeLetter(in: &array, atIndex: index, to: newLetter)
        } else {
            print("Letter not found in array")
        }
    }
    
    private func startCategoryTimer() {
            Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
                self.changeCategory()
            }
        
        }
        
    private func changeCategory() {
        var selectedLetters: [Character] = []
        var categories = ["Animals", "Sports", "Fruits", "Jobs"]
        var availableCategories: [String] = []


        for category in categories{
            if completedLetters[category] != alphabetSet
            {availableCategories.append(category)}
        }
        if availableCategories.count > 1 {
            availableCategories.removeAll { $0 == currentCategory }
        }

        guard let newCategory = availableCategories.randomElement() else {
            print("No other categories available")
            resetBarsManager.disabledBars[0]=true
            resetBarsManager.disabledBars[1]=true
            resetBarsManager.disabledBars[2]=true
            resetBarsManager.disabledBars[3]=true

            
            return
        }

        if hintActive==true{
            hintActive=false
        }
        self.currentCategory = newCategory

        self.availableLetters = alphabetSet.subtracting(completedLetters[currentCategory]!)

        if availableLetters.count > 3 {
            let shuffledLetters = availableLetters.shuffled()
            selectedLetters = Array(shuffledLetters.prefix(4))
        } else {
            selectedLetters = (availableLetters + Array(repeating: " ", count: 4 - availableLetters.count)).shuffled()
        }

        withAnimation(Animation.easeOut(duration: 0.5))  {
            self.currentLetters = selectedLetters
        }
        print("Category changed: \(currentCategory), Current Letters: \(currentLetters)")

    }
    
    func setupGame(){
        loadData()
        hintConsumed=false
        resetBarsManager.disabledBars[0] = false
        resetBarsManager.disabledBars[1] = false
        resetBarsManager.disabledBars[2] = false
        resetBarsManager.disabledBars[3] = false
        changeCategory()


        
    }
    
    
    func loadData(){
        if let jsonDictionary = loadJSONFromFile(fileName: "Data") as? [String: [String]] {
            var completedLetters = [String: Set<Character>]()
            for (key, value) in jsonDictionary {
                let characterSet = Set(value.joined())
                completedLetters[key] = characterSet
            }
            
            self.completedLetters = completedLetters
            print("Data loaded")
        } else {
            print("Failed to load or convert JSON data.")
        }
    }
    
    func saveData(){
        convertDictionaryToJSONAndSaveToFile(completedLetters, fileName: "Data")
    }
    
    func getHint(startingWith letter: Character, of category: String) -> String {
            let set: Set<String>
            switch category {
            case "Animals":
                set = Animals
            case "Sports":
                set = Sports
            case "Jobs":
                set = Jobs
            case "Fruits":
                set = Fruits
            default:
                return "No set found for letter \(letter)"
            }
            let wordsStartingWithLetter = set.filter {
                
                $0.lowercased().hasPrefix(String(letter)) }
            guard let randomWord = wordsStartingWithLetter.randomElement() else {
                return "No word found starting with \(letter)"
            }
        return randomWord.prefix(1).uppercased()+randomWord.suffix(randomWord.count-1)
        }
    
    
    
    
}
