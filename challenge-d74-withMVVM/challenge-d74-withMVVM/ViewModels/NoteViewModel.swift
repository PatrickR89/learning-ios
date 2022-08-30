//
//  NoteViewModel.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NoteViewModel {
    private var note: Note? {
        didSet {
            if let note = note {
                if let index = index {
                    NoteViewModel.delegate?.noteViewModel(self, didChangeNote: note, at: index)
                } else {
                    NoteViewModel.delegate?.noteViewModel(self, didAddNote: note)
                }
            }
        }
    }

    private var index: Int?
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

    init(note: Note?, index: Int?) {
        if let note = note {
            self.noteTitle = note.title
            self.noteContent = note.content
        } else {
            self.noteTitle = ""
            self.noteContent = ""
        }

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
