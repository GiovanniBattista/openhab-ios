//  Converted to Swift 4 by Swiftify v4.2.28993 - https://objectivec2swift.com/
//
//  OpenHABSelectionTableViewController.swift
//  openHAB
//
//  Created by Victor Belov on 16/04/14.
//  Copyright (c) 2014 Victor Belov. All rights reserved.
//

import UIKit

@objc protocol OpenHABSelectionTableViewControllerDelegate: NSObjectProtocol {
    func didSelectWidgetMapping(_ selectedMapping: Int)
}

class OpenHABSelectionTableViewController: UITableViewController {
    @objc var mappings: [AnyHashable] = []
    @objc weak var delegate: OpenHABSelectionTableViewControllerDelegate?
    @objc var selectionItem: OpenHABItem?

    override init(style: UITableView.Style) {
        super.init(style: style)
        
        // Custom initialization
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print(String(format: "I have %lu mappings", UInt(mappings.count)))

        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mappings.count
    }

    static let tableViewCellIdentifier = "SelectionCell"

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: OpenHABSelectionTableViewController.tableViewCellIdentifier, for: indexPath)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: OpenHABSelectionTableViewController.tableViewCellIdentifier)
        }
        let mapping = mappings[indexPath.row] as? OpenHABWidgetMapping
        cell.textLabel?.text = mapping?.label
        if (selectionItem?.state == mapping?.command) {
            print("This item is selected")
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(String(format: "Selected mapping %ld", indexPath.row))
        if delegate != nil {
            delegate?.didSelectWidgetMapping(indexPath.row)
        }
        navigationController?.popViewController(animated: true)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
