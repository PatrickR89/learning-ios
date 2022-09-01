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
                    delegate?.noteViewModel(self, didChangeNote: note, at: index)
                } else {
                    delegate?.noteViewModel(self, didAddNote: note)
                }
            }
        }
    }

    var index: Int? {
        didSet {
            buttonTitle.value = setButtonTitle()
        }
    }
    var buttonTitle: ObservableObject<String> = ObservableObject("ADD")
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

    weak var delegate: NoteViewModelDelegate?

    init() {
        isButtonEnabled.value = enableButton()
    }

    func setupSelf(note: Note?, index: Int?) {
        if let note = note {
            self.noteTitle = note.title
            self.noteContent = note.content
        } else {
            self.noteTitle = ""
            self.noteContent = ""
        }

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

    func setButtonTitle() -> String {
        if index != nil {
            return "APPLY"
        } else {
            return "ADD"
        }
    }
}
