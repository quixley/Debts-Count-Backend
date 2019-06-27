//
//  DebtsController.swift
//  App
//
//  Created by Artur Akvelon on 26.06.2019.
//

import Vapor
import Fluent

final class DebtsController {
    /// Returns a list of all `Person`s.
    func list(_ req: Request) throws -> Future<[Debt]> {
        
        let personId = try req.parameters.next(Int.self)
        return Debt.query(on: req).filter(\.ownerId == personId).all()
    }
    
    /// Saves a decoded `Person` to the database.
    func create(_ req: Request) throws -> Future<Debt> {
        
//        let personId = try req.query.get(Int.self, at: ["personId"])
        let personId = try req.parameters.next(Int.self)
        return try req.content.decode(Debt.self).flatMap(to:Debt.self) { debt in
            debt.ownerId = personId
            return debt.save(on: req)
        }
    }
    
    /// Deletes a parameterized `Person`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Person.self).flatMap { debt in
            return debt.delete(on: req)
            }.transform(to: .ok)
    }
}
