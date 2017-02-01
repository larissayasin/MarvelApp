//
//  PersonagemViewController.swift
//  PersonagensMarvel
//
//  Created by Larissa Gonçalves on 01/02/17.
//  Copyright © 2017 LarissaYasin. All rights reserved.
//

import UIKit
import AlamofireImage


class PersonagemViewController: UIViewController {

    var personagem : Personagem!
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var publicacoes: UILabel!
    @IBOutlet weak var hqs: UILabel!
    
    @IBOutlet weak var header: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.header.backgroundColor = UIColor(patternImage: UIImage(named: "comics")!)

        
        let url = URL(string: personagem.imagem!)
        //    let placeholderImage = UIImage(named: "placeholder")!
        
        imagem.af_setImage(withURL: url!)

        nome.text = personagem.nome
        publicacoes.text = String(personagem.publicacoes ?? 0)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
