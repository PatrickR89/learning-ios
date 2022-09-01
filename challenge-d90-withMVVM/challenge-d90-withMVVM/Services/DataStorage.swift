//
//  DataStorage.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class DataStorage {
    static let shared = DataStorage()

    private let filePath = FileManager.default.getFilePath("memes.json")

    func saveFile(save data: [Meme]) {
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: filePath)
        } catch {
            print("Error occurred during saving")
        }
    }

    func loadFile() -> [Meme] {

        do {
            let response = try String(contentsOf: filePath)
            let data = Data(response.utf8)
            let memes = try JSONDecoder().decode([Meme].self, from: data)
            return memes
        } catch {
            print("Error occurred during file loading")
            return []
        }
    }
}
