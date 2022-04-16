//
//  CoronaData.swift
//  Pocket Fauci
//
//  Created by Chris Bond on 4/16/22.
//

import Foundation

class CoronaData {
// Dont need once stateData struct is codable
//    struct Returned: Codable {
//        var state: String
//        var positive: Int
//    }
    
    var stateArray: [StateData] = []
    var urlString = "https://api.covidtracking.com/v1/states/current.json"
    
    func getData(completed: @escaping () -> ()) {
        print("🕸URL: \(urlString)")
        
        // Create URL
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create Url from \(urlString)")
            completed()
            return
        }
        //Create Session
        let session = URLSession.shared
        
        
        // Get data with .dataTask method (with,completionHandler, Error)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            // deal with the data
            do {
                self.stateArray = try JSONDecoder().decode([StateData].self, from: data!)
//                print("*** returned = \(returned)")
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}

