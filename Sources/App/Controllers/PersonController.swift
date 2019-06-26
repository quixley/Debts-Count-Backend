//
//  PersonController.swift
//  App
//
//  Created by Artur Akvelon on 25.06.2019.
//


import Vapor
import Fluent


enum NetworkError: Error {
    case badRequestForUser
}

/// Controls basic CRUD operations on `Person`s.
final class PersonController {
    /// Returns a list of all `Person`s.
    func list(_ req: Request) throws -> Future<[Person]> {
        return Person.query(on: req).all()
    }
    
    func single(_ req: Request) throws -> Future<Person> {
        guard let personId = try? req.parameters.next(Int.self) else {
            throw Abort(.notFound)
        }
        
        return Person.find(personId, on:req).flatMap(to: Person.self) { person in
            guard let person = person else {
                throw Abort(.notFound)
            }
            return person.update(on: req)
        }
    }
    
    /// Saves a decoded `Person` to the database.
    func create(_ req: Request) throws -> Future<Person> {
        return try req.content.decode(Person.self).flatMap(to:Person.self) { person in
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

public extension Future where Expectation: OptionalType {
    /// Unwraps an optional value contained inside a Future's expectation.
    /// If the optional resolves to `nil` (`.none`), the supplied error will be thrown instead.
    func unwrap(or error: Error) -> Future<Expectation.WrappedType> {
        return map(to: Expectation.WrappedType.self) { optional in
            guard let wrapped = optional.wrapped else {
                throw error
            }
            return wrapped
        }
    }
}

/// Capable of being represented by an optional wrapped type.
///
/// This protocol mostly exists to allow constrained extensions on generic
/// types where an associatedtype is an `Optional<T>`.
public protocol OptionalType {
    /// Underlying wrapped type.
    associatedtype WrappedType

    /// Returns the wrapped type, if it exists.
    var wrapped: WrappedType? { get }

    /// Creates this optional type from an optional wrapped type.
    static func makeOptionalType(_ wrapped: WrappedType?) -> Self
}

/// Conform concrete optional to `OptionalType`.
/// See `OptionalType` for more information.
extension Optional: OptionalType {
    /// See `OptionalType.WrappedType`
    public typealias WrappedType = Wrapped

    /// See `OptionalType.wrapped`
    public var wrapped: Wrapped? {
        switch self {
        case .none: return nil
        case .some(let w): return w
        }
    }

    /// See `OptionalType.makeOptionalType`
    public static func makeOptionalType(_ wrapped: Wrapped?) -> Optional<Wrapped> {
        return wrapped
    }
}
