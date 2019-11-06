//
//  APIclient.swift
//  shakeGesture_Practice
//
//  Created by Javier Porras jr on 11/6/19.
//  Copyright © 2019 Javier Porras jr. All rights reserved.
//


import UIKit

class APIclient {
    fileprivate let baseURL = "http://www.javierporrasjr.com/pokemon/pokemon.json"
    
    func fetchPokemon(completion: @escaping ([Pokemon])->()){
        guard let url = URL(string: baseURL) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            var pokemonArray = [Pokemon]()
            do {
                if let data = data, let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]{
                    
                    for result in json{
                        if let dictionary = result as? [String : AnyObject]{
                            let pokemon = Pokemon(dictionary: dictionary)
                            guard let imageURL = pokemon.imageURL else {return}
                            self.fetchImage(urlString: imageURL, completion: { (image) in
                                pokemon.image = image
                                pokemonArray.append(pokemon)
                                completion(pokemonArray)
                                
                            })
                        }
                    }
                }
            }catch let JSONerror{
                print(JSONerror)
            }
            }.resume()
    }//End Of Fetch Pokemon method
    private func fetchImage(urlString: String, completion: @escaping (UIImage)->()){
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            completion(image)
            }.resume()
    }//End of fetch image method
}//End of APIclient

