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
    
    static var defaultDatabase: DatabaseIdentifier<SQLiteDatabase>? = .sqlite
    
    var id: Int?
    
    /// The unique identifier for this `Todo`.
    var name: String
    var relation:String?
    var avatar:String?
    var total:Decimal?
    
    init(id: Int? = nil, name: String, relation:String? = nil, avatar:String? = nil, total:Decimal? = 0) {
        self.id = id
        self.name = name
        self.relation = relation
        self.avatar = avatar
        self.total = total ?? 0
    }
    
}

/// Allows `Person` to be used as a dynamic migration.
extension Person: SQLiteMigration {
//    static func prepare(on conn: SQLiteConnection) -> Future<Void> {
//        return SQLiteDatabase.update(Person.self, on: conn) { builder in
//            let defaultValueConstraint = SQLiteColumnConstraint.default(.literal(0))
//            builder.field(for: \.total, type: .integer, defaultValueConstraint)
//        }
//    }
}

/// Allows `Person` to be encoded to and decoded from HTTP messages.
extension Person: Content { }

/// Allows `Person` to be used as a dynamic parameter in route definitions.
extension Person: Parameter { }

extension Person {
    var debts: Children<Person, Debt> {
        return children(\.personId)
    }
}
