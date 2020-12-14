//
//  Photo.swift
//  SwiftUI_GridViewAnimation
//
//  Created by Stanly Shiyanovskiy on 10.12.2020.
//

import Foundation

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
