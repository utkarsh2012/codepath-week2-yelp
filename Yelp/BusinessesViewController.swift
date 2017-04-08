//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, FilterViewControllerDelegate {
    
    var businesses: [Business]!
    var filteredBusinesses: [Business]!

    var searchBar: UISearchBar!
    var searchController: UISearchController!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false

        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.filteredBusinesses = businesses
            
            self.tableView.reloadData()
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                }
            }
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredBusinesses != nil {
            return filteredBusinesses!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessCell
        cell.business = filteredBusinesses[indexPath.row]
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredBusinesses = searchText.isEmpty ? businesses : businesses.filter({(business: Business) -> Bool in
                return business.name?.range(of: searchText, options: .caseInsensitive) != nil
            })
            
            tableView.reloadData()
        }
    }
    
     // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filterViewController = navigationController.topViewController as! FilterViewController
        
        filterViewController.delegate = self
    }
    
    func filterViewController(filterViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        let isDeals = filters["deals"] as? Bool
        let sort = filters["sort"] as? Int

        Business.searchWithTerm(term: "Restaurants", sort: YelpSortMode(rawValue: sort!), categories: categories, deals: isDeals) { (businesses: [Business]?, error: Error?) -> Void in
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
        }
    }
    
}
