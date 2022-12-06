//
//  ViewController.swift
//  coredata_show
//
//  Created by iroid on 17/05/22.
//  Copyright © 2022 iroid. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

   
    @IBOutlet weak var name_txt: UITextField!
    
    @IBOutlet weak var lang_txt: UITextField!
    
    @IBOutlet weak var color_txt: UITextField!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
       }
    
    @IBAction func save_btn(_ sender: Any) {
        
        let newcity = NSEntityDescription.insertNewObject(forEntityName: "Citylib", into: context)
        
        newcity.setValue(self.name_txt.text, forKey: "cityname")
        newcity.setValue(self.color_txt.text, forKey: "citycolor")
        newcity.setValue(self.lang_txt.text, forKey: "citylang")
        
        do{
            try context.save()
            self.color_txt.text = ""
            self.name_txt.text = ""
            self.lang_txt.text = ""
        }
        catch
        {
            print("error")
        }
        
    }
    @IBAction func details_btn(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextviewcontroller = storyboard.instantiateViewController(identifier: "second")as!second_ViewController
        self.navigationController?.pushViewController(nextviewcontroller, animated: true)
    }
    @IBOutlet weak var search_txt: UITextField!
    
    @IBAction func search_btn(_ sender: Any) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Citylib")
        let searchstring = self.search_txt.text
        request.predicate = NSPredicate(format: "cityname == %@",searchstring!)
        var outputstr = ""
        do
        {
            let result = try context.fetch(request)
            if result.count>0
            {
                for oneline in result
                {
                    let onecity = (oneline as AnyObject).value(forKey: "cityname") as! String
                    let onecolour = (oneline as AnyObject).value(forKey: "citycolor")as! String
                    let onelanguage = (oneline as AnyObject).value(forKey: "citylang")as!String
                    name_txt.text = onecity
                    lang_txt.text = onelanguage
                    color_txt.text = onecolour
                }
            }
             else
            {
                outputstr = "no match found"
                
            }
          
        }
        catch
        {
            print("error")
        }
    }
    @IBAction func update_btn(_ sender: Any) {
       let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Citylib")
        let updatestring = self.name_txt.text
        fetchrequest.predicate = NSPredicate(format:"cityname ==%@",updatestring!)
       do
       {
           let result = try context.fetch(fetchrequest)as?[NSManagedObject]
        
        result![0].setValue(name_txt.text , forKey: "cityname" )
        result![0].setValue(color_txt.text, forKey: "citycolor")
        result![0].setValue(lang_txt.text, forKey: "citylang")
        
    }
    catch {
    print("fetch failed:\(error)")
}
    do
    {
    try context.save()
    name_txt.text = ""
    color_txt.text = ""
    lang_txt.text = ""
}
    catch {
    print("saving core data failed: \(error)")
        }}
}

