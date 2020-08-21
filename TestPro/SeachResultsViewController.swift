//
//  SeachResultsViewController.swift
//  TestPro
//
//  Created by Nazhmeddin Babakhanov on 21.08.2020.
//  Copyright © 2020 Nazhmeddin Babakhanov. All rights reserved.
//


import UIKit

protocol SearchOneItemPressed {
    func didSelect(text: String)
}

class SearchResultsViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    var delegate: SearchOneItemPressed?
    var deflist = [Item]()
    var filteredRecommendations = [Item]()


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredRecommendations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "\(filteredRecommendations[indexPath.row].title) $\(filteredRecommendations[indexPath.row].price)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(text: "\(filteredRecommendations[indexPath.row].title) $\(filteredRecommendations[indexPath.row].price)")
    }

    func updateSearchResults(for searchController: UISearchController) {
        self.fetchSearchRecommendations(with: searchController.searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredRecommendations = []
        tableView.reloadData()
    }

}

extension SearchResultsViewController {

    private func fetchSearchRecommendations(with searchedText: String) -> Void {
        
        self.filteredRecommendations = deflist.filter {
            $0.title.lowercased().contains(searchedText.lowercased()) || "\($0.price)".contains(searchedText)
        }

        self.tableView.reloadData()
    }
}
