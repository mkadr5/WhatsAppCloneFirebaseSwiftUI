//
//  WhatsAppCloneSwiftUIApp.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Muhammet Kadir on 2.04.2023.
//

import SwiftUI
import FirebaseCore

@main
struct WhatsAppCloneSwiftUIApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
