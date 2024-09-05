//
//  TentsView.swift
//  LearningCloudKit2
//
//  Created by Miriam Mendes on 04/09/24.
//

import SwiftUI
import CoreLocation
import CloudKit

struct TentsView: View {
    @StateObject var model = CKModel()
    var body: some View {
        VStack{
//            ForEach(Array(model.tentsDictionary.keys), id: \.self) { key in
//                // Exiba o conteúdo associado à chave
//                if let tent = model.tentsDictionary[key] {
//                    Text("ID: \(key.recordName), Tent: \(tent.description)")
//                }
//            }

            List(model.tents, id: \.id){ tent in
                HStack {
                    Text("\(tent.name)")
                    Spacer()
                    Button{
                        let productItem = Products(name: "Produto Teste", description: "dsha", price: 4.5, category: "Refrigerante", categoryImage: "Imagem", serving: 2, tentReference: CKRecord.Reference(recordID: tent.id!, action: .none)
                        )
                    
                        Task{
                            do{
                                try await model.addProduct(product: productItem)
                            }
                            catch{
                                print("Error \(error.localizedDescription)")
                            }
                        }
                        
                    }label: {
                        Image(systemName: "plus.app")
                    }
                }
            }
            
//            List(Array(model.tentsDictionary.keys), id: \.self){ key in
//                HStack {
//                    Text(model.tentsDictionary[key]?.name ?? "")
//                    Spacer()
//                    Button{
//
//                    }label: {
//                        Image(systemName: "plus.app")
//                    }
//                }
//            }
            
        }
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
    TentsView()
}
