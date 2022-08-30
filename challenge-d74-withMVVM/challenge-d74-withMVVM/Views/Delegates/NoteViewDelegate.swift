//
//  NoteViewDelegate.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

protocol NoteViewDelegate: AnyObject {
    func noteView(_ view: NoteView, didUpdateTitle title: String)
    func noteView(_ view: NoteView, didUpdateContent content: String)
    func noteViewDidTapButton()
}
