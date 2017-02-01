//
//  MarvelAPI.swift
//  PersonagensMarvel
//
//  Created by Larissa Gonçalves on 30/01/17.
//  Copyright © 2017 LarissaYasin. All rights reserved.
//

import Foundation
import AlamofireImage
import CryptoSwift


class MarvelApi {
    let apiKey = "711fd2dbd94286bae7545a691a06c9d3"
    let privateKey = "07af905761fee2b0a1221806e46e3265c5f93631"
    var ts : String = ""
    let imageStandardSize = "/standard_xlarge."
    let imagePortraitSize = "/portrait_xlarge."
    let endPoint = "https://gateway.marvel.com/"
    let charactersAPI = "v1/public/characters"
    let comicsAPI = "/comics"
    
    func buscarURL(busca : String) -> String{
        ts =  "\(NSDate().timeIntervalSince1970 * 1000)"
      //  let json: JSON = ["nameStartsWith":busca, "ts": ts, "apikey":apiKey, "hash": (ts + privateKey + apiKey).md5()]
        let url = endPoint + charactersAPI + "?nameStartsWith=" + busca + "&ts=" + ts + "&apikey=" + apiKey + "&hash=" + (ts + privateKey + apiKey).md5()
        return url
    }
    
    func buscarHqsURL(idPersonagem: Int) -> String{
        ts =  "\(NSDate().timeIntervalSince1970 * 1000)"
        let url = endPoint + charactersAPI + "/" + String(idPersonagem) + comicsAPI + "?ts=" + ts + "&apikey=" + apiKey + "&hash=" + (ts + privateKey + apiKey).md5()
        return url
    }
    
    func buscarImagemPersonagem(urlImg : String, imgView : UIImageView) -> UIImageView{
        let imageView = imgView
        let url = URL(string: urlImg)!
    //    let placeholderImage = UIImage(named: "placeholder")!
        
        imageView.af_setImage(withURL: url)
        return imageView
    }

}
