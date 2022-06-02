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
    var progressView: UIProgressView?
    var progressButton: UIBarButtonItem?
    var websites = ["www.apple.com", "www.hackingwithswift.com"]

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

        progressView = UIProgressView(progressViewStyle: .default)
        progressView?.sizeToFit()

        if let progressView = progressView {
            progressButton = UIBarButtonItem(customView: progressView)
        }

        toolbarItems = [progressButton ?? spacer, spacer, refresh]
        navigationController?.isToolbarHidden = false

        guard let url = URL(string: "https://" + websites[1]) else {
            print("Website not available")
            return
        }
        webView?.load(URLRequest(url: url))
        webView?.allowsBackForwardNavigationGestures = true
        webView?.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    @objc func openLinks() {
        let actionController = UIAlertController(title: "Open page", message: nil, preferredStyle: .actionSheet)

        for website in websites {
            actionController.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }

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

    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?) {

        if keyPath == "estimatedProgress" {
            progressView?.progress = Float(webView?.estimatedProgress ?? 0)
        }
    }
}
