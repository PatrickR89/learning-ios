//
//  FileManager+Extension.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

extension FileManager {
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let groupPath = FileManager().containerURL(forSecurityApplicationGroupIdentifier: "group.com.ruzman.challenge-d90") else {fatalError("group directory not found")}
        print(" group path: \(groupPath)")
        print(" self path: \(paths)")
        return groupPath
    }

    func getFilePath(_ name: String) -> URL {
        let filePath = getDocumentsDirectory().appendingPathComponent(name)
        return filePath
    }
}
