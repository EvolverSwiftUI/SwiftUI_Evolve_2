//
//  ImageLoadingViewModel.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/22/21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
   
    var cancellables = Set<AnyCancellable>()
    //let manager = PhotoModelCacheManager.instance
    let manager = PhotoModelFileManager.instance

    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) { //getting from cache
            image = savedImage
            print("Getting saved image!")
        } else {
            downloadImage()
            print("Downloading image now!")
        }
    }
    
    func downloadImage() {
        
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { (_) in
                
            } receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let image = returnedImage else { return }
                
                self.image = image
                self.manager.add(key: self.imageKey, value: image) // adding to cache
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
}
