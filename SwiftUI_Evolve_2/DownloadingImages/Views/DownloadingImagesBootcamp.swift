//
//  DownloadingImagesBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/22/21.
//

import SwiftUI

// Concepts used in this bootcamp

// 1. codable
// 2. background thread
// 3. weak self
// 4. combine
// 5. publishers and subscribers
// 6. file manager
// 7. nscache

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images!")
        }
    }
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
