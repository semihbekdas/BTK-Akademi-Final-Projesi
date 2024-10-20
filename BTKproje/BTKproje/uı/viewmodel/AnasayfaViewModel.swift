//
//  AnasayfaViewModel.swift
//  BTKproje
//
//  Created by semih bekdaş on 18.10.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel{
    
    var urepo = UrunlerRepository()
    
    var urunlerListesi = BehaviorSubject<[UrunlerModel]>(value: [UrunlerModel]())

    init(){
        
        urunleriGoster()
        
        urunlerListesi = urepo.urunlerListesi
        
        
    }
    
    
    func urunleriGoster(){
        
        urepo.urunleriGoster()
        
    }
    
    func ara(aramaKelimesi: String){
        
        urepo.ara(aramaKelimesi: aramaKelimesi)
        
    }
    
    func kategoriSec(kategori: String){
        urepo.kategoriSec(kategori: kategori)
    }
        
    func puanSirala(puanArtan: Bool) {
        urepo.puanSirala(puanArtan: puanArtan)

    }
    
    
    func fiyatSirala(fiyatArtan: Bool) {
        
        urepo.fiyatSirala(fiyatArtan: fiyatArtan)
    }
    
    
}
