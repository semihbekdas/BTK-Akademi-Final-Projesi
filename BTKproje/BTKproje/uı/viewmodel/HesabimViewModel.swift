//
//  CikisYapViewModel.swift
//  BTKproje
//
//  Created by semih bekdaş on 18.10.2024.
//

import Foundation

class HesabimViewModel {
    
     var krepo = KullanicilarRepository()
       
       var acikKullanici: Kullanici? {
           return krepo.getAcikKullanici()
       }
    
    
       
       func kullaniciCikis() {
           krepo.kullaniciCikis()
           kullanicilariYukle()
       }
    
    func kullanicilariYukle() {
        krepo.kullanicilariYukle()
    }
    
}
