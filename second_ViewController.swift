//
//  second_ViewController.swift
//  coredata_show
//
//  Created by iroid on 17/05/22.
//  Copyright © 2022 iroid. All rights reserved.
//

import UIKit

class second_ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableviw: UITableView!
    var cityarray:[Citylib] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celll = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let onrecord = cityarray[indexPath.row]
        celll.textLabel?.text = onrecord.cityname! + onrecord.citylang! + onrecord.citycolor!
        return celll
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared
            .delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete
        {
            let city = cityarray[indexPath.row]
            context.delete(city)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                cityarray = try context.fetch(Citylib.fetchRequest())
            }
            catch
            {
                print("error")
            }
        }
        tableView.reloadData()
        }
    func fetchdata()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do
        {
            cityarray = try context.fetch(Citylib.fetchRequest())
            
        }
        catch{
            print("error")
            
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableviw.delegate = self
        tableviw.dataSource = self
        self.fetchdata()
        self.tableviw.reloadData()
    }
    


}
