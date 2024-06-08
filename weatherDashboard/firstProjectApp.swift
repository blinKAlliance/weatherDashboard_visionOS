//
//  firstProjectApp.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//

import SwiftUI

@main
struct firstProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
