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
        hideErrorView()
        hideProgressView()
    }
    
    // MARK: - ProgressView
    
    func showProgressView(title: String = "Loading...") {
        hideInfoView()
        hideErrorView()
        
        if let progressView = view.subviews.first(where: { $0 is ProgressView }) as? ProgressView {
            view.bringSubviewToFront(progressView)
            progressView.setTitle(title)
            progressView.start()
        } else {
            let progressView = ProgressView()
            progressView.setTitle(title)
            view.addSubview(progressView)
            progressView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            progressView.start()
        }
    }
    
    func hideProgressView() {
        if let progressView = view.subviews.first(where: { $0 is ProgressView }) as? ProgressView {
            progressView.stop()
            progressView.removeFromSuperview()
        }
    }
    
    // MARK: - InfoView
    
    func showInfoView(text: String = "Info View") {
        hideProgressView()
        hideErrorView()
        
        if let infoView = view.subviews.first(where: { $0 is InfoView }) as? InfoView {
            view.bringSubviewToFront(infoView)
            infoView.text = text
        } else {
            let infoView = InfoView()
            infoView.text = text
            view.addSubview(infoView)
            infoView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func hideInfoView() {
        if let infoView = view.subviews.first(where: { $0 is InfoView }) as? InfoView {
            infoView.removeFromSuperview()
        }
    }
    
    // MARK: - ErrorView
    
    func showErrorView(message: String = "Error Message") {
        hideProgressView()
        hideInfoView()
        
        if let errorView = view.subviews.first(where: { $0 is ErrorView }) as? ErrorView {
            view.bringSubviewToFront(errorView)
            errorView.errorMessage = message
        } else {
            let errorView = ErrorView()
            errorView.errorMessage = message
            view.addSubview(errorView)
            errorView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func hideErrorView() {
        if let errorView = view.subviews.first(where: { $0 is ErrorView }) as? ErrorView {
            errorView.removeFromSuperview()
        }
    }
    
}
