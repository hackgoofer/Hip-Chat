//
//  MorseCodeTranslator.swift
//  HipChat
//
//  Created by Sasha Sheng on 5/9/15.
//  Copyright (c) 2015 Sasha Sheng. All rights reserved.
//

import Foundation

class MorseCodeTranslator: NSObject {
    var morseDictionary: [String : String]
    var morseCodes : String?
    
    override init() {
        self.morseCodes = String();
        self.morseDictionary = [""      : " ",
                                ".-"    : "A",
                                "-..."  : "B",
                                "-.-."  : "C",
                                "-.."   : "D",
                                "."     : "E",
                                "..-."  : "F",
                                "--."   : "G",
                                "...."  : "H",
                                ".."    : "I",
                                ".---"  : "J",
                                "-.-"   : "K",
                                ".-.."  : "L",
                                "--"    : "M",
                                "-."    : "N",
                                "---"   : "O",
                                ".--."  : "P",
                                "--.-"  : "Q",
                                ".-."   : "R",
                                "..."   : "S",
                                "-"     : "T",
                                "..-"   : "U",
                                "...-"  : "V",
                                ".--"   : "W",
                                "-..-"  : "X",
                                "-.--"  : "Y",
                                "--.."  : "Z",
                                "-----" : "0",
                                ".----" : "1",
                                "..---" : "2",
                                "...--" : "3",
                                "....-" : "4",
                                "....." : "5",
                                "-...." : "6",
                                "--..." : "7",
                                "---.." : "8",
                                "----." : "9",
                                ".-.-.-": ".",
                                "--..--": ",",
                                "---...": ":",
                                "..--..": "?",
                                ".----.": "'",
                                "-....-": "-",
                                "-..-." : "/",
                                ".-..-.": "\"",
                                ".--.-.": "@",
                                "-...-" : "="];
    }
    
    func collect(morseCode: Character) {
        morseCodes = morseCodes! + String(morseCode)
    }
    
    func getMorseCollection(Void) -> String {
        return morseCodes!;
    }
    
    func clearMorseCollection() {
        morseCodes = String();
    }
    
    func getTranslation(andClearMorseCollection: Bool) -> String? {
        var code: String = self.getMorseCollection();
        
        if andClearMorseCollection {
            clearMorseCollection();
        }
        return morseDictionary[code];
    }
    
}
