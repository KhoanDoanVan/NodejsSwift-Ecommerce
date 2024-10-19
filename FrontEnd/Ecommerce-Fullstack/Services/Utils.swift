//
//  Utils.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 18/10/24.
//

import Foundation
import SwiftUI

enum ValidateState {
    case valid
    case invalid
    case empty
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = email.range(of: emailRegex, options: .regularExpression) != nil
    return emailTest
}

struct ButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .foregroundStyle(.white)
            .font(.system(size: 20, weight: .heavy))
            .background(Color.black)
            .cornerRadius(10)
    }
}

extension View {
    public func buttonTextModifier() -> some View {
        self.modifier(ButtonTextModifier())
    }
    
    func backButtonModifier(dismiss: DismissAction) -> some View {
        self.modifier(BackButtonModifier(dismiss: dismiss))
    }
}

struct BackButtonModifier: ViewModifier {
    
    var dismiss: DismissAction
    
    func body(content: Content) -> some View {
        content
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .tint(.black)
                    }
                }
            })
    }
}
