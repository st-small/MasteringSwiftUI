//
//  Photo.swift
//  SwiftUI_PhotoGrid
//
//  Created by Stanly Shiyanovskiy on 04.12.2020.
//

import Foundation

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
