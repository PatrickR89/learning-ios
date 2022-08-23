//
//  NoteViewDelegate.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

protocol NoteViewDelegate: AnyObject {
    func titleUpdate(_ title: String)
    func contentUpdated(_ content: String)
    func buttonClicked()
}
