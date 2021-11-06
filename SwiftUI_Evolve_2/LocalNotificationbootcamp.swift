//
//  LocalNotificationbootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/6/21.
//

import SwiftUI
import UserNotifications
import CoreLocation

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
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "It is soooo easy"
        content.sound = .default
        content.badge = 1
        
//    time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
//    calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 18
//        dateComponents.minute = 44
//        dateComponents.weekday = 7
//        Every Saturday at 18:44 the notification will triggers repeatedly
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
//    location
        let locationCoordinate = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00
        )
        let region = CLCircularRegion(
            center: locationCoordinate,
            radius: 100,
            identifier: UUID().uuidString
        )
        region.notifyOnEntry = true
        region.notifyOnExit = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationbootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationsManager.instance.requestAuthorization()
            }
            Button("Schedule notification") {
                NotificationsManager.instance.scheduleNotification()
            }
            Button("Cancel notification") {
                NotificationsManager.instance.cancelNotifications()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationbootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationbootcamp()
    }
}
