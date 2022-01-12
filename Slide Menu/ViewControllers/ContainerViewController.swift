//
//  ContainerViewController.swift
//  Slide Menu
//
//  Created by Serhii on 11.01.2022.
//

import UIKit

class ContainerViewController: UIViewController {
 
   let menuVC = MenuViewController()
   let homeVC = HomeViewController()
   let infoVC = InfoViewController()
   let settingsVC = SettingsViewController()
   let shareAppVC = ShareAppViewController()
   let appRating = AppRatingViewController()
   
   var navVC: UINavigationController?
   
   enum MenuState {
      case opened
      case closed
   }
   
   private var menuState: MenuState = .closed
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .gray
      
      addChildsVCs()
   }
   
   func addChildsVCs() {
      //Add Menu
      menuVC.delegate = self
      addChild(menuVC)
      view.addSubview(menuVC.view)
      menuVC.didMove(toParent: self)
      
      //Add homeVC
      homeVC.delegate = self
      let navVC = UINavigationController(rootViewController: homeVC)
      addChild(navVC)
      view.addSubview(navVC.view)
      navVC.didMove(toParent: self)
      self.navVC = navVC
   }
}

extension ContainerViewController: HomeViewControllerDelegate {
   func didTapMenuButton() {
      toogleMenu(completion: nil)
   }
   
   func toogleMenu(completion: (() -> Void)?) {
      switch menuState {
      case .opened:
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.navVC?.view.frame.origin.x = 0
         } completion: { done in
            if done {
               self.menuState = .closed
               DispatchQueue.main.async {
                  completion?()
               }
            }
         }
      case .closed:
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
         } completion: { done in
            if done {
               self.menuState = .opened
            }
         }
      }
   }
}

extension ContainerViewController: MenuViewControllerDelegate {
   
   func didSelect(menuItem: MenuViewController.MenuOptions) {
      toogleMenu(completion: nil)
      
      switch menuItem {
         case.home:
            resetHome()
         case.info:
            addInfo()
         case.appRating:
            addAppRating()
         case.shareApp:
            addShareApp()
         case.settings:
            addSettings()
      }
   }
   
   func resetHome() {
      appRating.view.removeFromSuperview()
      appRating.didMove(toParent: nil)
      homeVC.title = "Home"
      
      infoVC.view.removeFromSuperview()
      infoVC.didMove(toParent: nil)
      homeVC.title = "Home"
      
      settingsVC.view.removeFromSuperview()
      settingsVC.didMove(toParent: nil)
      homeVC.title = "Home"
      
      shareAppVC.view.removeFromSuperview()
      settingsVC.didMove(toParent: nil)
      homeVC.title = "Home"
   }
   
   func addInfo() {
      homeVC.addChild(infoVC)
      homeVC.view.addSubview(infoVC.view)
      infoVC.view.frame = view.frame
      infoVC.didMove(toParent: homeVC)
      homeVC.title = infoVC.title
   }
   
   func addAppRating() {
      homeVC.addChild(appRating)
      homeVC.view.addSubview(appRating.view)
      appRating.view.frame = view.frame
      appRating.didMove(toParent: appRating)
      homeVC.title = appRating.title
   }
   
   func addShareApp() {
      homeVC.addChild(shareAppVC)
      homeVC.view.addSubview(shareAppVC.view)
      shareAppVC.view.frame = view.frame
      shareAppVC.didMove(toParent: homeVC)
      homeVC.title = shareAppVC.title
   }
   
   func addSettings() {
      homeVC.addChild(settingsVC)
      homeVC.view.addSubview(settingsVC.view)
      settingsVC.view.frame = view.frame
      settingsVC.didMove(toParent: homeVC)
      homeVC.title = settingsVC.title
   }
}
