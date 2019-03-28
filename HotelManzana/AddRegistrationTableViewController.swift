//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Eliana Boado on 3/7/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//

import UIKit;

class AddRegistrationTableViewController: UITableViewController, //p. 690
    SelectRoomTypeTableViewControllerDelegate {                  //p. 710
    
    var registration: Registration? {   //p. 715
        guard let roomType: RoomType = roomType else {
            return nil;
        }
        
        let firstName: String = firstNameTextField.text ?? "";
        let lastName: String = lastNameTextField.text ?? "";
        let email: String = emailTextField.text ?? "";
        let checkInDate: Date = checkInDatePicker.date;
        let checkOutDate: Date = checkOutDatePicker.date;
        let numberOfAdults: Int = Int(numberOfAdultsStepper.value);
        let numberOfChildren: Int = Int(numberOfChildrenStepper.value);
        let hasWifi: Bool = wifiSwitch.isOn;
        
        return Registration(
            firstName: firstName,
            lastName: lastName,
            emailAddress: email,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            numberOfAdults: numberOfAdults,
            numberOfChildren: numberOfChildren,
            roomType: roomType,
            hasWifi: hasWifi);
    }

    var roomType: RoomType?;   //p. 710
    
    let checkInDatePickerCellIndexPath: IndexPath = IndexPath(row: 1, section: 1);   //p. 697
    let checkOutDatePickerCellIndexPath: IndexPath = IndexPath(row: 3, section: 1);

    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown;
        }
    }

    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown;
        }
    }

    @IBOutlet weak var firstNameTextField: UITextField!;   //p. 691
    @IBOutlet weak var lastNameTextField: UITextField!;
    @IBOutlet weak var emailTextField: UITextField!;
    
    @IBOutlet weak var checkInDateLabel: UILabel!;   //p. 694
    @IBOutlet weak var checkInDatePicker: UIDatePicker!;
    @IBOutlet weak var checkOutDateLabel: UILabel!;
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!;
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!;   //p. 702
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!;
    @IBOutlet weak var numberOfChildrenLabel: UILabel!;
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!;
    
    @IBOutlet weak var wifiSwitch: UISwitch!;   //p. 704
    @IBOutlet weak var roomTypeLabel: UILabel!;   //p. 710
    
    override func viewDidLoad() {
        super.viewDidLoad();
        print("viewDidLoad");
        
        let midnightToday: Date = Calendar.current.startOfDay(for: Date());   //p. 695
        checkInDatePicker.minimumDate = midnightToday;
        checkInDatePicker.date = midnightToday;

        updateDateViews();      //p. 696
        updateNumberOfGuests(); //p. 703
        updateRoomType();       //p. 711

       
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews();   //p. 696
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {   //p. 703
        updateNumberOfGuests();
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {   //p. 705
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {   //p. 721
        dismiss(animated: true, completion: nil);
    }
    
    // MARK: - Update methods
    
    func updateDateViews() {   //p. 694
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24);   //p. 695

        let dateFormatter: DateFormatter = DateFormatter();   //p. 695
        dateFormatter.dateStyle = .medium;

        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date);
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date);
    }
    
    func updateNumberOfGuests() {   //p. 703
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))";
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))";
    }
    
    func updateRoomType() {   //pp. 710-711
        if let roomType: RoomType = roomType {
            roomTypeLabel.text = roomType.name;
        } else {
            roomTypeLabel.text = "Not Set";
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {   //p. 712
        guard segue.identifier == "SelectRoomType" else {
            return;
        }
        
        // Get the new view controller using segue.destination.
        
        guard let destinationViewController: SelectRoomTypeTableViewController = segue.destination as? SelectRoomTypeTableViewController else {
            return;
        }
        
        // Pass the selected object to the new view controller.

        destinationViewController.delegate = self;
        destinationViewController.roomType = roomType;
    }
    
    // MARK: - UITableViewDelegate
    // p. 697
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {   //p. 698

        case checkInDatePickerCellIndexPath:
            return isCheckInDatePickerShown ? 216.0 : 0.0;

        case checkOutDatePickerCellIndexPath:
            return isCheckOutDatePickerShown ? 216.0 : 0.0;

        default:
            return 44.0;
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);   //p. 700
        
        switch (indexPath.section, indexPath.row) {
    
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            isCheckInDatePickerShown = !isCheckInDatePickerShown;
            isCheckOutDatePickerShown = false;
            tableView.performBatchUpdates(nil);
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            isCheckOutDatePickerShown = !isCheckOutDatePickerShown;
            isCheckInDatePickerShown = false;
            tableView.performBatchUpdates(nil);
            
        default:
            break
        }
    }
    
    // MARK: - SelectRoomTypeTableViewControllerDelegate
    
    func didSelect(roomType: RoomType) {   //p. 711
        self.roomType = roomType;
        updateRoomType();
    }

}
