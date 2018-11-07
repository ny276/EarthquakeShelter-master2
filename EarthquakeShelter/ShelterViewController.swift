//
//  ShelterViewController.swift
//  EarthquakeShelter
//
//  Created by D7703_18 on 2018. 11. 5..
//  Copyright © 2018년 201550057. All rights reserved.
//

import UIKit

class ShelterViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    
    var item:[String:String] = [:]  // item[key] => value
    var elements:[[String:String]] = []
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        if let path = Bundle.main.url(forResource: "Shelter", withExtension: "xml") {
            //print(path)
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                
                if parser.parse() {
                    print("parse succeed!")
                    print(elements)
                } else {
                    print("parse failed!")
                }
            }
        } else {
            print("xml file not found")
        }
        
        //        let strURL = "http://api.androidhive.info/pizza/?format=xml"
        //
        //        if NSURL(string: strURL) != nil {
        //            if let parser = XMLParser(contentsOf: NSURL(string: strURL)! as URL) {
        //                parser.delegate = self
        //
        //                if parser.parse() {
        //                    print("parsing success")
        //                    print(elements)
        //                } else {
        //                    print("parsing fail")
        //                }
        //
        //            }
        //        }
    }
    
    // UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        
        let myItem = elements[indexPath.row]
        
        let vt_acmdfclty_nm = cell.viewWithTag(1) as! UILabel
        let dtl_adres = cell.viewWithTag(2) as! UILabel
        
        vt_acmdfclty_nm.text = myItem["vt_acmdfclty_nm"]
        dtl_adres.text = myItem["dtl_adres"]
        
        return cell
    }
    
    // XMLParseDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        print("currentElement = \(elementName)")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print("data = \(data)")
        if !data.isEmpty {
            item[currentElement] = data
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "row" {
            elements.append(item)
        }
    }
}
