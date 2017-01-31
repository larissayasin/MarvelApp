//
//  PersonagemTableViewCell.swift
//  PersonagensMarvel
//
//  Created by Larissa Gonçalves on 30/01/17.
//  Copyright © 2017 LarissaYasin. All rights reserved.
//

import UIKit

class PersonagemTableViewCell: UITableViewCell {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var publicacoes: UILabel!
    @IBOutlet weak var nome: UILabel!

    override func awakeFromNib() {
                super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
