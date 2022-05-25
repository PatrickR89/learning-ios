//
//  ViewController.swift
//  Project2CodeOnly
//
//  Created by Patrick on 25.05.2022..
//

import UIKit

class ViewController: UIViewController {
    
    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    let button3 = UIButton(type: .system)
    
    var countries = [String]()
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .cyan
        view.addSubview(button1)
        
                button1.setTitle("Button", for: .normal)
                button1.backgroundColor = .lightGray
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.tag = 0
                
                button1.translatesAutoresizingMaskIntoConstraints = false
                button1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
                button1.widthAnchor.constraint(equalToConstant: 200).isActive = true
                button1.heightAnchor.constraint(equalToConstant: 100).isActive = true
                button1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        view.addSubview(button2)
        
        button2.setTitle("Button2", for: .normal)
        button2.backgroundColor = .green
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button2.tag = 1
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 40).isActive = true
        
        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        view.addSubview(button3)
        
        button3.setTitle("Button3", for: .normal)
        button3.backgroundColor = .red
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button3.tag = 2
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 40).isActive = true
        
        button3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    @objc func buttonAction(_ sender: UIButton!){
        print("Tap test \(sender.tag)")
    }
    


}

