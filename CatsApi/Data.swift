//
//  Data.swift
//  CatPhotos
//
//  Created by Dream Store on 25.10.2021.
//

import Foundation
import SwiftUI

struct Cat: Codable, Identifiable {
    var id = String()
    var url: String
    var breeds: [CatDesctiprion]
    
}

struct CatDesctiprion: Codable {
    var name: String
}
