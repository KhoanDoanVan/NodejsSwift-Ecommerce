//
//  Navlink.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 18/10/24.
//

import SwiftUI

struct Navlink: View {
    
    var text: String
    var subText: String
    
    
    var body: some View {
        HStack {
            Text(text)
            
            Text(subText)
                .font(.system(size: 18, weight: .semibold))
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    VStack {
        Navlink(text: "Forgot", subText: "Password")
        Navlink(text: "Reset", subText: "Password")
    }
}
