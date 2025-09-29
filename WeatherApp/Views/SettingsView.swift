//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/26/25.
//

import SwiftUI

struct SettingsView: View {
    @State var isFarenheit: Bool = true
    @State var isPresented: Bool = false
    
    var body: some View {
        HStack{
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)){
                    isPresented.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                    .glassEffect(in: .buttonBorder)
            }
        }
        .sheet(isPresented: $isPresented) {
            SettingsMenu(isPresented: $isPresented,
                         isFarenheit: $isFarenheit)
                .presentationDetents([.medium, .large],
                                     selection: .constant(.medium))
        }
    }
}

#Preview {
    SettingsView()
}
