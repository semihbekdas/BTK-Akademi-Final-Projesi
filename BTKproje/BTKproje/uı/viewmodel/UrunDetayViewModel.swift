//
//  UrunDetayViewModel.swift
//  BTKproje
//
//  Created by semih bekdaş on 19.10.2024.
//

import Foundation

class UrunDetayViewModel{
    //kullanıcı ve sepet repositoryleri aldık
    
    var srepo = SepetApi()
    var krepo = KullanicilarRepository()
    
    
    
    var acikKullanici: Kullanici? {
        return krepo.getAcikKullanici()
    }
    
    
    func sepeteUrunEkle(ad: String, resim: String, kategori: String, fiyat: Int, marka: String, siparisAdeti: Int, kullaniciAdi: String) {
        
        srepo.sepeteUrunEkle(ad: ad, resim: resim, kategori: kategori, fiyat: fiyat, marka: marka, siparisAdeti: siparisAdeti, kullaniciAdi: kullaniciAdi)
        
    }
    
    
    
   
 
    func kullanicilariYukle() {
        krepo.kullanicilariYukle()
    }
    
}
