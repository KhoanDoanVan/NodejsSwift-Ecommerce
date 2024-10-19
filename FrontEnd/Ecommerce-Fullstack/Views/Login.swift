//
//  Login.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 18/10/24.
//

import SwiftUI

struct Login: View {
    
    @Environment(AuthVM.self) var vm
    
    var body: some View {
        
        @Bindable var vmBindable = vm
        
        NavigationStack {
            VStack(spacing: 8) {
                FormField(value: $vmBindable.emailLogin, icon: "envelope.circle", placeholder: "Email", validateState: vmBindable.emailValidStateLogin)
                
                FormField(value: $vmBindable.passwordLogin, icon: "lock.circle", placeholder: "Password", isSecure: true, validateState: vmBindable.passwordValidStateLogin)
                
                Button {
                    
                } label: {
                    Text("Login")
                        .buttonTextModifier()
                }
                .disabled(vmBindable.isValidLogin ? false : true)
                
                Spacer()
                
                NavigationLink(destination: ForgotPassword()) {
                    Navlink(text: "Forgot", subText: "Password?")
                }
                
            }
            .padding(.horizontal, 32)
            .navigationTitle("Login")
            .navigationBarBackButtonHidden(true)
            
            NavigationLink(destination: Register()) {
                Navlink(text: "New?", subText: "Create Account")
            }
        }
    }
}

#Preview {
    Login()
}
