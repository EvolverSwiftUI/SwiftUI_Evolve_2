//
//  HapticsBootcamp.swift
//  SwiftUI_Evolve_2
//
//  Created by Sivaram Yadav on 11/6/21.
//

import SwiftUI

class HapticsManager {
    
    static let instance = HapticsManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Button("success".uppercased()) { HapticsManager.instance.notification(type: .success)}
            Button("warning".uppercased()) { HapticsManager.instance.notification(type: .warning)}
            Button("error".uppercased()) { HapticsManager.instance.notification(type: .error)}
            Divider()
            Divider()
            Button("soft".uppercased()) { HapticsManager.instance.impact(style: .soft)}
            Button("light".uppercased()) { HapticsManager.instance.impact(style: .light)}
            Button("medium".uppercased()) { HapticsManager.instance.impact(style: .medium)}
            Button("rigid".uppercased()) { HapticsManager.instance.impact(style: .rigid)}
            Button("heavy".uppercased()) { HapticsManager.instance.impact(style: .heavy)}
        }
    }
}

struct HapticsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsBootcamp()
    }
}
