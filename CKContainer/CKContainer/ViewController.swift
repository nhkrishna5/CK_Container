//
//  ViewController.swift
//  CKContainer
//
//  Created by Ramesh Ponnuvel on 07/11/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//https://code.tutsplus.com/tutorials/building-a-shopping-list-application-with-cloudkit-introduction--cms-24674

import UIKit
import CloudKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //fetchUserRecordId()
       saverecords()
    }

    
    func fetchUserRecordId() {
        let defaultContainer = CKContainer.default()
        
        defaultContainer.fetchUserRecordID { (recordID, error) in
            if let resError = error {
                print("resErr:- \(resError)")
            }else if let userRecId = recordID {
                DispatchQueue.main.sync {
                    print("userrecid:- \(userRecId)")
                    self.fetchUserRecords(recID: userRecId)
                }
            }
        }
    }
    
    func fetchUserRecords(recID: CKRecordID) {
        let defaultCenter = CKContainer.default()
        
        let privateData = defaultCenter.privateCloudDatabase
        
        privateData.fetch(withRecordID: recID) { (recoredId, error) in
            if let err = error{
                print("error1:- \(err)")
            }else if let recors = recoredId {
                print("recors:- \(recors)")
            }
        }
        
    }
    
    func fetchQuery() {
        let defaultCenter = CKContainer.default()
        let priDB = defaultCenter.privateCloudDatabase
        let pred = NSPredicate(value: true)
        let query = CKQuery(recordType: "KasponData", predicate: pred)
        priDB.perform(query, inZoneWith: nil) { (ary_record, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                
            }
            else {
                
                for result in ary_record! {
                    print("result:- \(result)")
                }
                
            }
        }
    }
    
    
    func saverecords() {
        let container = CKContainer.default()

        let publicDB = container.privateCloudDatabase
        let userData = CKRecord(recordType: "KasponData")
        userData.setValue("karthick", forKey: "Employees")
        userData.setValue("KT285", forKey: "EmployeesID")
        DispatchQueue.main.async {
            publicDB.save(userData, completionHandler: { (record, error) -> Void in
                 print("saved")
                
            })
        }
    }
    
    @IBAction func fetcData(){
        self.fetchQuery()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

