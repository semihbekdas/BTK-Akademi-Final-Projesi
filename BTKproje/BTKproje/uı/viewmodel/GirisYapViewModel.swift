//
//  GirisYapViewModel.swift
//  BTKproje
//
//  Created by semih bekdaş on 17.10.2024.
//

import Foundation
import RxSwift

class GirisYapViewModel {
    
    var krepo = KullanicilarRepository()
    var kullaniciListe = BehaviorSubject<[Kullanici]>(value: [Kullanici]())
    
    init(){
        kullanicilariYukle()
        kullaniciListe=krepo.kullanicilarListesi
        
    }
   
    func kullaniciGiris(mail: String, sifre: String) -> Bool {
            
        let girisBasarili = krepo.kullaniciGiris(mail: mail, sifre: sifre)
        
        if girisBasarili {
                
            //kullanicilariYukle()
        }
        
        return girisBasarili
    }
    
    func hesapAcikmi() -> Bool {
        let hesapAcik = krepo.hesapAcikmi()
               
               if hesapAcik {
                   // Hesap açık ise kullanıcıları yükle
                //   kullanicilariYukle()
               }
        
        return hesapAcik
        //eğer true dönerse direkt anasayfaya gidicez ve kullanıcıyı aktarıcaz
    }

    func getAcikKullanici() -> Kullanici? {
        return krepo.getAcikKullanici()
    }
    
    func kullanicilariYukle() {
        krepo.kullanicilariYukle()
    }
    
}
