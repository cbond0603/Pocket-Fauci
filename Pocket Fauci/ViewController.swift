//
//  ViewController.swift
//  Pocket Fauci
//
//  Created by Chris Bond on 4/16/22.
//

import UIKit

class ViewController: UIViewController {
    
    var coronaData = CoronaData()
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        tableView.delegate = self
        tableView.dataSource = self
        
        coronaData.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coronaData.stateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(coronaData.stateArray[indexPath.row].state)"
        cell.detailTextLabel?.text = "\(coronaData.stateArray[indexPath.row].positive)"
        return cell
    }
}
