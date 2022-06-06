//
//  DetailViewController.swift
//  project7codeOnly
//
//  Created by Patrick on 06.06.2022..
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView?
    var singleItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let singleItem = singleItem else {
            return
        }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>body { font-size: 150% }</style>
        </head>
        <body>
        \(singleItem.body)
        </body>
        </html>
        """

        webView?.loadHTMLString(html, baseURL: nil)

    }
}
