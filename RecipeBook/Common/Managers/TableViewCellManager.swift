//
//  TableViewCellManager.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//

import UIKit

// MARK: - TableViewCellManager

struct TableViewCellManager {
    static func registerCell<CellType: UITableViewCell>(
        _ type: CellType.Type,
        tableView: UITableView
    ) {
        tableView.register(type.self, forCellReuseIdentifier: type.className)
    }
    
    static func dequeueCell<CellType: UITableViewCell>(
        _ type: CellType.Type,
        tableView: UITableView,
        for indexPath: IndexPath
    ) -> CellType {
        tableView.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! CellType
    }
}
