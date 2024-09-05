//
//  AddProductView.swift
//  LearningCloudKit2
//
//  Created by Miriam Mendes on 04/09/24.
//

import SwiftUI

struct AddProductView: View {
    @StateObject var model = CKModel()
    @State var showTentList: Bool = false
    private var barraca: Tents {
            model.tents.first! // Default value if empty
        }

    var body: some View {
        VStack(spacing: 0){
            VStack{
                Button {
                    showTentList.toggle()
                } label: {
                    Text(currentTentName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: currentTentName)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: showTentList ? 180 : 0))
                        }
                }

                if showTentList{
                    TentListView(showTentList: $showTentList)
                }
            }
            .background(.thickMaterial)
            .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 15)
        }.padding()
        Spacer()
    }
}

#Preview {
    AddProductView()
}


