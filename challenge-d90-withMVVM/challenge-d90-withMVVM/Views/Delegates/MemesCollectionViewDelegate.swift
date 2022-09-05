//
//  MemesCollectionViewDelegate.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

protocol MemesCollectionViewDelegate: AnyObject {
    func memesCollectionView(_ view: MemesCollectionView, didSelectCellWith meme: Meme, at index: Int)
    func memesCollectionView(_ view: MemesCollectionView, didRegisterUpdate meme: Meme)
}
