//
//  FileManager+Extension.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

extension FileManager {
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func getFilePath(_ name: String) -> URL {
        let filePath = getDocumentsDirectory().appendingPathComponent(name)
        return filePath
    }
}
