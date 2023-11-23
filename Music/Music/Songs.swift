//
//  Songs.swift
//  Music
//
//  Created by Simone Boni on 16/11/23.
//

import Foundation

import SwiftUI

struct SongsModel: Identifiable {
    var id: UUID = UUID()
    var title: String
    var image: String
    
    static var songs: [Self] = [
        .init(title: "First song", image: "Heart"),
        .init(title: "Second song", image: "Dolphin"),
        .init(title: "Third song", image: "Tree"),
        .init(title: "Fourth song", image: "Maldives"),
    ]
}
