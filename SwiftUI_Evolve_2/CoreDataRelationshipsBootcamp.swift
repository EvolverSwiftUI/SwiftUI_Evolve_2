//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/8/21.
//

// Continued Learning #16
// Core Data
//  1. Relationships,
//  2. Predicates, and
//  3. Delete Rules in Xcode.

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity
// DepartmentEntity
// EmployeeEntity

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let container   : NSPersistentContainer
    let context     : NSManagedObjectContext
    let model       : NSManagedObjectModel
    let coordinator : NSPersistentStoreCoordinator
    
    init() {
        
        container = NSPersistentContainer(name: "CoreDataContainer")
        
        // creates database with name and
        // empty tables of entities and
        // their relationships
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR WHILE LOADING CORE DATA CONTAINER: ", error.localizedDescription)
            } else {
                print("SUCCESS IN LOADING CORE DATA.")
            }
        }
        
        // and also container creates underhood a core data stack
        // for us like model, context and coordinator
        context     = container.viewContext
        model       = container.managedObjectModel
        coordinator = container.persistentStoreCoordinator
        
    }
    
    func save() {
        
        guard context.hasChanges else {
            return
        }
        
        do{
            try context.save()
            print("Saved successfully!")
        } catch let error {
            print("ERROR IN SAVING CORE DATA: ", error.localizedDescription)
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var businesses   : [BusinessEntity]      = []
    @Published var departments  : [DepartmentEntity]    = []
    @Published var employees    : [EmployeeEntity]      = []

    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("ERROR businesses DATA  FETCHING: ", error.localizedDescription)
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("ERROR departments DATA FETCHING: ", error.localizedDescription)
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("ERROR departments DATA FETCHING: ", error.localizedDescription)
        }
    }

    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("ERROR departments DATA FETCHING: ", error.localizedDescription)
        }
    }

    
    func updateBusiness() {
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[1])
        save()
    }

    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to new business
        //newBusiness.departments = [departments[0], departments[1]]
        
        // add existing employees to new business
        //newBusiness.employees = [employees[1]]

        // add new business to existing department
        //newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing employee
        //newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        newDepartment.addToEmployees(employees[1])
        
        //newDepartment.employees = [employees[1]]
        //newDepartment.addToEmployees(employees[1])
        
        save()
    }
    
    func addEmployee() {
        let newEmployee         = EmployeeEntity(context: manager.context)
        newEmployee.name        = "Jhon"
        newEmployee.age         = 21
        newEmployee.dateJoined  = Date()
        newEmployee.business    = businesses[2]
        newEmployee.department  = departments[1]
        save()
    }

    //Core Data Delete Rules:
    /*
     1. No Action   :
        When source is deleted, but destination won't be notified.
     
     2. Nullify     : [It is default one by core data]
        When source is deleted, but the relationship is nullified, won't effect on destination.
     
     3. Cascade     : [Not safe]
        When source is deleted, and it also sent to delte the destination as well by cacasding info to destination.
     
     4. Deny        : [Kind of Safe Check]
        When source is deleted, the destinations won't get any effect.
        And The source will be deleted untill and unless its associated all destinations will deleted.
        So it will deny if associated detination still exist.
     
     */
    func deleteDepartment() {
        let department = departments[1]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Button(action: {
                        vm.deleteDepartment()
                    }, label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })

                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }

                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelationshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp()
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        })
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
           if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
            Text("Businesses:")
                .bold()
              ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
              ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        })
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Age: \(entity.age)")
            Text("Date Joined: \(entity.dateJoined ?? Date())")
            
            Text("Business:")
                .bold()
            Text(entity.business?.name ?? "")
            
            Text("Department:")
                .bold()
            Text(entity.department?.name ?? "")
        })
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
