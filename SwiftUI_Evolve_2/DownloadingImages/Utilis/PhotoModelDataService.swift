//
//  PhotoModelDataService.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/22/21.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    @Published var photoModels: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()

    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap (handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data: \(error)")
                }
            } receiveValue: {[weak self] (retunredPhotoModels) in
                self?.photoModels = retunredPhotoModels
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
