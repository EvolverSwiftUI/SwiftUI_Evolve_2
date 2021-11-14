//
//  WeakSelfbootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/13/21.
//

import SwiftUI

struct WeakSelfbootcamp: View {
    
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink( "Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .bold()
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            , alignment: .topTrailing
                
        )

    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
        
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String?
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        
        // Here we can make reference cycle being killed
        // by using weak and unowned keywords
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!"
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [unowned self] in
//            self.data = "NEW DATA!!!"
//        }

    }
    
}

struct WeakSelfbootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfbootcamp()
    }
}
