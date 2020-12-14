//
//  ImageSampleView.swift
//  SwiftUIPractice
//
//  Created by Stanly Shiyanovskiy on 14.11.2020.
//

import SwiftUI

struct ImageSampleView: View {
    var body: some View {
        Image("paris")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .overlay(
                Color.black
                    .opacity(0.4)
                    .overlay(
                        Text("Paris")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .frame(width: 200)
                    )
            )
    }
}

struct ImageSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSampleView()
    }
}
