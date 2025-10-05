//
//  SettingsMenu.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/28/25.
//

import SwiftUI

struct SettingsMenu: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss
    @State private var showPopover: Bool = false
    @State var userRecord: UserRecord
    
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
                Toggle("Farenheit", isOn: $userRecord.isFarenhiet)
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
                    .popover(isPresented: $showPopover, attachmentAnchor: .point(.trailing)){
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
    @Previewable @State var userRecord = UserRecord()
    SettingsMenu(isPresented: $isPresented, userRecord: userRecord)
}
