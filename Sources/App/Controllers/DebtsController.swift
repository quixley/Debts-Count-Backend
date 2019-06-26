//
//  DebtsController.swift
//  App
//
//  Created by Artur Akvelon on 26.06.2019.
//

import Vapor

final class DebtsController {
    /// Returns a list of all `Person`s.
    func index(_ req: Request) throws -> Future<[Debt]> {
        return Debt.query(on: req).all()
    }
    
    /// Saves a decoded `Person` to the database.
    func create(_ req: Request) throws -> Future<Debt> {
        return try req.content.decode(Debt.self).flatMap(to:Debt.self) { debt in
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
