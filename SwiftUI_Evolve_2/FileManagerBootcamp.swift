//
//  FileManagerBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/16/21.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path
        else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path
        else {
            return
        }

        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder: \(error.localizedDescription)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
//        image.jpegData(compressionQuality: 0.5) // For jpeg image
        guard
            let data = image.pngData() // For png image
        else {
            return "Error in getting data."
        }
        
        //let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        //let directory3 = FileManager.default.temporaryDirectory
        
//        print(directory)
//        print(directory2)
//        print(directory3)
        
        //let path = directory?.appendingPathComponent("\(name).png")
        
        //print(directory)
        //print(path)

        //data.write(to: <#T##URL#>)
        guard let path = getPathForImage(name: name) else {
            return "Error in saving image!"
        }
        
        do {
            try data.write(to: path)
            print(path)
            return "Success saving!"
        } catch let error {
            return "Error in saving image: \(error.localizedDescription)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            print("Error in getting path.")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            return "Error in getting path."
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print(path)
            return "Deleted Successfully."
        } catch let error {
            return "Error in deleting image: \(error.localizedDescription)"
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).png")
        else {
            print("Error in getting path.")
            return nil
        }
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "Color-SS"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""

    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        
        guard let image = image else {
            return
        }
        infoMessage = manager.saveImage(image: image, name: imageName)
//        if infoMessage.contains("Error") {
//            manager.createFolderIfNeeded()
//            saveImage()
//        }
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button(action: {
                        vm.saveImage()
                    }, label: {
                        Text("Save to FM")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Spacer()
                    Button(action: {
                        vm.deleteImage()
                    }, label: {
                        Text("Delete from FM")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .padding()
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
