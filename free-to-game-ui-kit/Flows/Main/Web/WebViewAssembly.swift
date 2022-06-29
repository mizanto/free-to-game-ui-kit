//
//  WebViewAssembly.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import Foundation
import UIKit

final class WebViewAssembly {
    static func build(url: URL) -> UIViewController {
        return WebViewController(url: url)
    }
}
