//
//  CoreDataBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/8/21.
//

// SwiftUI Continued Learning #15
// How to use Core Data with MVVM Architecture in SwiftUI

import SwiftUI
import CoreData

// View - UI
// Model - data points
// ViewModel - manages the data for a view


class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedFruits: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (decription, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA: \(error.localizedDescription)")
            } else {
                print("Successfully loaded core data!")
            }
        }
        fetchFruits()
    }
    
    // FETCH
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedFruits = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetch: \(error.localizedDescription)")
        }
    }
    
    // SAVE
    func addFruit(text: String) {
        let fruit = FruitEntity(context: container.viewContext)
        fruit.name = text
        saveData()
    }
    
    // DELETE
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        let fruit = savedFruits[index]
        container.viewContext.delete(fruit)
        saveData()
    }
    
    // UPDATE
    func updateFruit(_ fruit: FruitEntity) {
        let currentName = fruit.name ?? ""
        let newName = currentName + "!"
        fruit.name = newName
        saveData()
    }
    
    // COMMON FOR ALL OPERATIONS
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error save: \(error.localizedDescription)")
        }
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Fruit name here... ", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding()
                
                Button(action: {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                }, label: {
                    Text("Submit")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                        .cornerRadius(10)
                })
                .padding(.horizontal)

                List {
                    ForEach(vm.savedFruits) { fruit in
                        Text(fruit.name ?? "NO NAME")
                            .onTapGesture {
                                vm.updateFruit(fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
