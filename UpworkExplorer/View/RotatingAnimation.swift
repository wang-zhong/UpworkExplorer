//
//  RotatingAnimation.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import SwiftUI

struct RotatingAnimation: View {
    @State private var isRotating = 0.0
    
    var body: some View {
        Image("spinner")
            .resizable()
            .frame(width: 20, height: 20)
            .rotationEffect(.degrees(isRotating))
            .onAppear {
                withAnimation(.linear(duration: 1)
                    .repeatForever(autoreverses: false)) {
                        isRotating = 360.0
                    }
            }
    }
}

struct RotatingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RotatingAnimation().frame(width: 500, height: 500)
    }
}
