import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    // Example of configuring a controller
    let peopleController = PersonController()
    router.get("people", "list", use: peopleController.list)
    router.get("people", use: peopleController.single)
    router.post("people", use: peopleController.create)
    router.delete("people", Person.parameter, use: peopleController.delete)
    
}
