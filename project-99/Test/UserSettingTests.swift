//
//  UserSettingTests.swift
//  project-99
//
//  Created by Patrick on 21.10.2022..
//

import XCTest
@testable import project_99

class UserSettingTests: XCTestCase {

    func testSetup() throws {
        let uuid = UUID()
        let userSetting = UserSettings(userId: uuid, theme: .dark, withMulticolor: false, withTimer: false)

        XCTAssertEqual(userSetting.userId, uuid)
        XCTAssertEqual(userSetting.theme, .dark)
    }
}
