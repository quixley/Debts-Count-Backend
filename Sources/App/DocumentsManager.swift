//
//  DocumentsManager.swift
//  App
//
//  Created by Artur Akvelon on 04.07.2019.
//

import Foundation

struct DocumentsManager {
    public static func getDocumentsDirectory() throws -> URL {
        let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return path
    }
}
