//
//  MemesCollectionViewController.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit
import RealmSwift

class MemesCollectionViewController: UIViewController {

    let memesCollectionView: MemesCollectionView
    let memesViewModel: MemesViewModel
    let realm: Realm

    init() {
        guard let realm = try? Realm(configuration: Realm.Configuration.defaultConfiguration) else {fatalError()}
        self.realm = realm
        self.memesViewModel = MemesViewModel(realm: realm)
        self.memesCollectionView = MemesCollectionView(with: memesViewModel)
        NotificationAlerts.shared.registerApp()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewMeme))
    }
}

private extension MemesCollectionViewController {
    func setupUI() {
        view.addSubview(memesCollectionView)
        memesCollectionView.frame = view.bounds
        memesCollectionView.delegate = self
    }

    @objc func addNewMeme() {
        memesViewModel.loadMeme(nil)
        let viewController = MemeViewController(
            memeViewModel: memesViewModel.memeViewModel,
            with: memesViewModel.memeVCViewModel)
        let navController = UINavigationController()
        navController.viewControllers = [viewController]
        present(navController, animated: true)
    }
}

extension MemesCollectionViewController: MemesCollectionViewDelegate {
    func memesCollectionView(_ view: MemesCollectionView, didRegisterUpdate meme: Meme) {
        NotificationAlerts.shared.scheduleNotification(in: self, for: meme)
    }

    func memesCollectionView(_ view: MemesCollectionView, didSelectCellWith meme: Meme, at index: Int) {
        memesViewModel.loadMeme(meme)
        let navController = UINavigationController()
        let viewController = MemeViewController(
            memeViewModel: memesViewModel.memeViewModel,
            with: memesViewModel.memeVCViewModel)

        navController.viewControllers = [viewController]
        present(navController, animated: true)
    }
}

extension MemesCollectionViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // swipe to unlock
                memesViewModel.findAndOpenMemeByName(customData)
                let navController = UINavigationController()
                let viewController = MemeViewController(
                    memeViewModel: memesViewModel.memeViewModel,
                    with: memesViewModel.memeVCViewModel)

                navController.viewControllers = [viewController]
                present(navController, animated: true)
            default:
                break
            }
        }
        completionHandler()
    }
}
