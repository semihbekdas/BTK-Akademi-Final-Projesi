//
//  KayitOl.swift
//  BTKproje
//
//  Created by semih bekdaş on 18.10.2024.
//

import UIKit

class KayitOl: UIViewController {
    
    
    @IBOutlet weak var tFAd: UITextField!
    
    @IBOutlet weak var tFmail: UITextField!
    
    @IBOutlet weak var tFSifre: UITextField!
    
    
    @IBOutlet weak var tFAdres: UITextField!
    
    var kayitOlViewModel = KayitOlViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognizer)

    }
    
    @objc func klavyeyiKapat(){
        view.endEditing(true)
    }

    @IBAction func buttonKayitOl(_ sender: Any) {
        
        guard let ad = tFAd.text, !ad.isEmpty,
                      let mail = tFmail.text, !mail.isEmpty,
                      let sifre = tFSifre.text, !sifre.isEmpty,
                      let adres = tFAdres.text, !adres.isEmpty else {
                    // Uyarı mesajı göster
                    showAlert("Lütfen tüm alanları doldurun.")
                    return
                }
                
                if kayitOlViewModel.kullaniciKaydet(ad: ad, mail: mail, sifre: sifre, adres: adres) {
                    // Kayıt başarılı, ana sayfaya yönlendir
                    showAlert("Kayıt başarılı! Giriş sayfasından bilgilerinizi girerek giriş yapabilirsiniz.")
                    // Ana sayfaya yönlendirme yapabilirsiniz.
                    // performSegue(withIdentifier: "toAnasayfa", sender: nil)
                } else {
                    // Kayıt başarısız, uyarı mesajı göster
                    showAlert("Bu e-posta veya isim zaten kullanılmış!")
                }
        
        
        
    }
    private func showAlert(_ message: String) {
           let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Tamam", style: .default))
           present(alert, animated: true)
       }
    

}
