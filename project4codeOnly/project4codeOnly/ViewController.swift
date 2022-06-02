//
//  ViewController.swift
//  project4codeOnly
//
//  Created by Patrick on 01.06.2022..
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView?

    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Open",
            style: .plain,
            target: self,
            action: #selector(openLinks))

        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)

        let refresh = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: webView,
            action: #selector(webView?.reload))

        toolbarItems = [spacer, refresh]
        navigationController?.isToolbarHidden = false

        guard let url = URL(string: "https://www.hackingwithswift.com") else {
            print("Website not available")
            return
        }
        webView?.load(URLRequest(url: url))
        webView?.allowsBackForwardNavigationGestures = true
    }

    @objc func openLinks() {
        let actionController = UIAlertController(title: "Open page", message: nil, preferredStyle: .actionSheet)
        actionController.addAction(UIAlertAction(title: "www.apple.com", style: .default, handler: openPage))
        actionController.addAction(UIAlertAction(title: "www.hackingwithswift.com", style: .default, handler: openPage))
        actionController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(actionController, animated: true)
    }

    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {
            print("Website not found")
            return
        }

        guard let url = URL(string: "https://" + actionTitle) else {
            return
        }

        webView?.load(URLRequest(url: url))
    }
}
