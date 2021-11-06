//
//  GeometryReaderBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/5/21.
//

// SwiftUI Continued Learning #6:
// How to use the GeometryReader and GeometryProxy

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - currentX / maxDistance)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.white)
                            .shadow(radius: 10)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        
        
        
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.666)
//                Rectangle()
//                    .fill(Color.blue)
//            }
//            .edgesIgnoringSafeArea(.all)
//        }
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
