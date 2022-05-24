//
//  ViewController.swift
//  Project1CodeOnly
//
//  Created by Patrick on 23.05.2022..
//

import UIKit

class ViewController: UIViewController {
    
    var pictures = [String]()
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        title = "Storm view"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        
        pictures.sort()
        print(pictures)
                
        view.backgroundColor = .cyan
    }
    
    
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 50
        tableView.register(PictureCell.self, forCellReuseIdentifier: "PictureCell")
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell") as! PictureCell
        cell.label.text = pictures[indexPath.row]
        return cell
}
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            vc.pictureAmount = pictures.count
//            vc.selectedImage = pictures[indexPath.row]
//            vc.selectedImageIndex = pictures.firstIndex(of: pictures[indexPath.row])!
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}
