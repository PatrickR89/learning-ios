//
//  FileManager+Extension.swift
//  project-99
//
//  Created by Patrick on 16.09.2022..
//

import UIKit

extension FileManager {
    private func getDocumentsDirectory() -> URL {
        guard let groupPath = FileManager().containerURL(
            forSecurityApplicationGroupIdentifier: "group.com.ruzman.challenge-d90")
        else {fatalError("group directory not found")}
        return groupPath
    }

    func getFilePath(_ name: String) -> URL {
        let filePath = getDocumentsDirectory().appendingPathComponent(name)
        return filePath
    }
}
