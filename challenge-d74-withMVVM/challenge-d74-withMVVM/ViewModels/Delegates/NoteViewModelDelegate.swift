//
//  NoteViewModelDelegate.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

protocol NoteViewModelDelegate: AnyObject {
    func noteViewModel(_ viewModel: NoteViewModel, didAddNote note: Note)
    func noteViewModel(_ viewModel: NoteViewModel, didChangeNote note: Note, at index: Int)
}
