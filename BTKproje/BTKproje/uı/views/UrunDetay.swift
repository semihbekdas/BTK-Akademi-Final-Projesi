//
//  UrunDetay.swift
//  BTKproje
//
//  Created by semih bekdaş on 19.10.2024.
//

import UIKit
import Kingfisher
import RxSwift

class UrunDetay: UIViewController {

    
    
    @IBOutlet weak var imageviewUrun: UIImageView!
    @IBOutlet weak var labelKategori: UILabel!
    @IBOutlet weak var labelMarka: UILabel!
    @IBOutlet weak var labelUrunad: UILabel!
    @IBOutlet weak var labelFiyat: UILabel!
    @IBOutlet weak var labelPuan: UILabel!
    @IBOutlet weak var labelToplamFiyat: UILabel!
    @IBOutlet weak var labelAdet: UILabel!
    @IBOutlet weak var buttonAdetAzaltt: UIButton!
    
    @IBOutlet weak var imageStars: UIImageView!
    var sepetDetayViewModel = SepetDetayViewModel()
    var urunDetayViewModel = UrunDetayViewModel()
    var urun : UrunlerModel?
    var adet = 0
    var ad = ""//burası silmek ve initin içi spetdety
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        if let u = urun {
            
            labelPuan.text = "\(u.puan)"
            labelFiyat.text = "\(u.fiyat) ₺"
            labelMarka.text = u.marka
            labelUrunad.text = u.ad
            labelKategori.text = u.kategori
            labelAdet.text = "\(adet)"
            if u.puan > 4.5{
                imageStars.image = UIImage(named: "fivestars")
                
            }else if u.puan > 4.0{
                imageStars.image = UIImage(named: "fourandhalfstars")

                
            }else if u.puan > 3.5{
                imageStars.image = UIImage(named: "fourstarss")

            }else{
                imageStars.image = UIImage(named: "threeandhalfstars")

            }
            if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(u.resim!)") {
                imageviewUrun.kf.setImage(with: url)
            }
            
            
            
        }
        
        buttonAdetAzaltt.isHidden = adet == 0
        
        checkSepettekiUrun()

        
    }
    
    private func checkSepettekiUrun() {
        sepetDetayViewModel.sepettekilerListesi.subscribe(onNext: { [weak self] sepettekiler in
            guard let self = self else { return }
            if let mevcutUrun = sepettekiler.first(where: { $0.ad == self.urun?.ad }) {
                // Ürün sepette varsa, adetini güncelle
                self.adet = mevcutUrun.siparisAdeti ?? 0
                self.labelAdet.text = String(self.adet)
                self.toplamFiyatGuncelle()
            }
        }).disposed(by: disposeBag) // disposeBag ile yönettik
    }

    
    
    
    @IBAction func buttonAdetAzalt(_ sender: Any) {
        if adet > 1 {
               adet -= 1
               labelAdet.text = "\(adet)"
               toplamFiyatGuncelle() // Toplam fiyatı güncelle
           }
    }
    
    @IBAction func buttonAdetArttir(_ sender: Any) {
        
            adet += 1
            labelAdet.text = "\(adet)"
            toplamFiyatGuncelle() // Toplam fiyatı güncelle
            buttonAdetAzaltt.isHidden = adet == 0

    }
    
    
    @IBAction func buttonSepeteekle(_ sender: Any) {
        
        
        
           if adet > 0 {
               
               if let kullanici = urunDetayViewModel.acikKullanici {
                   
                   ad = kullanici.ad!
                   
               }
               
               
               urunDetayViewModel.sepeteUrunEkle(ad: urun!.ad!, resim: urun!.resim!, kategori: urun!.kategori!, fiyat: Int(urun!.fiyat), marka: urun!.marka!, siparisAdeti: adet, kullaniciAdi: ad)
               print("Ürün sepete eklendi: \(urun!.ad!) - Adet: \(adet)")
           } else {
               // Adet 0 olduğunda uyarı göster
               let alert = UIAlertController(title: "Uyarı", message: "Ürünü sepete eklemek için adet 0'dan büyük olmalıdır.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
        
        
        
    }
    
    @IBAction func buttongeri(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    func toplamFiyatGuncelle() {
        let fiyat = urun?.fiyat ?? 0 // Eğer urun nil ise fiyat 0 olacak
        let adet = Int32(adet) // Adeti Int32'ye dönüştürüyoruz
        
        let toplamFiyat = fiyat * adet // Toplam fiyat hesaplanıyor
        labelToplamFiyat.text = "\(toplamFiyat)₺" // Sonuç etiketine yazılıyor
    }

    
}
