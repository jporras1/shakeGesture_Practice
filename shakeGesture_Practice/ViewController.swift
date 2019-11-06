//
//  ViewController.swift
//  shakeGesture_Practice
//
//  Created by Javier Porras jr on 11/6/19.
//  Copyright © 2019 Javier Porras jr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let client = APIclient()
    var pokemon = [Pokemon]()
    
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(label)
        view.addSubview(imageView)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90).isActive = true //(equalTo: view.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 350).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        client.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.imageView.image = pokemon.first?.image
                self.label.text = pokemon.first?.name
            }
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(printPokemonCount))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc
    func printPokemonCount(){
//        print(pokemon.count)
        let randomNumb = Int.random(in: 0...pokemon.count)
        imageView.image = pokemon[randomNumb].image
        label.text = pokemon[randomNumb].name
        print(randomNumb)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        self.printPokemonCount()
    }

}
