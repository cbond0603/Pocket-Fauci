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
                self.navigationItem.title = "US States and Territories"
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        destination.stateData = coronaData.stateArray[selectedIndexPath.row]
    }
    
    func formatNumberWithCommas(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
        else {return ""}
        return "\(formattedNumber)"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coronaData.stateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(coronaData.stateArray[indexPath.row].state)"
        cell.detailTextLabel?.text = formatNumberWithCommas(number: coronaData.stateArray[indexPath.row].positive)
        return cell
    }
}
