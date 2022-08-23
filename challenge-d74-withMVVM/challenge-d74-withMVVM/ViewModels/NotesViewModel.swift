//
//  NotesViewModel.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NotesViewModel {
    var notes: ObservableObject<[Note]> = ObservableObject([])

    init() {
        NoteViewModel.delegate = self
    }

    func deleteNote (_ index: Int) {
        notes.value?.remove(at: index)
    }
}

extension NotesViewModel: NoteViewModelDelegate {
    func noteDidSet(note: Note) {
        notes.value?.append(note)
    }

    func noteDidChange(note: Note, index: Int) {
        notes.value?[index] = note
    }
}
