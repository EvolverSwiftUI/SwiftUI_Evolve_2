//
//  DownloadingImagesViewModel.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/22/21.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    let dataService = PhotoModelDataService.instance
    var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] (retunredPhotoModels) in
                self?.dataArray = retunredPhotoModels
            }
            .store(in: &cancellables)
    }
}
