//
//  PersonController.swift
//  App
//
//  Created by Artur Akvelon on 25.06.2019.
//

import Vapor

/// Controls basic CRUD operations on `Person`s.
final class PersonController {
    /// Returns a list of all `Person`s.
    func index(_ req: Request) throws -> Future<[Person]> {
        return Person.query(on: req).all()
    }
    
    /// Saves a decoded `Person` to the database.
    func create(_ req: Request) throws -> Future<Person> {
        return try req.content.decode(Person.self).flatMap { person in
            return person.save(on: req)
        }
    }
    
    /// Deletes a parameterized `Person`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Person.self).flatMap { person in
            return person.delete(on: req)
            }.transform(to: .ok)
    }
}
