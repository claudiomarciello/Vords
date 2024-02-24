//
//  Words.swift
//  Vords
//
//  Created by Claudio Marciello on 08/02/24.
//

import Foundation


let emojiDictionary: [String: String] = [
        "Animals": "😽",
        "Sports": "🏈",
        "Jobs": "🛠️",
        "Fruits": "🍎"
    ]

var correctors: [String: String] = ["and":"ant",
                                    "bad":"bat",
                                    "b": "bee",
                                    "be":"bee",
                                    "hair":"hare",
                                    "links":"lynx",
                                    "nude":"newt",
                                    "mute":"newt",
                                    "numb":"numbat",
                                    "nala":"nyala",
                                    "kaka":"quokka",
                                    "quetzel":"quetzal",
                                    "wakare":"uakari",
                                    "oogies":"uguisu",
                                    "uuuu":"uguisu",
                                    "oreo":"urial",
                                    "uriel":"urial",
                                    "mistakes":"uromastyx",
                                    "mastics":"uromastyx",
                                    "via":"vicuña",
                                    "zombie":"zonkey",
                                    "zarilla":"zorilla",
                                    "source":"zorse",
                                    "eastport":"e-sport",
                                    "huge":"luge",
                                    "nice":"novuss",
                                    "nervous":"novuss",
                                    "novice":"novuss",
                                    "quit":"quoits",
                                    "quite":"quoits",
                                    "lining":"ziplining",
                                    "absorbing":"zorbing",
                                    "maker":"keymaker",
                                    "minor":"miner",
                                    "neologist":"ornithologist",
                                    "quester":"questor",
                                    "question":"questor",
                                    "dragon":"dragonfruit",
                                    "elder":"elderfruit",
                                    "ebay":"imbe",
                                    "queens":"quince",
                                    "current":"redcurrant",
                                    "camarillo":"tamarillo",
                                    "ugly":"ugni",
                                    "varia":"uvaria",
                                    "vanga":"voavanga",
                                    "zaka":"zalacca"]

var Animals: Set<String> = ["ant", "ape", "antelope", "alpaca", "anteater", "armadillo",
 "bat", "bear", "bison", "bunny", "beaver","bee",
 "cat", "cow", "crow", "camel", "cheetah", "chameleon",
 "dog", "deer", "dolphin", "duck", "donkey",
 "elk", "eagle", "elephant", "eel", "emu",
 "fox", "frog", "falcon", "flamingo", "ferret",
 "goat", "gorilla", "gazelle", "goose", "giraffe",
 "horse", "hare", "hyena", "hawk", "hamster",
 "ibex", "impala", "iguana", "inchworm", "insect",
 "lion", "llama", "leopard", "lemur", "lynx",
 "monkey", "moose", "mouse", "mule", "mongoose",
 "newt", "narwhal", "nighthawk", "numbat", "nyala",
 "owl", "otter", "octopus", "ostrich", "orangutan",
 "pig", "penguin", "panther", "parrot", "porcupine", "panda",
 "quail", "quokka", "quoll", "quetzal", "queen bee",
 "rabbit", "raccoon", "reindeer", "rhinoceros", "rat",
 "snake", "sheep", "seal", "sloth", "squirrel",
 "tiger", "turtle", "toucan", "turkey", "tarantula",
 "uakari", "uguisu", "urchin", "urial", "uromastyx",
 "vulture", "vervet", "viper", "vicuña", "vaquita",
 "zebra", "zebu", "zonkey", "zorilla", "zorse"]


var Sports: Set<String> = ["archery", "athletics", "aquatics", "basketball", "baseball", "badminton", "cricket", "cycling", "climbing", "diving","dodgeball", "decathlon", "equestrianism", "e-sports", "football", "fencing", "golf", "gymnastics", "gliding", "hockey", "handball", "hiking", "iron man", "lacrosse", "luge", "marathon", "mountain biking", "mma", "netball", "novuss", "orienteering", "polo", "powerlifting", "parkour", "paintball", "quidditch", "quoits", "rugby", "rowing", "rock climbing", "soccer", "swimming", "surfing", "tennis", "triathlon", "volleyball", "vaulting", "ziplining", "zorbing"]


var Jobs: Set<String> = ["artist", "actor", "accountant", "architect", "astronomer", "baker", "barber", "biologist", "butcher", "banker", "chef", "carpenter", "cleaner", "counselor", "composer", "doctor", "dentist", "dancer", "driver", "detective", "engineer", "electrician", "economist", "editor", "educator", "farmer", "firefighter", "fisherman", "florist", "forester", "gardener", "geologist", "gambler", "genealogist", "hairdresser", "historian", "housekeeper", "hunter", "handyman", "illustrator", "interpreter", "inspector", "investor", "inventor", "lawyer", "librarian", "lifeguard", "locksmith", "landscaper", "musician", "mechanic", "magician", "miner", "model", "nurse", "novelist", "nutritionist", "notary", "numerologist", "optometrist", "orthodontist", "ophthalmologist", "ornithologist", "pilot", "painter", "photographer", "plumber", "pharmacist", "quilter", "quaestor", "reporter", "receptionist", "roofer", "referee", "radiologist", "scientist", "surgeon", "soldier", "sailor", "secretary", "teacher", "tailor", "technician", "translator", "umpire", "underwriter", "upholsterer", "veterinarian", "violinist", "vocalist", "valet", "vintner", "zoologist", "zester"]

var Fruits: Set<String> = [
    "apple", "apricot", "avocado", "banana", "blueberry", "blackberry", "cherry", "coconut", "clementine", "date", "dragonfruit", "durian", "elderberry", "elderfruit",  "fig", "feijoa", "grape", "guava", "grapefruit", "honeydew", "huckleberry", "imbe",  "lemon", "lime", "lychee", "mango", "mandarin", "mulberry", "nectarine", "nance", "orange", "olive", "pear", "peach", "plum", "quince", "quandong", "raspberry", "rambutan", "redcurrant", "strawberry", "starfruit", "satsuma", "tomato", "tamarillo", "tangerine", "ugni", "uvaria", "vanilla", "voavanga", "zucchini", "zapote", "zalacca"]
