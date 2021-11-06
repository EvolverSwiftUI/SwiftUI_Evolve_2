//
//  ArraysBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/6/21.
//

// SwiftUI Continued Learning #13:
// How to sort, filter, and map data arrays

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArraysModificationViewModel: ObservableObject {
    
    @Published var dataArray    : [UserModel]   = []
    @Published var filteredArray: [UserModel]   = []
    @Published var mappedArray  : [String]      = []

    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        // sort
        /*
//        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
//            return user1.points < user2.points // ascending order
//            return user1.points > user2.points // descending order
//        }
//        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
        
        */
        
        // filter
        /*
//        filteredArray = dataArray.filter({ (user) -> Bool in
//            return user.isVerified
//            return !user.isVerified
//            return user.points > 50
//            return user.name.contains("i")
//        })
//        filteredArray = dataArray.filter { $0.isVerified }
         */
  
        // map
        /*
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name ?? "ERROR"
//        })
        
//        mappedArray = dataArray.map { $0.name ?? "ERROR"}
        
//        mappedArray = dataArray.compactMap({ (user) -> String? in
//            return user.name
//        })
//        mappedArray = dataArray.compactMap { $0.name }
        */
    
        // All Combine
        /*
//        let sort    = dataArray.sorted(by: { $0.points > $1.points })
//        let filterd = dataArray.filter() { $0.isVerified }
//        let mapped  = dataArray.compactMap({ $0.name })
        
//      Now combine all options together
//      To get real results using
//      Just simple & hightech options
         */

        mappedArray = dataArray
                        .sorted(by: { $0.points > $1.points })
                        .filter() { $0.isVerified }
                        .compactMap({ $0.name })
    }
    
    func getUsers() {
        let user1   = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2   = UserModel(name: nil, points: 0, isVerified: false)
        let user3   = UserModel(name: "Joe", points: 20, isVerified: true)
        let user4   = UserModel(name: "Emily", points: 50, isVerified: false)
        let user5   = UserModel(name: "Samantha", points: 45, isVerified: true)
        let user6   = UserModel(name: nil, points: 23, isVerified: false)
        let user7   = UserModel(name: "Sarah", points: 76, isVerified: true)
        let user8   = UserModel(name: "Lisa", points: 45, isVerified: false)
        let user9   = UserModel(name: "Steve", points: 1, isVerified: true)
        let user10  = UserModel(name: nil, points: 100, isVerified: false)
        
//        dataArray.append(user1 )
//        dataArray.append(user2 )
//        dataArray.append(user3 )
//        dataArray.append(user4 )
//        dataArray.append(user5 )
//        dataArray.append(user6 )
//        dataArray.append(user7 )
//        dataArray.append(user8 )
//        dataArray.append(user9 )
//        dataArray.append(user10)
        
        dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
    }
}

struct ArraysBootcamp: View {
    @StateObject var vm = ArraysModificationViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.blue.cornerRadius(10))
                        .padding(.horizontal)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(Color.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
