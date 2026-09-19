# BTK Akademi E-Ticaret Uygulaması

![Swift](https://img.shields.io/badge/Swift-5-F05138?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-UIKit-000000?logo=apple&logoColor=white)
![RxSwift](https://img.shields.io/badge/RxSwift-B7178C)
![MVVM](https://img.shields.io/badge/Architecture-MVVM-blue)
![Core Data](https://img.shields.io/badge/Core%20Data-persistence-lightgrey)

Bu proje, BTK Akademi final projesi olarak geliştirilen bir e-ticaret uygulamasıdır. Uygulama, kullanıcıların ürünleri görüntülemesine, aramasına, filtrelemesine ve sepete eklemesine olanak tanır.

## Özellikler

- **Ürün Listeleme:** Kullanıcılar, uygulama üzerinden mevcut ürünleri listeleyebilir.
- **Ürün Detayları:** Kullanıcılar, her bir ürünün detaylarına ulaşabilir.
- **Sepet Yönetimi:** Kullanıcılar, ürünleri sepete ekleyebilir ve sepetlerinde görüntüleyebilir.
- **Arama ve Filtreleme:** Kullanıcılar, ürünleri belirli kriterlere göre arayabilir ve filtreleyebilir.

## Kullanılan Teknolojiler

- **Swift:** Uygulama geliştirme dili.
- **RxSwift:** Reaktif programlama için kullanıldı.
- **MVVM (Model-View-ViewModel):** Uygulama mimarisi.
- **Core Data:** Veri saklama ve yönetimi için kullanıldı.
- **Alamofire:** Web servisleri ile iletişim için kullanıldı.

## Proje Yapısı

```
BTKproje/
├── BTKproje.xcodeproj/        # Xcode projesi
├── BTKproje/                  # Uygulama kaynak kodu (MVVM katmanları, servisler, görünümler)
└── Model.xcmappingmodel/      # Core Data eşleme modeli
```

## Çalıştırma

1. `BTKproje/BTKproje.xcodeproj` dosyasını Xcode ile açın.
2. Bağımlılıklar (RxSwift, Alamofire) Swift Package Manager / CocoaPods üzerinden çözülüyorsa paketlerin indirilmesini bekleyin.
3. Bir iOS simülatörü seçip **Run** (⌘R) ile başlatın.

## Ekran Görüntüleri

![Kayıt Ol](https://github.com/semihbekdas/BTK-Akademi-Final-Projesi/blob/main/KayitOl.png)
![Giriş Yap](https://github.com/semihbekdas/BTK-Akademi-Final-Projesi/blob/main/GirisYap.png)
![Ana Sayfa](https://github.com/semihbekdas/BTK-Akademi-Final-Projesi/blob/main/Anasayfa.png)
![Ürün Detayları](https://github.com/semihbekdas/BTK-Akademi-Final-Projesi/blob/main/UrunDetay.png)
![Sepet](https://github.com/semihbekdas/BTK-Akademi-Final-Projesi/blob/main/Sepetim.png)
![Hesabım](https://github.com/semihbekdas/BTK-Akademi-Final-Projesi/blob/main/Hesabim.png)
