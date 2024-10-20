//
//  SepetDetayViewModel.swift
//  BTKproje
//
//  Created by semih bekdaş on 19.10.2024.
//

import Foundation
import RxSwift

class SepetDetayViewModel {
    
    var sepettekilerListesi = BehaviorSubject<[Sepet]>(value: [Sepet]())
    
    var srepo = SepetApi()
    
    var krepo = KullanicilarRepository()
    
    var acikKullanici: Kullanici? {
        return krepo.getAcikKullanici()
    }
    
    
    init(){
        
        sepettenUrunGetir(kullaniciAdi: acikKullanici!.ad!)//bu ve sil semih düzeltirsin
        sepettekilerListesi = srepo.sepettekilerListesi
    }
    

    func sepettenUrunGetir(kullaniciAdi:String){
        
        srepo.sepettenUrunGetir(kullaniciAdi: kullaniciAdi)
       
    }

    
    func sil(sepetId:Int,kullaniciAdi:String){
        
        srepo.sil(sepetId: sepetId, kullaniciAdi: kullaniciAdi)
       // sepettenUrunGetir(kullaniciAdi: kullaniciAdi)
        
        
    }
    

    
}
