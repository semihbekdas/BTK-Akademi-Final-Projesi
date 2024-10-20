//
//  SepetDetay.swift
//  BTKproje
//
//  Created by semih bekdaş on 19.10.2024.
//

import UIKit
import Kingfisher

class SepetDetay: UIViewController {

    
    
    @IBOutlet weak var sepetTableView: UITableView!
    
    
    @IBOutlet weak var labelToplamFiyat: UILabel!
    
    
    var toplamFiyat = 0
    
    var sepetListesi = [Sepet]()
    

    var sepetDetayViewModel = SepetDetayViewModel()
    
    var acikKullanici = Kullanici()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        sepetTableView.dataSource = self
        sepetTableView.delegate = self
        
        acikKullanici = sepetDetayViewModel.acikKullanici!
        
        _ = sepetDetayViewModel.sepettekilerListesi.subscribe(onNext: { liste in
            self.sepetListesi = liste
            DispatchQueue.main.async {
                self.sepetTableView.reloadData()
                self.toplamFiyatGuncelle()
                self.badgeGuncelle()
            }
        })
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        sepetDetayViewModel.sepettenUrunGetir(kullaniciAdi: acikKullanici.ad!)

    }
    
    @IBAction func sepetOnay(_ sender: Any) {
        
        if sepetListesi.count>0
            
        {
            
            let alert = UIAlertController(title: "Başarılı", message: "Sipariş onaylandı", preferredStyle: .alert)
              
              let tamamAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
              alert.addAction(tamamAction)
              
              self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Uyarı", message: "Sepet boş", preferredStyle: .alert)
                 let tamamAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                 alert.addAction(tamamAction)
                 self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func badgeGuncelle(){
        if let tabItems = tabBarController?.tabBar.items {
            let sepetItem = tabItems[1]
            
            sepetItem.badgeValue = "\(sepetListesi.count)"
        }
    }
    
    
    func toplamFiyatGuncelle() {
            toplamFiyat = sepetListesi.reduce(0) { $0 + ($1.fiyat! * $1.siparisAdeti!) }
            labelToplamFiyat.text = "\(toplamFiyat)₺"
        }
    
    

}

extension SepetDetay: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        sepetListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "sepetHucre") as! SepetHucre
        
        let urun = sepetListesi[indexPath.row]
            
        hucre.labelUrunAd.text = urun.ad
        hucre.labelFiyat.text = "\(urun.fiyat!)₺"
        hucre.labelMarka.text = urun.marka
        hucre.labelAdet.text = "\(urun.siparisAdeti!)"
        if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(urun.resim!)") {
            
            DispatchQueue.main.async{
                hucre.urunİmage.kf.setImage(with: url)
            
            }
            
        }
        
        
        hucre.silButonAction = {
            hucre.buttonsil.isEnabled = false

            self.sepetDetayViewModel.sil(sepetId: urun.sepetId!, kullaniciAdi: self.acikKullanici.ad!)
            
            self.sepetListesi.remove(at: indexPath.row) // Veri kaynağından kaldır
            tableView.deleteRows(at: [indexPath], with: .automatic)

            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
           
            hucre.buttonsil.isEnabled = true
        }
            self.toplamFiyatGuncelle()
            self.badgeGuncelle()

            
    }

        
        
        return hucre
    }
}
