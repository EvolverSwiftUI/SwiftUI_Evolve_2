//
//  EscapingBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/15/21.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
//        let newData = downloadData()
        
//        downloadData2 { (retunedData) in
//            let newData = retunedData
//            text = newData
//        }
        
//        downloadData3 { [weak self] (retunedData) in
//            let newData = retunedData
//            self?.text = newData
//        }
        
//        downloadData3 { [unowned self] (retunedData) in
//            let newData = retunedData
//            self.text = newData
//        }
        
        
//        downloadData4 { [weak self] (retunedResult) in
//            let newData = retunedResult.data
//            self?.text = newData
//        }

        downloadData5 { [weak self] (retunedResult) in
            let newData = retunedResult.data
            self?.text = newData
        }

        // in the above function the code snippet whatever pasted below
        // is closure declaration and closure body (nothingbut function with params and body but without name)
        // so whenever we call this closure the below code will executes.
        
//        { [weak self] (retunedData) in
//            let newData = retunedData
//            self?.text = newData
//        }
        
        // NOTE:
        // Closures will capture their params from its surrounding environments.
        // So be notify this point for MYSELF.
        
    }
    
    // Here it immediately return in synronoization execution way
    // Meaning it won't be delay to return response
    func downloadData() -> String {
        return "New Data!!!"
    }
    
    // closure basic usage explained here
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("New Data!!!") // closure calling here [nothingbut function calling]
    }

    
//    func downloadData2() -> String {
        
        // NOTE: Due to not immediate return of data or delay in return of data
        // meaning not synchronus execution way
        // meaning it is asynchronus way of execution
        // so here immediate return not possible
        // so here it will  need to stay in memory untill sometime to get data from server
        // so a reference type closure wiil be used here instead of direct return
        // so that's why getting following error
        // 1st error: Cannot convert return expression of type '()' to return type 'String'
        // 2nd error: Cannot convert value of type 'String' to closure result type 'Void'
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            return "New Data!!!"
//        }
        
        // to fix that errors and to execute in asynchrounus way use the concept of closures
        // So basically here we add a clsoure as a parameter to function instead of returning something
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            return "New Data!!!"
//        }
//    }
    
    // Here immediate return is not possible,
    // Bcz it will take few seconds to go to Server
    // and get data back to our app
    // so for that it must be return in different way rather than normal return
    // so in that scenario created the concept of closures and asynchronus way
    // so below function for return we are using asynchronus way
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New Data!!!") // closure calling here [nothingbut function calling]
        }
    }

    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data!!!")
            completionHandler(result)
        }
    }
        
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data!!!")
            completionHandler(result)
        }
    }

}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> Void

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
