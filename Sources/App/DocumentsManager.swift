//
//  DocumentsManager.swift
//  App
//
//  Created by Artur Akvelon on 04.07.2019.
//

import Foundation

struct DocumentsManager {
    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
