//
//  TestView.swift
//  LearningCloudKit2
//
//  Created by Miriam Mendes on 04/09/24.
//

import SwiftUI

struct TestView: View {
    @StateObject var model = CKModel()
    var body: some View {
        
        VStack{
            NavigationStack{
                List(model.tents, id: \.id){ tent in
                    NavigationLink(destination: TentDetailsView(tent: tent)) {
                        Text(tent.name)
                    }
                }
            }
            .navigationTitle("Barracas")
        }
        .task {
            do{
                try await model.populateTents()
            }
            catch{
                print(error)
            }
        }
        
//        NavigationStack{
//            ForEach(model.tents, id: \.id){ tent in
//                Text(tent.name)
//            }
//        }
    }
}

struct NameView: View{
    var name: String
    var body: some View {
        Text(name).navigationTitle(name)
    }
}

#Preview {
    TestView()
}
