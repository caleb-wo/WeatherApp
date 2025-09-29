//
//  SettingsMenu.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/28/25.
//

import SwiftUI

struct SettingsMenu: View {
    @Binding var isPresented: Bool
    @Binding var isFarenheit: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Button(action:{
                withAnimation(.easeInOut(duration: 0.3)){
                    isPresented.toggle()
                    dismiss()
                }
            }){
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .padding(15)
                }
            }
            VStack{
                Toggle("Farenheit", isOn: $isFarenheit)
                    .padding(15)
            }
            Spacer()
        }
        .background(.clear)
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    @Previewable @State var isFarenheit: Bool = true
    SettingsMenu(isPresented: $isPresented, isFarenheit: $isFarenheit)
}
