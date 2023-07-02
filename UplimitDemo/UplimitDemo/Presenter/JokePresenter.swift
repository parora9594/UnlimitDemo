//
//  JokePresenter.swift
//  UplimitDemo
//
//  Created by puneet arora on 02/07/23.
//

import Foundation

class JokePresenter: JokeModelDelegate {
    func didFetchJokes(_ joke: [String]) {
        DispatchQueue.main.async {
            self.view?.displayJokes(joke)
        }
    }
    
    weak var view: ViewController?
    let model: JokeModel
    
    init(model: JokeModel) {
        self.model = model
        self.model.delegate = self
    }
    
    func fetchJokes() {
        model.startFetchingJokes()
    }

    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.view?.displayError(error.localizedDescription)
        }
    }
}

