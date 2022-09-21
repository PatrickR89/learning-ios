//
//  StatCellBottomSubviewDelegate.swift
//  project-99
//
//  Created by Patrick on 21.09.2022..
//

import Foundation

protocol StatCellBottomSubviewDelegate: AnyObject {
    func statCellBottomSubview(_ view: StatCellBottomSubview, didChangeValueAt index: Int)
}
