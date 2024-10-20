//
//  GirisYapView.swift
//  BTKproje
//
//  Created by semih bekdaş on 17.10.2024.
//

import UIKit
import CoreData

class GirisYap: UIViewController {
    
    
    //klavye kapatma eklenicek
    
    @IBOutlet weak var tFmail: UITextField!
    
    
    @IBOutlet weak var tFSifre: UITextField!
    
    var acikKullanici: Kullanici?

    
    var kullanicilarListesi = [Kullanici]()
    var girisYapViewModel = GirisYapViewModel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = girisYapViewModel.kullaniciListe.subscribe(onNext: {
            liste in
            self.kullanicilarListesi=liste
        })
        
        
        if girisYapViewModel.hesapAcikmi() {
            acikKullanici = girisYapViewModel.getAcikKullanici()
            performSegue(withIdentifier: "toAnasayfa", sender: acikKullanici)
           }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognizer)
        
        
        
    }
    
    @objc func klavyeyiKapat(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {

       // girisYapViewModel.kullanicilariYukle()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       /* if segue.identifier == "toAnasayfa" {
            
            if let kullanici = sender as? Kullanici{
                
                let gidilecelVC = segue.destination as! Anasayfa
                gidilecelVC.acikKullanici = kullanici
                
                
            }
            
        }*/
        
        
    }
    

 
    @IBAction func buttonGirisYap(_ sender: Any) {
        guard let mail = tFmail.text, !mail.isEmpty,
                      let sifre = tFSifre.text, !sifre.isEmpty else {
                    // Uyarı mesajı göster
                    showAlert("Lütfen tüm alanları doldurun.")
                    return
                }
                
                if girisYapViewModel.kullaniciGiris(mail: mail, sifre: sifre) {
                    // Giriş başarılı, ana sayfaya yönlendir
                    acikKullanici = girisYapViewModel.getAcikKullanici()
                    performSegue(withIdentifier: "toAnasayfa", sender: acikKullanici )

                } else {
                    // Giriş başarısız, uyarı mesajı göster
                    showAlert("Giriş bilgilerinizi kontrol edin.")
                }
        
        
        
        
    }
    
    //button kayıt ol yapılacak
    
    @IBAction func buttonKayitOl(_ sender: Any) {
        
        performSegue(withIdentifier: "toKayitOl", sender: nil)

    
        //kayıt ol sayfasının viewmodel ve viewini yapalım
    }
    
    
    private func showAlert(_ message: String) {
            let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
        }
    
}
