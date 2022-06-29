//
//  WebViewController.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private var webView: WKWebView!
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showProgressView()
        webView.load(URLRequest(url: url))
    }

}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideProgressView()
    }
}
