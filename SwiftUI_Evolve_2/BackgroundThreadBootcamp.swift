//
//  BackgroundThreadBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/13/21.
//

// Multi-threading with background threads and queues in Xcode
// Continued Learning #17

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("CHECK 1:", Thread.isMainThread)
            print("CHECK 1:", Thread.current)

            DispatchQueue.main.async {
                self.dataArray = newData
                
                print("CHECK 2:", Thread.isMainThread)
                print("CHECK 2:", Thread.current)
            }
        }
    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        for x in 1..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id:\.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(Color.red)
                }
            }
        }
    }
}

struct MultiThreadingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
