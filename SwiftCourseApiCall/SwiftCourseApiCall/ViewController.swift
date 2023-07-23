//
//  ViewController.swift
//  SwiftCourseApiCall
//
//  Created by Sainath Bamen on 03/07/23.
//

import UIKit

class ViewController: UIViewController {
    var newsData = [Article]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ParsingJSON { data in
            self.newsData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func ParsingJSON(completion: @escaping ([Article]) -> ()){
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2022-02-21&to=2022-02-21&sortBy=popularity&apiKey=e6560d9f78c940c48c008ae2d781f41c"
        let url = URL(string: urlString)
        guard url != nil else{
            print("error")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            // checking errors
            if error == nil, data != nil{
                // parsing JSON file
                let decoder = JSONDecoder()
                do{
                    let ParsingData = try decoder.decode(NewsApi.self, from: data!)
                    // closure calling
                    completion(ParsingData.articles)
                    
                }
                catch{
                    print("Parsing error")
                }
            }
            
        }
        dataTask.resume()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = newsData[indexPath.row].author
        return cell
    }
    
    
    
}

