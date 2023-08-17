//
//  RatingView.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/17.
//

import SwiftUI

struct Star: View {
    var ratio: Double

    var body: some View {
        GeometryReader { star in
            ZStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.yellow)
                    .mask {
                        Rectangle()
                            .size(
                                width: star.size.width * ratio,
                                height: star.size.height
                            )
                    }
            }
        }
    }
}

struct RatingView: View {
    var score: Double
    
    var body: some View {
        HStack {
            ForEach(1..<6) { i in
                if score >= Double(i) {
                    Star(ratio: 1)
                } else if score < Double(i) && score > Double(i - 1) {
                    Star(ratio: score - Double(i - 1))
                } else {
                    Star(ratio: 0)
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(score: 3.67)
            .frame(width: 100, height: 13)
    }
}
