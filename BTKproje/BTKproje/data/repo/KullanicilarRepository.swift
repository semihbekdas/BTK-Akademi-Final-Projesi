//
//  KullanicilarRepository.swift
//  BTKproje
//
//  Created by semih bekdaş on 17.10.2024.
//

import Foundation
import RxSwift
import CoreData

class KullanicilarRepository{
    
    var kullanicilarListesi = BehaviorSubject<[Kullanici]>(value: [Kullanici]())
    
    let context = appDelegate.persistentContainer.viewContext
    
    
    //kullancı kaydet eğer o mail ve adda biri yoksa kaydeder
    //kullanıcı girş eğer o mail ve şifre varsa anasayfaya atar
    // eğer hesap açıksa hesap açık mı true döner
    // çıkış yapa basarsa çıkış yap çalışır
    //açk olana ulaşmak için getli metod kullanılcak
    
    var acikKullanici: Kullanici?
    
    

   
    func kullaniciKaydet(ad: String, mail: String, sifre: String, adres: String) -> Bool{
        
        let fetchRequest: NSFetchRequest<Kullanici> = Kullanici.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mail == %@ OR ad == %@", mail, ad)

        do {
            let mevcutKullanicilar = try context.fetch(fetchRequest)
            if mevcutKullanicilar.count > 0 {
                print("Bu e-posta veya isim zaten kullanılmış!")
                return false // Kayıt başarısız
            }
        } catch {
            print("Hata: \(error.localizedDescription)")
            return false
        }


     
        let yeniKullanici = Kullanici(context: context)
        yeniKullanici.id = UUID()
        yeniKullanici.ad = ad
        yeniKullanici.mail = mail
        yeniKullanici.sifre = sifre
        yeniKullanici.adres = adres
        yeniKullanici.isLogged = false

        appDelegate.saveContext()
        print("Kayıt başarılı!")
            return true

    }
    
    func kullaniciGiris(mail: String, sifre: String) -> Bool {
            let fetchRequest: NSFetchRequest<Kullanici> = Kullanici.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "mail == %@ AND sifre == %@", mail, sifre)
            
            do {
                let kullanicilar = try context.fetch(fetchRequest)
                if let kullanici = kullanicilar.first {
                    // Giriş başarılı, kullanıcı online olacak
                    kullanici.isLogged = true
                    appDelegate.saveContext() // Değişiklikleri kaydet
                 //   acikKullanici = kullanici // Açık kullanıcıyı ayarla

                    kullanicilarListesi.onNext([kullanici])

                    return true
                } else {
                    // Kullanıcı bulunamadı
                    return false
                }
            } catch {
                print("Giriş hatası: \(error)")
                return false
            }
        }
    
    func hesapAcikmi() -> Bool {
        let fetchRequest: NSFetchRequest<Kullanici> = Kullanici.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isLogged == true")

        do {
            let kullanicilar = try context.fetch(fetchRequest)
            if let kullanici = kullanicilar.first {
                // Giriş başarılı, kullanıcı ana sayfaya yönlendiriliyor
                print("Kullanıcı giriş yaptı: \(kullanici.mail ?? "")")
                return true // Kullanıcı giriş yapmış
            } else {
                // Giriş yapılmamış
                print("Kullanıcı giriş yapmadı.")
                return false // Kullanıcı giriş yapmamış
            }
        } catch {
            print("Kullanıcı verileri getirilirken hata: \(error.localizedDescription)")
            return false // Hata durumunda giriş yapılmamış kabul edelim
        }
    }
    
    
    
    func kullaniciCikis() {
          let fetchRequest: NSFetchRequest<Kullanici> = Kullanici.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "isLogged == true")

          do {
              let kullanicilar = try context.fetch(fetchRequest)
              if let kullanici = kullanicilar.first {
                  kullanici.isLogged = false
                  appDelegate.saveContext() // Değişiklikleri kaydet
                  
                  // Kullanıcıyı listeyi güncelle
                  kullanicilarListesi.onNext([kullanici])
                  print("Kullanıcı çıkış yaptı: \(kullanici.mail ?? "")")
              }
          } catch {
              print("Çıkış hatası: \(error.localizedDescription)")
          }
      }
    
    func getAcikKullanici() -> Kullanici? {
        
        let fetchRequest: NSFetchRequest<Kullanici> = Kullanici.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isLogged == true")

        do {
            let kullanicilar = try context.fetch(fetchRequest)
            if let kullanici = kullanicilar.first {
                // Giriş başarılı, kullanıcı ana sayfaya yönlendiriliyor
                print("Kullanıcı giriş yaptı: \(kullanici.mail ?? "!")")
                return kullanici // Kullanıcı giriş yapmış
            } else {
                // Giriş yapılmamış
                print("Kullanıcı giriş yapmadı.")
                return nil // Kullanıcı giriş yapmamış
            }
        } catch {
            print("Kullanıcı verileri getirilirken hata: \(error.localizedDescription)")
            return nil // Hata durumunda giriş yapılmamış kabul edelim
        }
    }
    
    func kullanicilariYukle() {
            do {
                let fetchRequest: NSFetchRequest<Kullanici> = Kullanici.fetchRequest()
                let kullanicilar = try context.fetch(fetchRequest)
                kullanicilarListesi.onNext(kullanicilar) // Listeyi güncelle
            } catch {
                print("Kullanıcı verileri yüklenirken hata: \(error)")
            }
        }
    
}
