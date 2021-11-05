//
//  LongPressGestureBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/5/21.
//

// SwiftUI Continued Learning #1:
// How to use the LongPressGesture (.onLongPressGesture)

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isCompleted: Bool = false
    @State var isSuccess: Bool = false

    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isCompleted ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)

            HStack {
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.black)
                    .cornerRadius(10.0)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
                        // start of press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isCompleted = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut){
                                        isCompleted = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at the min duration
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                
                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isCompleted = false
                        isSuccess = false
                    }
            }
        }
        
        
        
        
//        Text(isCompleted ? "COMPLETED" : "NOT COMPLETE")
//            .padding()
//            .padding(.horizontal)
//            .background(isCompleted ? Color.green : Color.gray)
//            .cornerRadius(10)
//            .onTapGesture {
//                isCompleted.toggle()
//            }
//            .onLongPressGesture(minimumDuration: 5.0, maximumDistance: 50) {
//                isCompleted.toggle()
//            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
