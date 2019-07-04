//
//  ImageController.swift
//  App
//
//  Created by Artur Akvelon on 04.07.2019.
//

import Foundation
import Vapor


struct ImageController {

    
    func getImage(_ request: Request) throws -> Response {
        // add controller code here
        // to determine which image is returned
        let path = try request.parameters.next(String.self)
        let fileUrl = DocumentsManager.getDocumentsDirectory().appendingPathComponent(path + ".png")
        
        do {
            let data = try Data(contentsOf: fileUrl)
            // makeResponse(body: LosslessHTTPBodyRepresentable, as: MediaType)
            let response: Response = request.response(data, as: MediaType.png)
            return response
        } catch {
            let response: Response = request.response("image not available")
            return response
        }
    }
    func postImage(_ req: Request) throws -> Response {
        guard let fileData = req.http.body.data else { throw Abort(.notFound) }
        let imageID = UUID().uuidString
        
        let filename = DocumentsManager.getDocumentsDirectory().appendingPathComponent("\(imageID).png")
        
        do {
            try fileData.write(to: filename, options: [.atomic])
        } catch {
            throw Abort(HTTPResponseStatus.conflict)
        }
        let responseObj = ["path":"image/\(imageID)"]
        let body = try JSONEncoder().encode(responseObj)
        return Response(http: HTTPResponse(status:.ok, body:body), using: req)
    }
    
    
    
}
