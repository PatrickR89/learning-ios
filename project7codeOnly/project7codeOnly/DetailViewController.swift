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
    var singleItem: Petition

    required init(singleItem: Petition) {
        self.singleItem = singleItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
