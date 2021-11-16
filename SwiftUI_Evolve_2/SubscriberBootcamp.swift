//
//  SubscriberBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/16/21.
//

import SwiftUI
import Combine

class SubscriberBootcampViewModel: ObservableObject {
    
    @Published var count: Int = 0
//    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var isValidText: Bool = false
    @Published var showButton: Bool = false

    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            //.assign(to: \.isValidText, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.isValidText = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common) // It act as Publisher
            .autoconnect()
            .sink { [weak self] _ in // It act as Subscriber
                guard let self = self else { return }
                self.count += 1
                
//                if self.count >= 10 {
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }

    func addButtonSubscriber() {
        $isValidText
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
            
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberBootcampViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            //Text(vm.isValidText.description)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.isValidText ? 0.0 : 1.0
                            )
                            .foregroundColor(.red)
                            
                        Image(systemName: "checkmark")
                            .opacity(vm.isValidText ? 1.0 : 0.0)
                            .foregroundColor(.green)
                            
                    }
                    .padding(.trailing)
                    .font(.title)
                    , alignment: .trailing
                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.gray, lineWidth: 0.1)
//                )
            
            Button(action: {
                print("BUTTON TAPPED.")
            }, label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
