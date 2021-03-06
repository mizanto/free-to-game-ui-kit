//
//  UIViewController+Extension.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 23.06.2022.
//

import UIKit

extension UIViewController {
    
    func hideAnyStubs() {
        hideInfoView()
        hideProgressView()
    }
    
    // MARK: - ProgressView
    
    func showProgressView(title: String = "Loading...") {
        hideAnyStubs()
        
        let progressView = ProgressView()
        progressView.setTitle(title)
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        progressView.start()
    }
    
    func hideProgressView() {
        if let progressView = view.subviews.first(where: { $0 is ProgressView }) as? ProgressView {
            progressView.stop()
            progressView.removeFromSuperview()
        }
    }
    
    // MARK: - ErrorView
    
    func showInfoView(type: InfoView.StubType, message: String, action: @escaping () -> ()) {
        hideAnyStubs()
        
        let errorView = InfoView(type: type, message: message, buttonTitle: "Retry", action: action)
        view.addSubview(errorView)
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func hideInfoView() {
        if let errorView = view.subviews.first(where: { $0 is InfoView }) as? InfoView {
            errorView.removeFromSuperview()
        }
    }
    
}
