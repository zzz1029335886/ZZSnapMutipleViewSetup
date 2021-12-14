//
//  TableViewController.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

class TableViewController: UITableViewController {
    let items: [TableListItem] = [
        TableListItem(name: "Equal", controllerClass: EqualViewController.self),
        TableListItem(name: "Vertical", controllerClass: VerticalViewController.self),
        TableListItem(name: "Horizontal", controllerClass: HorizontalViewController.self),
        TableListItem(name: "Flex", controllerClass: FlexViewController.self),
//        TableListItem(name: "Widget", controllerClass: WidgetViewController.self),
        TableListItem(name: "More", controllerClass: MoreViewController.self),
        TableListItem(name: "Scroll", controllerClass: ScrollViewController.self),
        TableListItem(name: "ScrollHorizontal", controllerClass: ScrollHorizontalViewController.self),
        TableListItem(name: "ScrollVertical", controllerClass: ScrollVerticalViewController.self),
//        TableListItem(name: "Between", controllerClass: BetweenViewController.self),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SnapMutipleViewSetup"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let con = item.controllerClass.init()
        con.title = item.name
        navigationController?.pushViewController(con, animated: true)
    }
    
}
