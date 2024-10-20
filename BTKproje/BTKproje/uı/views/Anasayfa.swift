//
//  ViewController.swift
//  BTKproje
//
//  Created by semih bekdaş on 17.10.2024.
//

import UIKit
import Kingfisher

class Anasayfa: UIViewController {
    
    var acikKullanici = Kullanici()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var urunlerCollecitonView: UICollectionView!
    
    
    @IBOutlet weak var imageviewTumUrun: UIImageView!
    
    @IBOutlet weak var imageviewTeknoloji: UIImageView!
    
    @IBOutlet weak var imageviewAksesuar: UIImageView!
    @IBOutlet weak var imageviewKozmetik: UIImageView!
    
    var urunlerListesi = [UrunlerModel]()
    
    var anasayfaViewModel = AnasayfaViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        searchBar.delegate = self
        urunlerCollecitonView.delegate = self
        urunlerCollecitonView.dataSource = self
        
        
        
       /* let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        tasarim.minimumInteritemSpacing = 5
        tasarim.minimumLineSpacing = 5
        
        // 10 x 10 x 10
        
        let ekranGenislik = UIScreen.main.bounds.width
        
        let itemGenislik = (ekranGenislik) / 2.5
        
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik*1.5)

        urunlerCollecitonView.collectionViewLayout = tasarim*/
        
        _ = anasayfaViewModel.urunlerListesi.subscribe(onNext: {
            liste in
            self.urunlerListesi=liste
            self.urunlerCollecitonView.reloadData()
        })

        imageviewTeknoloji.isUserInteractionEnabled = true
        imageviewKozmetik.isUserInteractionEnabled = true
        imageviewTumUrun.isUserInteractionEnabled = true
        imageviewAksesuar.isUserInteractionEnabled = true
        
        let gestureTeknoloji = UITapGestureRecognizer(target: self, action: #selector(tapTeknoloji))
        let gestureAksesuar = UITapGestureRecognizer(target: self, action: #selector(tapAksesuar))
        let gestureKozmetik = UITapGestureRecognizer(target: self, action: #selector(tapKozmetik))
        let gestureTumUrunler = UITapGestureRecognizer(target: self, action: #selector(tapTumUrunler))
        
        
        imageviewTeknoloji.addGestureRecognizer(gestureTeknoloji)
        imageviewKozmetik.addGestureRecognizer(gestureKozmetik)
        imageviewTumUrun.addGestureRecognizer(gestureTumUrunler)
        imageviewAksesuar.addGestureRecognizer(gestureAksesuar)

                
        
        
        
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
        //anasayfaViewModel.urunleriGoster()
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    @IBAction func buttonSepete(_ sender: Any) {
        
       //performSegue(withIdentifier: "toSepet", sender: nil)
    }
    
    
    
    
    @objc func tapTeknoloji(){
        anasayfaViewModel.kategoriSec(kategori: "Teknoloji")
        
    }
    @objc func tapAksesuar(){
        anasayfaViewModel.kategoriSec(kategori: "Aksesuar")
        
    }
    @objc func tapKozmetik(){
        anasayfaViewModel.kategoriSec(kategori: "Kozmetik")
        
    }
    @objc func tapTumUrunler(){
            anasayfaViewModel.urunleriGoster()
    }

    @IBAction func buttonSirala(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Sıralama Seçenekleri", message: nil, preferredStyle: .actionSheet)

        let defaultAction = UIAlertAction(title: "Varsayılan", style: .default) { _ in
            
            self.anasayfaViewModel.urunleriGoster()
        }
        
        let fiyatArtanAction = UIAlertAction(title: "Fiyat Artan", style: .default) { _ in
            // Fiyat artan sıralama
            self.anasayfaViewModel.fiyatSirala(fiyatArtan: true)
        }
        
        let fiyatAzalanAction = UIAlertAction(title: "Fiyat Azalan", style: .default) { _ in
            // Fiyat azalan sıralama
            self.anasayfaViewModel.fiyatSirala(fiyatArtan: false)

        }
        
        let puanArtanAction = UIAlertAction(title: "Puan Artan", style: .default) { _ in
            // Puan artan sıralama
            self.anasayfaViewModel.puanSirala(puanArtan: true)

        }
        
        let puanAzalanAction = UIAlertAction(title: "Puan Azalan", style: .default) { _ in
            // Puan azalan sıralama
            self.anasayfaViewModel.puanSirala(puanArtan: false)
        }

        alertController.addAction(defaultAction)
        alertController.addAction(fiyatArtanAction)
        alertController.addAction(fiyatAzalanAction)
        alertController.addAction(puanArtanAction)
        alertController.addAction(puanAzalanAction)

        present(alertController, animated: true, completion: nil)
    }
    
    
    
}

extension Anasayfa : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            anasayfaViewModel.urunleriGoster()
        }else{
            anasayfaViewModel.ara(aramaKelimesi: searchText)
        }
        
    }
    
}

extension Anasayfa : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urunlerListesi.count
    }
    
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let urun = urunlerListesi[indexPath.row]
        
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "urunlerHucre", for: indexPath) as! UrunlerHucre
        
        hucre.labelFiyat.text = "\(urun.fiyat) ₺"
        hucre.labelMarka.text = urun.marka
        hucre.labelPuan.text = "\(urun.puan)"
        hucre.labelUrunadi.text = urun.ad
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10.0
        
        if urun.puan > 4.5{
            hucre.imageStars.image = UIImage(named: "fivestars")
            
        }else if urun.puan > 4.0{
            hucre.imageStars.image = UIImage(named: "fourandhalfstars")

            
        }else if urun.puan > 3.5{
            hucre.imageStars.image = UIImage(named: "fourstarss")

        }else{
            hucre.imageStars.image = UIImage(named: "threeandhalfstars")

        }
        
        
        
        if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(urun.resim!)") {
            
            DispatchQueue.main.async{
                hucre.imageviewUrun.kf.setImage(with: url)
            
            }
            
        }
        
        return hucre
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let urun = urunlerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: urun)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let urun = sender as? UrunlerModel {
                let gidilecekVC = segue.destination as! UrunDetay
                gidilecekVC.urun = urun
            }
        }
    }
}

