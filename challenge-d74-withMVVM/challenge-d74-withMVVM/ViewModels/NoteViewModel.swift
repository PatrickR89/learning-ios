//
//  NoteViewModel.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NoteViewModel {
    var note: Note? {
        didSet {
            if let note = note {
                if newNote {
                    print("add note \(note)")
                } else {
                    print("edit note \(note)")
                }
            }
        }
    }
    var newNote: Bool
    var index: Int
    var isButtonEnabled: ObservableObject<Bool> = ObservableObject(false)

    var noteTitle: String? {
        didSet {
            isButtonEnabled.value = enableButton()
        }
    }
    var noteContent: String? {
        didSet {
            isButtonEnabled.value = enableButton()
        }
    }

    init(note: Note, newNote: Bool, index: Int) {
        self.note = note
        self.newNote = newNote
        self.index = index
    }

    func applyChanges() {
        guard let noteTitle = noteTitle,
              let noteContent = noteContent else {return}
        note = Note(title: noteTitle, content: noteContent)
    }

}

private extension NoteViewModel {
    func enableButton() -> Bool {
        guard let noteTitle = noteTitle,
              let noteContent = noteContent else {return false}
        return noteTitle.count >= 1 && noteContent.count >= 1
    }
}
