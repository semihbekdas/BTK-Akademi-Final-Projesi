//
//  KayitOlViewModel.swift
//  BTKproje
//
//  Created by semih bekdaş on 18.10.2024.
//

import Foundation

class KayitOlViewModel {
    
    var krepo = KullanicilarRepository()
       
       func kullaniciKaydet(ad: String, mail: String, sifre: String, adres: String) -> Bool {
           return krepo.kullaniciKaydet(ad: ad, mail: mail, sifre: sifre, adres: adres)
       }
    
}
