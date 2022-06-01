//
//  ViewController.swift
//  Project1CodeOnly
//
//  Created by Patrick on 23.05.2022..
//

import UIKit

class ViewController: UIViewController {

    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView()
        configureTableView()
        title = "Storm view"
        navigationController?.navigationBar.prefersLargeTitles = true

        let barButtonItemSymbol = UIImage(systemName: "star.circle.fill")

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: barButtonItemSymbol,
            style: .plain,
            target: self,
            action: #selector(recommendApp))

        let fileManager = FileManager.default
        guard let path = Bundle.main.resourcePath,
              let items = try? fileManager.contentsOfDirectory(atPath: path),
              items.count > 0 else {
            return
        }

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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell") as? PictureCell else {
            fatalError("Wrong cell type")
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

extension ViewController {
    @objc func recommendApp() {
        let recommendAppString = "I recommend this application"
        let activityController = UIActivityViewController(
            activityItems: [recommendAppString],
            applicationActivities: [])

        activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityController, animated: true)
    }
}
