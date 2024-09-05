//
//  CKModel.swift
//  LearningCloudKit2
//
//  Created by Miriam Mendes on 30/08/24.
//

import Foundation
import CloudKit

@MainActor
class CKModel: ObservableObject{
    //var database = CKContainer.default().publicCloudDatabase
    var database = CKContainer.init(identifier: "iCloud.mrms.PeNaAreiaADA").publicCloudDatabase
    @Published var tentsDictionary: [CKRecord.ID: Tents] = [:]
    
    var tents: [Tents]{
        tentsDictionary.values.compactMap{$0}
    }
    
    func addTent(tent: Tents) async throws{
        _ = try await database.save(tent.record)
        
    }
    
    func populateTents() async throws{
        let query = CKQuery(recordType: TentsRecordKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let result = try await database.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        records.forEach{ record in
            tentsDictionary[record.recordID] = Tents(record: record)
        }
    }
    
//    func addProduct(product: Products, forTent tent: Tents) async throws {
//        let tentReference = CKRecord.Reference(recordID: tent.id!, action: .none)
//        var productWithReference = product
//        productWithReference.tentReference = tentReference
//        
//        _ = try await database.save(productWithReference.record)
//    }
    
    func addProduct(product: Products) async throws{
        _ = try await database.save(product.record)
        
    }
    
    
    
    

}
