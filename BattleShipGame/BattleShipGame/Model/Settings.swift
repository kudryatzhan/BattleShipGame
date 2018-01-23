//
//  Settings.swift
//  BattleShipGame
//
//  Created by Kudryatzhan Arziyev on 1/9/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

struct Settings {
    
    // Language enum
    enum Language {
        case english
        case russian
    }
    
    var language: Language
    var soundIsOn = true
    var playerName: String
}
