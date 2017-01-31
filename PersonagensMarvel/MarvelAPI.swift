//
//  MarvelAPI.swift
//  PersonagensMarvel
//
//  Created by Larissa Gonçalves on 30/01/17.
//  Copyright © 2017 LarissaYasin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import CryptoSwift


class MarvelApi {
    let apiKey = "711fd2dbd94286bae7545a691a06c9d3"
    let privateKey = "07af905761fee2b0a1221806e46e3265c5f93631"
    let ts =  Date().description
    let imageSize = "standard_xlarge"
    let endPoint = "http://gateway.marvel.com/"
    let charactersAPI = "v1/public/characters"
    
    func buscarPesonagens(busca : String) -> [Personagem]{
      //  let json: JSON = ["nameStartsWith":busca, "ts": ts, "apikey":apiKey, "hash": (ts + privateKey + apiKey).md5()]
        let url = endPoint + charactersAPI + "?nameStartsWith=" + busca + "&ts=" + ts + "&apikey=" + apiKey + "&hash=" + (ts + privateKey + apiKey).md5()
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
        
        return [Personagem]()
    }
    
    func buscarImagemPersonagem(urlImg : String, imgView : UIImageView){
        let imageView = imgView
        let url = URL(string: urlImg)!
        let placeholderImage = UIImage(named: "placeholder")!
        
        imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }

}
