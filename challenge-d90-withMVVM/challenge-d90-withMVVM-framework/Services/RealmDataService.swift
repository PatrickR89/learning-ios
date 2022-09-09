//
//  RealmDataService.swift
//  challenge-d90-withMVVM-framework
//
//  Created by Patrick on 07.09.2022..
//

import UIKit
import RealmSwift

class RealmDataService {
    static let shared = RealmDataService()

    func initiateRealm() -> Realm {
        guard let defaultRealm = Realm.Configuration.defaultConfiguration.fileURL else {
            fatalError("unable to create default realm")
        }

        let url = FileManager.default.getFilePath("defaultRealm.realm")
        var config: Realm.Configuration?

        if FileManager.default.fileExists(atPath: defaultRealm.path) {
            do {
                _ = try FileManager.default.replaceItemAt(url, withItemAt: defaultRealm)

                config = Realm.Configuration(fileURL: url, schemaVersion: 1)
            } catch {
                print("Error info: \(error)")
            }
        } else {
            config = Realm.Configuration(fileURL: url, schemaVersion: 1)
        }
        guard let config = config else {
            fatalError("unable to create config")
        }

        guard let realm = try? Realm(configuration: config) else {fatalError()}
        return realm
    }
}
