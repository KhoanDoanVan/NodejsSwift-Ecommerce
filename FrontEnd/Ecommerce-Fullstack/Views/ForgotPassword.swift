//
//  ForgotPassword.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 18/10/24.
//

import SwiftUI

struct ForgotPassword: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthVM.self) var vm
                  
    var body: some View {
        
        @Bindable var vmBindable = vm
        
        VStack(spacing: 24) {
            FormField(value: $vmBindable.emailForget, icon: "envelope.circle", placeholder: "Email", validateState: vmBindable.emailValidStateForget)
            
            Button {
                
            } label: {
                Text("Reset")
                    .buttonTextModifier()
            }
            .disabled(vmBindable.isValidForget ? false : true)
            Spacer()
        }
        .padding(.horizontal, 32)
        .navigationBarBackButtonHidden(true)
        .backButtonModifier(dismiss: dismiss)
        .navigationTitle("Forgot Password")
    }
}

#Preview {
    ForgotPassword()
}
