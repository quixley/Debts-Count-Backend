//
//  Person.swift
//  App
//
//  Created by Artur Akvelon on 25.06.2019.
//

import FluentSQLite
import Vapor

/// A single entry of a Todo list.
final class Person: SQLiteModel {
    var id: Int?
    
    /// The unique identifier for this `Todo`.
    var name: String
    
    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
}

/// Allows `Person` to be used as a dynamic migration.
extension Person: Migration { }

/// Allows `Person` to be encoded to and decoded from HTTP messages.
extension Person: Content { }

/// Allows `Person` to be used as a dynamic parameter in route definitions.
extension Person: Parameter { }
