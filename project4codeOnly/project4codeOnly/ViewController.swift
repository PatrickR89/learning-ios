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

        guard let url = URL(string: "https://www.hackingwithswift.com") else {
            print("Website not available")
            return
        }
        webView?.load(URLRequest(url: url))
        webView?.allowsBackForwardNavigationGestures = true
    }
}
