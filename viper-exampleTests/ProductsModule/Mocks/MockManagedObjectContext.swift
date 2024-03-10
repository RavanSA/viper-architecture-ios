//
//  MockManagedObjectContext.swift
//  viper-exampleTests
//
//  Created by Revan SADIGLI on 10.03.2024.
//

import Foundation
import CoreData
@testable import viper_example

protocol ManagedObjectContext {
    func save() throws
}

extension NSManagedObjectContext: ManagedObjectContext { }

class MockManagedObjectContext: ManagedObjectContext {
    var isSaveCalled = false

    func save() throws {
        isSaveCalled = true
    }
}
