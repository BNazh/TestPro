//
//  ViewController.swift
//  TestPro
//
//  Created by Nazhmeddin Babakhanov on 21.08.2020.
//  Copyright © 2020 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

struct Item {
    let title: String
    let price: Int
}

class ViewController: UITableViewController {
    
    var items = [Item(title: "Item 1", price: 100), Item(title: "Item 2", price: 200), Item(title: "Item 3", price: 90), Item(title: "Item 4", price: 0), Item(title: "Item 5", price: 0), Item(title: "Item 6", price: 300), Item(title: "Item 7", price: 100)]
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.didPress = { [weak self] in
            if view.bool{
                self?.items = self!.items.sorted(by: { (item1: Item, item2: Item) -> Bool in
                    return item1.price > item2.price
                })
            }else{
                self?.items = self!.items.sorted(by: { (item1: Item, item2: Item) -> Bool in
                    return item1.price < item2.price
                })
                self?.tableView.reloadData()
            }
            
            self?.tableView.reloadData()
        }
        return view
    }()
    
    private var searchController: UISearchController?
    private let resultViewController = SearchResultsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        cell?.textLabel?.text = items[indexPath.row].title
        cell?.detailTextLabel?.text = "$\(items[indexPath.row].price)"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(text: "\(items[indexPath.row].title) $\(items[indexPath.row].price)")
    }
}

extension ViewController: UISearchControllerDelegate{
    private func setupViews() -> Void {
        setupSearchController()
        tableView.tableHeaderView = headerView
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
    }

    private func setupSearchController() -> Void {
        resultViewController.deflist = items
        resultViewController.delegate = self
        searchController = UISearchController(searchResultsController: resultViewController)
        searchController?.searchResultsUpdater = resultViewController
        searchController?.delegate = self
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.placeholder = "Поиск"
        definesPresentationContext = true
        searchTextFieldAttributes()
        cancelButtonAttributes()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func searchTextFieldAttributes() -> Void {
        if let textfield = searchController?.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
    }


    private func cancelButtonAttributes() -> Void {
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "отмена"
    }

}

extension ViewController: SearchOneItemPressed{
    func didSelect(text: String) {
        let vc = UIViewController()
        vc.title = text
        vc.view.backgroundColor = UIColor.darkGray
        navigationController?.pushViewController(vc, animated: true)
    }
}
