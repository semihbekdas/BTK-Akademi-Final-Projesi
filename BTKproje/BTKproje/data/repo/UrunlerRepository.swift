//
//  UrunlerRepository.swift
//  BTKproje
//
//  Created by semih bekdaş on 18.10.2024.
//

import Foundation
import RxSwift
import Alamofire

class UrunlerRepository {
    
    let context = appDelegate.persistentContainer.viewContext

    
    var urunlerListesi = BehaviorSubject<[UrunlerModel]>(value: [UrunlerModel]())
    
    

    
        //gelen kategoriye göre ekrana gösterme
    
    //sıralamada fiyata göre art az- yılıdza göre art az -ve default olcak
    
    
    
    /*func urunleriGoster(){
        urunleriYukle() // ilk çalıştığında veriler gelsin diye çalıştırıcaz
        do {
            let fr = UrunlerModel.fetchRequest()
            let urunler = try context.fetch(fr)
            urunlerListesi.onNext(urunler)
        }catch{
            print(error.localizedDescription)
        }
    }*/
    private var verilerYuklendiMi = false

    func urunleriGoster() {
        let fr = UrunlerModel.fetchRequest()
        do {
            let urunSayisi = try context.count(for: fr)
            if urunSayisi == 0 && !verilerYuklendiMi{
                // Eğer veritabanında hiç ürün yoksa verileri yükle
                urunleriYukle()
            }
            let urunler = try context.fetch(fr)
            urunlerListesi.onNext(urunler)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func ara(aramaKelimesi:String){
        do {
            let fr = UrunlerModel.fetchRequest()
            fr.predicate = NSPredicate(format: "ad CONTAINS[c] %@", aramaKelimesi)
            let liste = try context.fetch(fr)
            urunlerListesi.onNext(liste)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func kategoriSec(kategori:String){
        do {
            let fr = UrunlerModel.fetchRequest()
            fr.predicate = NSPredicate(format: "kategori CONTAINS[c] %@", kategori)
            let liste = try context.fetch(fr)
            urunlerListesi.onNext(liste)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func puanSirala(puanArtan: Bool) {
        //true gelirsw artan
        do {
            let fr = UrunlerModel.fetchRequest()
            let urunler = try context.fetch(fr)
            
            // Kullanıcının sıralama tercihlerine göre ürünleri sırala
            let siralanmisUrunler: [UrunlerModel]
            if puanArtan {
                siralanmisUrunler = urunler.sorted { $0.puan < $1.puan } // Artan sıralama
            } else {
                siralanmisUrunler = urunler.sorted { $0.puan > $1.puan } // Azalan sıralama
            }
            
            urunlerListesi.onNext(siralanmisUrunler)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fiyatSirala(fiyatArtan: Bool) {
        do {
            let fr = UrunlerModel.fetchRequest()
            let urunler = try context.fetch(fr)
            
            // Kullanıcının sıralama tercihlerine göre ürünleri sırala
            let siralanmisUrunler: [UrunlerModel]
            if fiyatArtan {
                siralanmisUrunler = urunler.sorted { $0.fiyat < $1.fiyat } // Artan sıralama
            } else {
                siralanmisUrunler = urunler.sorted { $0.fiyat > $1.fiyat } // Azalan sıralama
            }
            
            urunlerListesi.onNext(siralanmisUrunler)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
    
    func urunleriYukle(){
        
        let url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php"
        
        AF.request(url,method: .get).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(UrunlerCevap.self, from: data)
                    if let liste = cevap.urunler {
                        self.saveToCoreData(urunler: liste)
                        print("ürünler yüklendi")
                        self.verilerYuklendiMi = true // Veriler yüklendi olarak işaretle

                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func saveToCoreData(urunler: [Urunler]) {
        
        for urun in urunler {
            let yeniUrun = UrunlerModel(context: context)
            yeniUrun.ad = urun.ad
            yeniUrun.adet = 0 // Varsayılan değer
            yeniUrun.fiyat = Int32(urun.fiyat ?? 0) // Eğer nil ise 0 kullan
            yeniUrun.id = Int32(urun.id ?? 0) // Eğer nil ise 0 kullan
            yeniUrun.kategori = urun.kategori
            yeniUrun.marka = urun.marka
            yeniUrun.resim = urun.resim
            yeniUrun.toplamFiyat = 0 // Varsayılan değer
            
            switch urun.id {
                   case 1:
                       yeniUrun.puan = 4.5
                   case 2:
                       yeniUrun.puan = 4.0
                   case 3:
                       yeniUrun.puan = 4.5
                   case 4:
                       yeniUrun.puan = 3.5
                   case 5:
                       yeniUrun.puan = 3.5
                   case 6:
                       yeniUrun.puan = 4.0
                   case 7:
                       yeniUrun.puan = 4.8
                   case 8:
                       yeniUrun.puan = 3.5
                   case 9:
                       yeniUrun.puan = 4.0
                   case 10:
                       yeniUrun.puan = 3.5
                   case 11:
                       yeniUrun.puan = 4.0
                   case 12:
                       yeniUrun.puan = 4.5
                   default:
                       yeniUrun.puan = 0 // Eğer ID tanımlı değilse varsayılan puan
                   }
            
        }

        appDelegate.saveContext()

    }
    
    
    
}
