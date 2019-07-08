import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let peopleController = PersonController()
    router.get("people", use: peopleController.list)
    router.get("people", Int.parameter, use: peopleController.single)
    router.post("people", use: peopleController.create)
    router.delete("people", Person.parameter, use: peopleController.delete)
    
    let debtsController = DebtsController()
    router.get("people", Int.parameter, "debts", use: debtsController.list)
    router.post("people", Int.parameter, "debts", use: debtsController.create)
    router.delete("people", Int.parameter, "debts", Debt.parameter, use: debtsController.delete)
    
    let imageController = ImageController()
    router.get("image", String.parameter, use: imageController.getImage)
    router.post("image", use: imageController.postImage)
}
