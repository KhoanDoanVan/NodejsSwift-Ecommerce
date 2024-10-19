//
//  FormField.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 18/10/24.
//

import SwiftUI

struct FormField: View {
    
    @Binding var value: String
    var icon: String
    var placeholder: String
    var isSecure: Bool = false
    var validateState: ValidateState
    
    var body: some View {
        let shadowColor: Color = {
            switch validateState {
            case .valid:
                return .green
            case .invalid:
                return .red
            case .empty:
                return .gray.opacity(0.4)
            }
        }()
        
        HStack {
            Image(systemName: icon)
                .foregroundColor(shadowColor)
                .padding(4)
            
            Group {
                if isSecure {
                    SecureField(placeholder, text: $value)
                } else {
                    TextField(placeholder, text: $value)
                }
            }
            .font(Font.system(size: 16, design: .monospaced))
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.leading)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8).stroke(shadowColor, lineWidth: 2)
                .shadow(radius: 1, x: 0, y: 2)
        )
    }
}

#Preview {
    VStack {
        FormField(value: .constant("hello@world.com"), icon: "envelope", placeholder: "Email", validateState: .invalid)
        
        FormField(value: .constant("password"), icon: "lock", placeholder: "Password", isSecure: true, validateState: .valid)
        
        FormField(value: .constant(""), icon: "person", placeholder: "Name", validateState: .empty)
    }
    .padding(.horizontal)
}
