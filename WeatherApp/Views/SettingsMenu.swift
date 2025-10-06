//
//  SettingsMenu.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/28/25.
//

import SwiftUI
import SwiftData

struct SettingsMenu: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State var userRecord: UserRecord
    @State var newZipCode: String = ""
    @State var newZipCodeName: String = ""
    @State private var noZipcodeShield = false

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
                
                TextField("Enter Zipcode Name", text: $newZipCodeName)
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading, .trailing] ,20)
                TextField("Enter Zipcode", text: $newZipCode)
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading, .trailing] ,20)
                Button("Add Zipcode"){
                    let newZipCodeSave = ZipCode(name: newZipCodeName,
                                                 code: newZipCode)
                    
                    newZipCode = ""
                    newZipCodeName = ""
                    
                    userRecord.zipCodes.append(newZipCodeSave)
                    
                    try? context.save()
                }
                .frame(width: 200)
                .padding([.trailing, .leading], 20)
                .font(.title2)
                .bold()
                .background(.white,
                            in: RoundedRectangle(cornerRadius: 20))
                
                Text("Your Zipcodes")
                    .padding(.top, 50)
                    .padding(.bottom, -30)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Form {
                    Picker("Current Zip Code",
                           selection: $userRecord.selectedZipCodeIdx) {
                        ForEach(userRecord.zipCodes.indices, id: \.self) { idx in
                            let zipCode = userRecord.zipCodes[idx]
                            Text("\(zipCode.name): \(zipCode.code)").tag(idx)
                        }
                    }
                           .pickerStyle(.menu)
                }
                .scrollContentBackground(.hidden)
                
                List{
                    ForEach(userRecord.zipCodes, id: \.id){ zipcode in
                        Text("\(zipcode.name): \(zipcode.code)")
                    }
                    .onDelete{ offsets in
                        if userRecord.zipCodes.count > 1{
                            for index in offsets {
                                let zipCodeToDelete = userRecord.zipCodes[index]
                                
                                context.delete(zipCodeToDelete)
                            }
                            
                            try? context.save()
                        } else { noZipcodeShield = true}
                    }
                }
                .toolbar{
                    EditButton()
                }
                .alert("Must have one zipcode.", isPresented: $noZipcodeShield){
                    Button("Okay", role: .cancel){}
                }
                .padding(.top, -160)
                .scrollContentBackground(.hidden)
            }
            .background(.gray.opacity(0.5))
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: UserRecord.self, configurations: config)
    let sampleRecord = UserRecord()
    
    SettingsMenu(isPresented: $isPresented, userRecord: sampleRecord)
        .modelContainer(container)
}
