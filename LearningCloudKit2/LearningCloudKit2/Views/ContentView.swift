//
//  ContentView.swift
//  LearningCloudKit2
//
//  Created by Miriam Mendes on 30/08/24.
//

import SwiftUI
import CoreLocation
import CloudKit


struct ContentView: View {
    @StateObject var model = CKModel()
    @State private var nomeBarraca: String = ""
    @State private var imagemBarraca: String = ""
    @State private var linkMaps: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var banhodemar = true
    @State private var chuveiro = true
    @State private var banheiro = true
    @State private var precoMedio: String = ""
    @State private var lotacao: String = ""
    @State private var showTentsView: Bool = false
    @State private var showAddProductView: Bool = false
    var body: some View {
        VStack{
            segmentedControl
            
            if showTentsView {
                TentsView()
            }
            else if showAddProductView{
                
            }
            else{
                addTentView
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView{
    private var segmentedControl: some View{
        HStack (spacing: 84) {
            Button(action: { showTentsView = false
                showAddProductView = false
            }, label: {
                HStack {
                    Text("Add Barraca")
                        .foregroundStyle(Color.blue)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
            })
            
            Button(action: { showTentsView = true
                showAddProductView = false
            }, label: {
                HStack {
                    Text("Barracas")
                        .foregroundStyle(Color.blue)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
            })
            Button(action: { showTentsView = false
                showAddProductView = true
            }, label: {
                HStack {
                    Text("Add Produtos")
                        .foregroundStyle(Color.blue)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
            })
        }
        .padding(10)
    }
    
    private var addTentView: some View{
        ZStack{
            VStack(alignment: .leading){
                
                Text("Cadastrar Barracas")

                TextField("Nome da Barraca", text: $nomeBarraca)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .border(.secondary)
               
                TextField("Nome da Imagem", text: $imagemBarraca)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .border(.secondary)
          
                TextField("Link Maps", text: $linkMaps)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .border(.secondary)
                TextField("Latitude", text: $latitude)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .border(.secondary)
                TextField("Longitude", text: $longitude)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .border(.secondary)
                
                Toggle("É próprio para banho?", isOn: $banhodemar)
                Toggle("Tem chuveiro perto?", isOn: $chuveiro)
                Toggle("Tem banheiro perto?", isOn: $banheiro)
                
                Text("Preço Médio da Barraca")
                Picker("Preço Médio da Barraca", selection: $precoMedio) {
                    Text("Baixo").tag("Baixo")
                    Text("Médio").tag("Médio")
                    Text("Alto").tag("Alto")
                            }
                            .pickerStyle(.segmented)
                
                Text("Lotação")
                Picker("Preço Médio da Barraca", selection: $lotacao) {
                    Text("Baixa").tag("Baixa")
                    Text("Média").tag("Média")
                    Text("Alta").tag("Alta")
                            }
                            .pickerStyle(.segmented)
                            .padding(.bottom, 20)
                
                    Button{
                        let coordinates = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
                        let tentItem = Tents(name: nomeBarraca, image: imagemBarraca, linkMap: linkMaps, coordinates: coordinates, seaBath: banhodemar, shower: chuveiro, toilet: banheiro, averagePrice: precoMedio, capacity: lotacao)
                        Task{
                            do{
                                try await model.addTent(tent: tentItem)
                            }
                            catch{
                                print("Error \(error.localizedDescription)")
                            }
                        }
                        
                        
                    }label: {
                        Text("Cadastrar Barraca")
                            .padding()
                            .foregroundColor(.blue)
                            .frame(width: 357)
                            .background(
                                RoundedRectangle(cornerRadius: 15,style: .continuous)
                                    .fill(.blue.opacity(0.2)))
                            
                    }
            }
            .padding()
        }
    }
}
