//
//  HomeViewController.swift
//  Slide Menu
//
//  Created by Serhii on 12.01.2022.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
   func didTapMenuButton()
}

class HomeViewController: UIViewController {
   
   weak var delegate: HomeViewControllerDelegate?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      title = "Home"
      view.backgroundColor = .white
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                         style: .done,
                                                         target: self,
                                                         action: #selector(didTapMenuButton))
   }
   
   @objc func didTapMenuButton() {
      delegate?.didTapMenuButton()
   }
}
