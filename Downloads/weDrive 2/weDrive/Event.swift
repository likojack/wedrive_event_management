//
//  Event.swift
//  weDrive
//
//  Created by kejielee on 28/07/2015.
//  Copyright (c) 2015 michelle. All rights reserved.
//

import Foundation
import CoreData

class Event: NSManagedObject {

    @NSManaged var from: String
    @NSManaged var name: String
    @NSManaged var note: String
    @NSManaged var people: [String]
    @NSManaged var previewimage: NSData
    @NSManaged var time: String
    @NSManaged var to: String

}
