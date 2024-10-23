//
//  Register.swift
//  Ecommerce-Fullstack
//
//  Created by Đoàn Văn Khoan on 19/10/24.
//

import SwiftUI

struct Register: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthVM.self) var vm
    
    var body: some View {
        
        @Bindable var vmBindable = vm
        
        VStack {
            FormField(value: $vmBindable.nameRegister, icon: "person.circle", placeholder: "Name", validateState: vmBindable.nameValidStateRegister)
            
            FormField(value: $vmBindable.emailRegister, icon: "envelope.circle", placeholder: "Email", validateState: vmBindable.emailValidStateRegister)
            
            FormField(value: $vmBindable.passwordRegister, icon: "lock.circle", placeholder: "Password", isSecure: true, validateState: vmBindable.passwordValidStateRegister)
            
            Button {
                Task {
                    try await vmBindable.register(
                        name: vm.nameRegister,
                        email: vm.emailRegister,
                        password: vm.passwordRegister
                    )
                }
            } label: {
                Text("Register")
                    .buttonTextModifier()
            }
            .disabled(vmBindable.isValidRegister ? false : true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Register")
        .backButtonModifier(dismiss: dismiss)
        .padding(.horizontal, 32)
        .alert(vm.alertTitle, isPresented: $vmBindable.showAlert) {
            Button("OK", role: .cancel) {
                
            }
        } message: {
            Text(vmBindable.alertMessage)
        }
        
        Spacer()
        
        NavigationLink(destination: ForgotPassword()) {
            Navlink(text: "Forgot", subText: "Password?")
        }
    }
}

#Preview {
    Register()
}
