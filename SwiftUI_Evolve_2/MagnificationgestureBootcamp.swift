//
//  MagnificationgestureBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/5/21.
//

// SwiftUI Continued Learning #2:
// How to use MagnificationGesture (to zoom in & zoom out)

import SwiftUI

struct MagnificationgestureBootcamp: View {
    
    @State var currentValue: CGFloat = 0
    @State var lastValue: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 10) {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentValue)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentValue = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentValue = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .font(.headline)
            .padding(.horizontal)
            Text("This is the caption for my photo!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
        
        
//        Text("Hello, World!")
//            .font(.title)
//            .foregroundColor(Color.white)
//            .padding(40)
//            .background(Color.red.cornerRadius(20))
//            .scaleEffect(1 + currentValue + lastValue)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        currentValue = value - 1
//                    }
//                    .onEnded { value in
//                        lastValue += currentValue
//                        currentValue = 0
//                    }
//            )
    }
}

struct MagnificationgestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationgestureBootcamp()
    }
}
