//
//  CodableBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/15/21.
//

import SwiftUI

// Codable = Decodable + Encodable

//struct CustomerModel: Identifiable, Decodable, Encodable {
    
struct CustomerModel: Identifiable, Codable {

    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    // When we confirm to Codable protocol
    // It will do us all the below logic behind the scenes
    // So no need to write manually by us, it will do for us.
    
//    enum CodingKeys: String, CodingKey {
//
//        case id
//        case name
//        case points
//        case isPremium
//    }
    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//
//        self.id         = id
//        self.name       = name
//        self.points     = points
//        self.isPremium  = isPremium
//    }
    
//    init(from decoder: Decoder) throws {
//
//        let container   = try decoder.container(keyedBy: CodingKeys.self)
//        self.id         = try container.decode(String.self, forKey: .id)
//        self.name       = try container.decode(String.self, forKey: .name)
//        self.points     = try container.decode(Int.self, forKey: .points)
//        self.isPremium  = try container.decode(Bool.self, forKey: .isPremium)
//    }
    
//    func encode(to encoder: Encoder) throws {
//
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
    
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel?
    // = CustomerModel(id: "1", name: "Nick", points: 5, isPremium: true)
    
    init() {
        getData()
    }
    
    func getData() {
        
//        guard let data = getJSONData() else { return }
//        print("JSON DATA:")
//        print(data)
//        let jsonString = String(data: data, encoding: .utf8)
//        print(jsonString)
        
        guard let data = getJSONData() else { return }
        
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String: Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool  {
//
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
        
        // The above way, we don't required to decode manually,
        // Instead of this our DECODABLE protocol will do for us automatically.
//        do {
//            let newCustomer = try JSONDecoder().decode(CustomerModel.self, from: data)
//            customer = newCustomer
//        } catch let error {
//            print("Error decoding: \(error.localizedDescription)")
//        }
        
        // the above code make even a single line as below way
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)

    }
    
    func getJSONData() -> Data? {
        
//        let dictionary: [String: Any] = [
//            "id": "12345",
//            "name": "Joe",
//            "points": 5,
//            "isPremium": true,
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
//        return jsonData
        
        // Now no need above to convert to jsonData manually
        // the below code will do automatically using Encoder protocol
        let customer = CustomerModel(id: "111", name: "Emily", points: 100, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
                
        return jsonData
    }
    
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
