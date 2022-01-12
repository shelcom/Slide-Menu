//
//  MenuViewController.swift
//  Slide Menu
//
//  Created by Serhii on 12.01.2022.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
   func didSelect(menuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController {
   
   weak var delegate: MenuViewControllerDelegate?
   
   enum MenuOptions: String, CaseIterable {
      case home = "Home"
      case info = "Information"
      case appRating = "App Rating"
      case shareApp = "Share App"
      case settings = "Settings"
      
      var imageName: String {
         switch self {
            case .home:
               return "house"
            case .info:
               return "airplane"
            case .appRating:
               return "star"
            case .shareApp:
               return "message"
            case .settings:
               return "gear"
         }
      }
   }
   
   private let tableView: UITableView = {
      let table = UITableView()
      table.backgroundColor = nil
      table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      return table
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      addTableToView()
   }
   
   func addTableToView() {
      view.addSubview(tableView)
      tableView.delegate = self
      tableView.dataSource = self
   }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
      tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return MenuOptions.allCases.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
      cell.textLabel?.textColor = .white
      cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
      cell.imageView?.tintColor = .white
      cell.backgroundColor = .gray
      cell.contentView.backgroundColor = .gray
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      let item = MenuOptions.allCases[indexPath.row]
      delegate?.didSelect(menuItem: item)
   }
}
