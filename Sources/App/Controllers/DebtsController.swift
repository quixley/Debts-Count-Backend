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
        
        return Debt.query(on: req).filter(\.personId == personId).all()
    }
    
    /// Saves a decoded `Person` to the database.
    func create(_ req: Request) throws -> Future<Debt> {
        
//        let personId = try req.query.get(Int.self, at: ["personId"])
        let personId = try req.parameters.next(Int.self)
        
        return try req.content.decode(Debt.self).flatMap(to:Debt.self) { debt in
            debt.personId = personId
            let _ = Person.find(personId, on: req).map { person in
                guard let person = person else { return }
                person.total = person.total != nil ? person.total! + debt.value : debt.value
                let _ = person.save(on: req)
            }
            return debt.save(on: req)
        }
    }
    
    /// Deletes a parameterized `Person`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        
        guard let personIdString = req.parameters.values.first?.value,
            let personId = Int(personIdString) else { throw Abort(.notFound) }
        
        guard let debtIdString = req.parameters.values.last?.value,
            let debtId = Int(debtIdString) else { throw Abort(.notFound) }
        
        return Debt.find(debtId, on:req).flatMap(to: Debt.self) { debt in
            guard let debt = debt,
                let ownerId = debt.personId else {
                throw Abort(.notFound)
            }
            
            if ownerId != personId {
                throw Abort(.conflict)
            }
            return debt.update(on: req)
        }.delete(on: req).transform(to: .ok)
        
    }
}
