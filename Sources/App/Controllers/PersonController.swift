//
//  PersonController.swift
//  App
//
//  Created by Artur Akvelon on 25.06.2019.
//

import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class PersonController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Person]> {
        return Person.query(on: req).all()
    }
    
    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Person> {
        return try req.content.decode(Person.self).flatMap { person in
            return person.save(on: req)
        }
    }
    
    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Person.self).flatMap { person in
            return person.delete(on: req)
            }.transform(to: .ok)
    }
}
