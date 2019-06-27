//
//  Debt.swift
//  App
//
//  Created by Artur Akvelon on 26.06.2019.
//

import FluentSQLite
import Vapor

/// A single entry of a Todo list.
final class Debt: SQLiteModel {
    static var defaultDatabase: DatabaseIdentifier<SQLiteDatabase>? = .sqlite
    
    var id: Int?
    
    var value:Decimal
    var description:String
    var ownerId:Int?
    
    init(id: Int? = nil, value:Decimal, description:String, ownerId:Int?) {
        self.id = id
        self.value = value
        self.description = description
        self.ownerId = ownerId
    }
}

extension Debt: SQLiteMigration { }

extension Debt: Content { }

extension Debt: Parameter { }


extension Debt {
    var owner: Parent<Debt, Person>? {
        return parent(\.ownerId)
    }
}
