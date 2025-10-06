//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/26/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @State var userRecord: UserRecord
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
                         userRecord: userRecord)
                .presentationDetents([.medium, .large],
                                     selection: .constant(.large))
                .background(.gray)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: UserRecord.self, configurations: config)
    let sampleRecord = UserRecord()
    SettingsView(userRecord: sampleRecord)
        .modelContainer(container)
}
