//
//  navController.swift
//  Project2CodeOnly
//
//  Created by Patrick on 25.05.2022..
//

import UIKit

class navController: UINavigationController {
    
    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    let button3 = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button1.setTitle("Button", for: .normal)
        button1.backgroundColor = .lightGray
        
        
        button1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button1)
        
    }
    
    @objc func buttonAction(){
        print("Tap test")
    }
    
}
