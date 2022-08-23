//
//  DataStorage.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class DataStorage {
    static let shared = DataStorage()

    private let fileLocation = FileManager().getFilePath("notesJSON.txt")

    func encodeAndSave(_ data: [Note]) {
        do {
            let dataJSON = try JSONEncoder().encode(data)
            try dataJSON.write(to: fileLocation)
        } catch {
            print("Error occurred during file save: \(error)")
        }
    }

    func loadAndDecode() -> [Note] {
        do {
            let response = try String(contentsOf: fileLocation)
            let data = Data(response.utf8)
            let notes = try JSONDecoder().decode([Note].self, from: data)
            return notes
        } catch {
            print("Error occurred during file load: \(error)")

            let notes: [Note] = []
            return notes
        }
    }
}
