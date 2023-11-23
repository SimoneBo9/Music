//
//  Categories.swift
//  Music
//
//  Created by Simone Boni on 23/11/23.
//

import Foundation

import SwiftUI

struct CategoriesModel: Identifiable {
    var id: UUID = UUID()
    var category: String
    var image: String
    
    static var categories: [Self] = [
        .init(category: "Playlist", image: "music.note.list"),
        .init(category: "Artists", image: "music.mic"),
        .init(category: "Albums", image: "square.stack"),
        .init(category: "Songs", image: "music.note"),
        .init(category: "Music Videos", image: "music.note.tv"),
        .init(category: "Genres", image: "guitars"),
        .init(category: "Compilation", image: "person.2.crop.square.stack"),
        .init(category: "Composer", image: "music.quarternote.3")
    ]
}
