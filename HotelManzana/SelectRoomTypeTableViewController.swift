//
//  SelectRoomTypeTableViewController.swift
//  HotelManzana
//
//  Created by Eliana Boado on 3/7/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//

import UIKit;

protocol SelectRoomTypeTableViewControllerDelegate {   //p. 709
    func didSelect(roomType: RoomType);
}

class SelectRoomTypeTableViewController: UITableViewController {   //p. 706
    
    var delegate: SelectRoomTypeTableViewControllerDelegate?; //p. 709
    var roomType: RoomType?;                                  //p. 708

    override func viewDidLoad() {
        super.viewDidLoad();

        // Uncomment the following line to preserve selection between presentations
        // clearsSelectionOnViewWillAppear = false;

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // navigationItem.rightBarButtonItem = editButtonItem;
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;   //p. 707
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count;   //p. 707
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath);

        // Configure the cell...
        let roomType: RoomType = RoomType.all[indexPath.row];   //p. 707
        cell.textLabel?.text = roomType.name;
        cell.detailTextLabel?.text = String(format: "$ %.2f", roomType.price);
        
        if roomType == self.roomType {   //p. 709, call our type method
            cell.accessoryType = .checkmark;
        } else {
            cell.accessoryType = .none;
        }

        return cell;
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true;
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true;
    }
    */
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {   //p. 708
        tableView.deselectRow(at: indexPath, animated: true);   //Remove the gray highlight.
        roomType = RoomType.all[indexPath.row];
        delegate?.didSelect(roomType: roomType!);   //p. 710
        tableView.reloadData();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
