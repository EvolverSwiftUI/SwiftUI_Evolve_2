//
//  HashableBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/6/21.
//

// SwiftUI Continued Learning #12:
// How to use the Hashable protocol

import SwiftUI

// with Hashable protocol confirmation
// It can be used
// if you don't want to put id as explicitly to outside access
struct MyCustomModel: Hashable {
    let title: String
    let subTitle: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subTitle)
    }
}

// with Identifiable protocol confirmation
//struct MyCustomModel: Identifiable {
//    let id = UUID().uuidString
//    let title: String
//}


struct HashableBootcamp: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE", subTitle: "1"),
        MyCustomModel(title: "TWO", subTitle: "2"),
        MyCustomModel(title: "THREE", subTitle: "3"),
        MyCustomModel(title: "FOUR", subTitle: "4"),
        MyCustomModel(title: "FIVE", subTitle: "5")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                    Text(item.subTitle)
                        .font(.headline)
                    Text(item.hashValue.description)
                        .font(.headline)
                    Divider()
                }
            }
        }
    }

// with Identifiable protocol confirmation
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 40) {
//                ForEach(data) { item in
//                    Text(item.title)
//                        .font(.headline)
//                    Text(item.id)
//                        .font(.headline)
//                }
//            }
//        }
//    }
}


// Hashable with simple example
//struct HashableBootcamp: View {
//    let data: [String] = [
//        "ONE", "TWO", "THREE", "FOUR", "FIVE"
//    ]
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 40) {
//                ForEach(data, id: \.self, content: { item in
//                    Text(item)
//                        .font(.headline)
//                    Text(item.hashValue.description)
//                        .font(.headline)
//                })
//            }
//        }
//    }
//}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
