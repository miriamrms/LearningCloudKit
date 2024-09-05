//
//  TentListView.swift
//  LearningCloudKit2
//
//  Created by Miriam Mendes on 04/09/24.
//

import SwiftUI
var currentTentName: String = "Escolha uma Barraca"
struct TentListView: View {
    @StateObject var model = CKModel()
    @Binding var showTentList: Bool
    var body: some View {
        List{
            ForEach(model.tents, id: \.id) { tent in
                Button {
        
                    withAnimation {
                        currentTentName = tent.name
                        showTentList = false
                    }
                } label: {
                    Text(tent.name)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
        .task {
            do{
                try await model.populateTents()
            }
            catch{
                print(error)
            }
        }
    }
}

#Preview {
    TentListView(showTentList: .constant(true))
}


