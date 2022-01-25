//
//  ViewController.swift
//  xxx
//
//  Created by Burak Pala on 25.01.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var launches = [LaunchStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = launches[indexPath.row].mission_name?.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LaunchViewController{
            destination.launch = launches[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()){
         let url = URL(string: "https://api.spacexdata.com/v2/launches")
        URLSession.shared.dataTask(with: url!){
            (data, response, error) in
            if error == nil{
                do{
                self.launches = try JSONDecoder().decode([LaunchStats].self, from: data!)
                    
                    DispatchQueue.main.async {
                         completed()
                    }
                }catch{
                    print("JSON Error")
                }
    }


        }.resume()

}
}
