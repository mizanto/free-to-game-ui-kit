//
//  ViewController.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 20.06.2022.
//

import UIKit

class EmptyViewController: UIViewController {
    
    private let api = API()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
        
        Task {
            let games = try await api.games()
            print(games)
        }
    }

}

