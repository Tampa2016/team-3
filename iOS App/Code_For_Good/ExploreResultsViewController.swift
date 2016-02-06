//
//  ExploreResultsViewController.swift
//  Code_For_Good
//
//  Created by Nicholas Miller on 2/5/16.
//  Copyright © 2016 team3. All rights reserved.
//

import UIKit

class ExploreResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    var filteredData: [Business]?
    
    var mySearch: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        callYelpAPI(mySearch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callYelpAPI(input: String) {
        Business.searchWithTerm(input, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredData = businesses
            self.tableView.reloadData()
        })
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(input, forKey: "storedSearch")
        defaults.synchronize()
        
        /* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
        self.businesses = businesses
        
        for business in businesses {
        print(business.name!)
        print(business.address!)
        }
        }
        */
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return filteredData!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExploreResultsTableViewCell", forIndexPath: indexPath) as! ExploreResultsTableViewCell
        
        cell.business = filteredData![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredData = businesses
        self.tableView.reloadData()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //let resultPredicate = NSPredicate(format: "name contains[c] %@", searchText)
        filteredData = searchText.isEmpty ? businesses : businesses!.filter {
            $0.name!.containsString(searchText)
        }
    
        tableView.reloadData()
    }

}
