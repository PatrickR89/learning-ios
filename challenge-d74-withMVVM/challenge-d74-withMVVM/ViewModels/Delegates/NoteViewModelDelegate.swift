//
//  NoteViewModelDelegate.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

protocol NoteViewModelDelegate: AnyObject {
    func noteDidSet(note: Note)
    func noteDidChange(note: Note, index: Int)
}
