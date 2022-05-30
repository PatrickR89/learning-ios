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
    var detailVC = DetailViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        title = "Storm view"
        navigationController?.navigationBar.prefersLargeTitles = true

        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!

      if let items = try? fileManager.contentsOfDirectory(atPath: path) {
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
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

    func addDetailVC() {
        addChild(detailVC)
        view.addSubview(detailVC.view)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell") as? PictureCell else {
        fatalError("Unexpected index path")
      }
        cell.label.text = pictures[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let viewCtrl = DetailViewController()
        self.navigationController?.pushViewController(viewCtrl, animated: false)
      viewCtrl.pictureAmount = pictures.count
      viewCtrl.selectedImage = pictures[indexPath.row]
      viewCtrl.selectedImageIndex = pictures.firstIndex(of: pictures[indexPath.row])!
    }
}
