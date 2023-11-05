//
//  Note.swift
//  NoteApp
//
//  Created by Mariam Joglidze on 05.11.23.
//

import Foundation

class Note {
    var title: String
    var description: String
    
    init(title: String = "", description: String) {
        self.title = title
        self.description = description
    }
    
    static let dummyData: [Note] = [
        Note(title: "1", description: "vashli"),
        Note(title: "2", description: "banan"),
        Note(title: "3", description: "atami"),
        Note(title: "4", description: "kivi"),
        Note(title: "5", description: "dfsvcdfa"),
        Note(title: "6", description: "dfsvcdfa"),

        
    ]
}



