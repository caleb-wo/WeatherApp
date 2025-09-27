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
        if !isPresented{
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
                }
            }
        } else {
            VStack{
                Button(action:{
                    withAnimation(.easeInOut(duration: 0.3)){
                        isPresented.toggle()
                    }
                }){
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .padding(15)
                    }
                }
                Toggle("Farenheit", isOn: $isFarenheit)
                    .padding([.bottom,
                              .leading,
                              .trailing], 15)
            }
            .frame(maxWidth: 180)
            .background(.white,
                        in: RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    SettingsView()
}
