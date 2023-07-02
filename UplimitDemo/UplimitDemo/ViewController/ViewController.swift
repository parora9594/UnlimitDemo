//
//  ViewController.swift
//  UplimitDemo
//
//  Created by puneet arora on 27/06/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var presenter: JokePresenter!
    var jokes: [String] = []
    @IBOutlet weak var jokeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeTableView.register(CustomeCell.self, forCellReuseIdentifier: "CustomeCell")
        let model = JokeModel()
        presenter = JokePresenter(model: model)
        presenter.view = self

        // Fetch jokes
        presenter.fetchJokes()
        jokeTableView.rowHeight = UITableView.automaticDimension
        jokeTableView.estimatedRowHeight = 100
        jokeTableView.delegate = self
    }

    func displayJokes(_ joke:[String]) {
           self.jokes = joke
        jokeTableView.reloadData()
       }
       
       func displayError(_ error: String) {

           let alertController = UIAlertController(title: "Jokes", message: error, preferredStyle: .alert)
               
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alertController.addAction(okAction)
               
               present(alertController, animated: true, completion: nil)
           print("Error: \(error)")
       }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return jokes.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CustomeCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = jokes[indexPath.row]
           return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let joke = jokes[indexPath.row]
            
            let labelWidth = tableView.bounds.width - 16
            let labelFont = UIFont.systemFont(ofSize: 17)
            
            let labelHeight = (joke as NSString).boundingRect(
                with: CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin],
                attributes: [NSAttributedString.Key.font: labelFont],
                context: nil
            ).height
            
            
            
            return labelHeight + 20
        }
}
