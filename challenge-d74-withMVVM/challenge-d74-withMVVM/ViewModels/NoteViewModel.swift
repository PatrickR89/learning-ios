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
                if let index = index {
                    NoteViewModel.delegate?.noteDidChange(note: note, index: index)
                } else {
                    NoteViewModel.delegate?.noteDidSet(note: note)
                }
            }
        }
    }
    
    var index: Int?
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

    static weak var delegate: NoteViewModelDelegate?

    init(note: Note, index: Int?) {
        self.noteTitle = note.title
        self.noteContent = note.content
        self.index = index

        isButtonEnabled.value = enableButton()
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
