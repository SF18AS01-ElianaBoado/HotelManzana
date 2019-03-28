//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Eliana Boado on 3/7/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//

import UIKit;

class RegistrationTableViewController: UITableViewController { //p. 716
    
    var registrations: [Registration] = [Registration]();      //p. 717

    override func viewDidLoad() {
        super.viewDidLoad();

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;   //p. 718
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count;   //p. 718
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        // Configure the cell..., p. 719
        let registration: Registration = registrations[indexPath.row];

        let dateFormatter: DateFormatter = DateFormatter();
        dateFormatter.dateStyle = .short;

        cell.textLabel?.text = "\(registration.firstName) \(registration.lastName)";
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate) + ": " + registration.roomType.name;
        return cell;
    }
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {   //pp. 719-720
        
        guard let addRegistrationTableViewController: AddRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
            let registration: Registration = addRegistrationTableViewController.registration else {
                return;
        }
        
        registrations.append(registration);
        tableView.reloadData();
    }
    

}
