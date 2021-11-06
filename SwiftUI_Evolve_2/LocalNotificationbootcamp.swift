//
//  LocalNotificationbootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/6/21.
//

import SwiftUI
import UserNotifications

class NotificationsManager {
    
    static let instance = NotificationsManager() // Singleton
    
    func requestAuthorization() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { (success, error) in
            if let error = error {
                print("ERROR: ", error.localizedDescription)
            } else {
                print("SUCCESS")
            }
        }
    }
}

struct LocalNotificationbootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationsManager.instance.requestAuthorization()
            }
        }
    }
}

struct LocalNotificationbootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationbootcamp()
    }
}
