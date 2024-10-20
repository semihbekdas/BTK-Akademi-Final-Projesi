//
//  Hesabim.swift
//  BTKproje
//
//  Created by semih bekdaş on 18.10.2024.
//

import UIKit

class Hesabim: UIViewController {
    
    
    
    
    @IBOutlet weak var labelAd: UILabel!
    
    @IBOutlet weak var labelMail: UILabel!
    
    @IBOutlet weak var labelAdres: UILabel!
    
    
    var hesabimViewModel = HesabimViewModel()
    
    var acikKullanici = Kullanici()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        
        bilgileriYukle()
        
        

    }
    func bilgileriYukle() {
          if let kullanici = hesabimViewModel.acikKullanici {
              labelAd.text = kullanici.ad
              labelMail.text = kullanici.mail
              labelAdres.text = kullanici.adres
          }
      }
    
    
    
    
    
    @IBAction func buttonCikisYap(_ sender: Any) {
        
        hesabimViewModel.kullaniciCikis()
        //burdan girişyapa atmamız lazım
        
        navigationController?.popToRootViewController(animated: true)
        
        /*if let loginVC = storyboard?.instantiateViewController(withIdentifier: "GirisYap") {
                   loginVC.modalPresentationStyle = .fullScreen
                   
                   // UIWindowScene üzerinden window'a erişim
                   if let scene = view.window?.windowScene {
                       let window = UIWindow(windowScene: scene)
                       window.rootViewController = loginVC
                       window.makeKeyAndVisible()
                   }
               }*/
    }
    
}
