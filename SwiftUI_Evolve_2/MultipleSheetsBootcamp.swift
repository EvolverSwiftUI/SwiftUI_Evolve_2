//
//  MultipleSheetsBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/6/21.
//

// SwiftUI Continued Learning #7:
// How to present multiple sheets from a single View

import SwiftUI

/*
 
 3 ways present multiple sheets
 
 1 - use a binding
 2 - use multiple .sheet
 3 - use $item
 
 */

struct RandomModel: Identifiable {
    
    enum Choice {
        case success
        case failure
        case error
        case valid
    }
//    let id: Choice
    let id = UUID().uuidString
    let title: String
}

struct MultipleSheetsBootcamp: View {
    
    @State var randomModel: RandomModel?
//    @State var randomModel: RandomModel
//    @State var showSheet1: Bool = false
//    @State var showSheet2: Bool = false
//    @State var showSheet: Bool = false

    
    var body: some View {
        
// 1
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                randomModel = RandomModel(title: "ONE")
//                showSheet.toggle()
//            }
//            Button("Button 2") {
//                randomModel = RandomModel(title: "TWO")
//                showSheet.toggle()
//            }
//        }
//        .sheet(isPresented: $showSheet, content: {
//            NextView(model: $randomModel)
//        })
        
// 2
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                showSheet1.toggle()
//            }
//            .sheet(isPresented: $showSheet1, content: {
//                NextView(model: RandomModel(title: "ONE"))
//            })
//
//            Button("Button 2") {
//                showSheet2.toggle()
//            }
//            .sheet(isPresented: $showSheet2, content: {
//                NextView(model: RandomModel(title: "TWO"))
//            })
//        }

// 3
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        randomModel = RandomModel(title: "\(index)")
                    }
                }
            }
        }
        .sheet(item: $randomModel) { model in
            NextView(model: model)
        }
    }
}

struct NextView: View {
    
    let model: RandomModel
//    @Binding var model: RandomModel?
    
    var body: some View {
//        Text(model?.title ?? "")
        Text(model.title)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
