//
//  Person.swift
//  App
//
//  Created by Artur Akvelon on 25.06.2019.
//

import FluentSQLite
import Vapor
//
///// A single entry of a Todo list.
//final class Person: SQLiteModel {
//    
//    static var defaultDatabase: DatabaseIdentifier<SQLiteDatabase>? = .sqlite
//    
//    var id: Int?
//    
//    /// The unique identifier for this `Todo`.
//    var name: String
//    var relation:String?
//    
//    init(id: Int? = nil, name: String, relation:String? = nil) {
//        self.id = id
//        self.name = name
//        self.relation = relation
//    }
//}
//
///// Allows `Person` to be used as a dynamic migration.
//extension Person: SQLiteMigration { }
//
///// Allows `Person` to be encoded to and decoded from HTTP messages.
//extension Person: Content { }
//
///// Allows `Person` to be used as a dynamic parameter in route definitions.
//extension Person: Parameter { }
//
//extension Person {
//    var debts: Children<Person, Debt> {
//        return children(\.ownerId)
//    }
//}
