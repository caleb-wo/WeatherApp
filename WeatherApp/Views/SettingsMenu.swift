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
    @State private var showPopover: Bool = false
    
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
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .padding(15)

                HStack{
                    Button(action:{
                        withAnimation(.easeInOut(duration: 0.3)){
                            showPopover.toggle()
                        }
                    }){
                        Text("New Zip Code")
                            .foregroundStyle(.white)
                            .font(.title2.bold())
                        Image(systemName: "map")
                            .foregroundStyle(.white)
                            .font(.title2.bold())
                    }
                    .popover(isPresented: $showPopover, attachmentAnchor: .point(.top)){
                        TextField("Enter Zip Code", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .padding(20)
                            .presentationCompactAdaptation(.popover)
                    }
                    Spacer()
                }
                .padding(15)
            }
            .background(.gray.opacity(0.5))
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    @Previewable @State var isFarenheit: Bool = true
    SettingsMenu(isPresented: $isPresented, isFarenheit: $isFarenheit)
}
