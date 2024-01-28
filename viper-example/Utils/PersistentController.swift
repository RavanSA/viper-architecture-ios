//
//  PersistenController.swift
//  viper-example
//
//  Created by Revan SADIGLI on 21.01.2024.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ViperExampleApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            print("Found Changes")
            do {
                try context.save()
            } catch {
                print("ERROR")
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        } else {
            print("NO Changes")
        }
    }
    
    func deleteAll<T: NSManagedObject>(data: T.Type) {
          let fetchRequest: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
          let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
          _ = try? viewContext.execute(batchDeleteRequest)
    }
    
    func isRecordExist(entityName name: String, columnName id: String, recordID recID: String) -> Bool {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(name)")
        fetchRequest.predicate = NSPredicate(format: "\(id) = %@", String(recID))

        let res = try? viewContext.fetch(fetchRequest)
        return (res?.count ?? 0) > 0 ? true : false
    }
    
    func allRecords<T: NSManagedObject>(of type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let results = try viewContext.fetch(request)
            return results as! [T]
        } catch {
            print("Error with request: \(error)")
            return []
        }
    }

}
