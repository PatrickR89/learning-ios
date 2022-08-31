//
//  NotesViewModel.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class NotesViewModel {
    var notes: ObservableObject<[Note]> = ObservableObject(DataStorage.shared.loadAndDecode())
    let noteViewModel = NoteViewModel()

    init() {
        noteViewModel.delegate = self
    }

    func deleteNote (_ index: Int) {
        notes.value?.remove(at: index)
    }
}

extension NotesViewModel: NoteViewModelDelegate {
    func noteViewModel(_ viewModel: NoteViewModel, didAddNote note: Note) {
        notes.value?.append(note)
    }

    func noteViewModel(_ viewModel: NoteViewModel, didChangeNote note: Note, at index: Int) {
        notes.value?[index] = note
    }
}
