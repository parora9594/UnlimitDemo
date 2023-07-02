//
//  JokeModel.swift
//  UplimitDemo
//
//  Created by puneet arora on 02/07/23.
//

import Foundation

protocol JokeModelDelegate: AnyObject {
    func didFetchJokes(_ joke: [String])
    func didFailWithError(_ error: Error)
}

struct JokeResponse: Codable {
    let joke: String
}

var jokes: [String] = []
var timer: Timer?

struct Joke {
    let text: String
}
class JokeModel {
    weak var delegate: JokeModelDelegate?
    
    
    func startFetchingJokes() {
            fetchJokes()
            
            // Starting the timer to fetch jokes every minute
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(fetchJokes), userInfo: nil, repeats: true)
        }
    
    
    
    @objc func fetchJokes() {
        let url = URL(string: "https://geek-jokes.sameerkumar.website/api")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error)
                return
            }
            jokes = UserDefaults.standard.value(forKey: "jokeArray") as! [String]
            if let data = data {
                do {
                    if let joke = String(data: data, encoding: .utf8) {
                        self.updateJokeArray(joke)
                        let jokeArray: [String] = UserDefaults.standard.value(forKey: "jokeArray") as! [String]
                        self.delegate?.didFetchJokes(jokeArray)
                        return
                    }
                }
            }
            
            let unknownError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
            self.delegate?.didFailWithError(unknownError)
        }
        
        task.resume()
    }
    
    func updateJokeArray(_ newJoke:String)
    {
        jokes.append(newJoke)
        if jokes.count > 10 {
            jokes.removeFirst()
        }
        UserDefaults.standard.set(jokes, forKey: "jokeArray")
        UserDefaults.standard.synchronize()
    }
    
}

