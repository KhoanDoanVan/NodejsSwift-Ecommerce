//
//  Ecommerce_FullstackApp.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 18/10/24.
//

import SwiftUI

@main
struct Ecommerce_FullstackApp: App {
    
    @State var vm = AuthVM()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if true {
                    Login()
                } else {
                    MainTabView()
                }
            }
            .environment(vm)
        }
    }
}
