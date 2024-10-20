//
//  SepetHucre.swift
//  BTKproje
//
//  Created by semih bekdaş on 19.10.2024.
//

import UIKit

class SepetHucre: UITableViewCell {

    
    
    @IBOutlet weak var urunİmage: UIImageView!
    
    @IBOutlet weak var labelMarka: UILabel!
    
    @IBOutlet weak var labelUrunAd: UILabel!
    
    @IBOutlet weak var labelFiyat: UILabel!
    
    @IBOutlet weak var labelAdet: UILabel!
    
    @IBOutlet weak var buttonsil: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    var silButonAction: (() -> Void)?
    @IBAction func buttonSil(_ sender: Any) {
        
        silButonAction?()

        
    }
}
