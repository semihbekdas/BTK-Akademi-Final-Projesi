//
//  SepetApi.swift
//  BTKproje
//
//  Created by semih bekdaş on 19.10.2024.
//

import Foundation
import RxSwift
import Alamofire

class SepetApi{
    
    var sepettekilerListesi = BehaviorSubject<[Sepet]>(value: [Sepet]())

    
    
    
    
    
    func sepettenUrunGetir(kullaniciAdi:String){
        
        let url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php"
        let params : Parameters = ["kullaniciAdi": kullaniciAdi]
        
        AF.request(url, method: .post, parameters: params).response { response in
        
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let liste = cevap.urunler_sepeti {
                        
                        self.sepettekilerListesi.onNext(liste)
                        
                        
                    }

                }catch{
                    print(error.localizedDescription)
                    print("urungetir hata")

                }
            }
        }
        
    }
    
    
    
    
    
    
    
    func sepeteUrunEkle(ad: String, resim: String, kategori: String, fiyat: Int, marka: String, siparisAdeti: Int, kullaniciAdi: String) {
        // Öncelikle sepetteki ürünleri al
        
        urunVarsaSil( kullaniciAdi: kullaniciAdi, UrunAd: ad)
                    
            // Mevcut ürünü silinmiş olsa bile yeni ürünü ekle
            let url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php"
            let params: Parameters = ["ad": ad, "resim": resim, "kategori": kategori, "fiyat": fiyat, "marka": marka, "siparisAdeti": siparisAdeti, "kullaniciAdi": kullaniciAdi]
            
            AF.request(url, method: .post, parameters: params).response { response in
                if let data = response.data {
                    do {
                        let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                        print("BAŞARI:urun eklendi \(cevap.success!)")
                        print("MESAJ:\(cevap.message!)")
                    
                    } catch {
                        print(error.localizedDescription)
                        print("sepeteurunekle hata")
                    }
                }
            }
            
    }
    
    
    
    
    
    
    
    
    
    
    
    func urunVarsaSil (kullaniciAdi:String,UrunAd:String){
        let url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php"
        let params: Parameters = ["kullaniciAdi":kullaniciAdi]
        
        AF.request(url,method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let liste = cevap.urunler_sepeti {
                        // 3. Liste içinde arama yapıyoruz
                        if let urun = liste.first(where: { $0.ad == UrunAd }) {
                            print("Ürün bulundu: \(urun.ad!) - Sepet ID: \(urun.sepetId!)")
                            
                            // Ürünü silme işlemi burada yapılabilir
                            if let id = urun.sepetId {
                                self.sil(sepetId: id, kullaniciAdi: kullaniciAdi)
                            }
                        } else {
                            print("Ürün bulunamadı.")
                        }
                        
                        
                    }
                }catch{
                    print(error.localizedDescription)
                    print("urunvarsasil hata")

                }
            }
        }
    }
    
    
    
    
    
    func sil(sepetId:Int,kullaniciAdi:String){
        
        let url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php"
        
        let params: Parameters = ["sepetId":sepetId,"kullaniciAdi":kullaniciAdi]
        
        AF.request(url,method: .post,parameters: params).response { response in
        
            if let data = response.data{
                
                do {
                    
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    
                    print("Başarı (silindi): \(cevap.success!)")
                    print("Mesaj  : \(cevap.message!)")

                    

                }catch{
                    print(error.localizedDescription)
                    print("silinemedi")
                }
                
                
            }
            
        }
        
    }
    
    
    
}
