// -----------------------------------------------------------------------
// Static reference data for the Province / District pickers on the
// Personal Identity onboarding step.
// -----------------------------------------------------------------------

class NepalProvince {
  const NepalProvince({required this.name, required this.districts});

  final String name;
  final List<String> districts;
}

class NepalLocations {
  NepalLocations._();

  static const List<NepalProvince> provinces = [
    NepalProvince(
      name: 'Koshi Province',
      districts: [
        'Bhojpur',
        'Dhankuta',
        'Ilam',
        'Jhapa',
        'Khotang',
        'Morang',
        'Okhaldhunga',
        'Panchthar',
        'Sankhuwasabha',
        'Solukhumbu',
        'Sunsari',
        'Taplejung',
        'Terhathum',
        'Udayapur',
      ],
    ),
    NepalProvince(
      name: 'Madhesh Province',
      districts: [
        'Bara',
        'Dhanusha',
        'Mahottari',
        'Parsa',
        'Rautahat',
        'Saptari',
        'Sarlahi',
        'Siraha',
      ],
    ),
    NepalProvince(
      name: 'Bagmati Province',
      districts: [
        'Bhaktapur',
        'Chitwan',
        'Dhading',
        'Dolakha',
        'Kathmandu',
        'Kavrepalanchok',
        'Lalitpur',
        'Makwanpur',
        'Nuwakot',
        'Ramechhap',
        'Rasuwa',
        'Sindhuli',
        'Sindhupalchok',
      ],
    ),
    NepalProvince(
      name: 'Gandaki Province',
      districts: [
        'Baglung',
        'Gorkha',
        'Kaski',
        'Lamjung',
        'Manang',
        'Mustang',
        'Myagdi',
        'Nawalpur',
        'Parbat',
        'Syangja',
        'Tanahun',
      ],
    ),
    NepalProvince(
      name: 'Lumbini Province',
      districts: [
        'Arghakhanchi',
        'Banke',
        'Bardiya',
        'Dang',
        'Eastern Rukum',
        'Gulmi',
        'Kapilvastu',
        'Nawalparasi West',
        'Palpa',
        'Pyuthan',
        'Rolpa',
        'Rupandehi',
      ],
    ),
    NepalProvince(
      name: 'Karnali Province',
      districts: [
        'Dailekh',
        'Dolpa',
        'Humla',
        'Jajarkot',
        'Jumla',
        'Kalikot',
        'Mugu',
        'Salyan',
        'Surkhet',
        'Western Rukum',
      ],
    ),
    NepalProvince(
      name: 'Sudurpashchim Province',
      districts: [
        'Achham',
        'Baitadi',
        'Bajhang',
        'Bajura',
        'Dadeldhura',
        'Darchula',
        'Doti',
        'Kailali',
        'Kanchanpur',
      ],
    ),
  ];

  static List<String> provinceNames() => provinces.map((p) => p.name).toList();

  static List<String> districtsFor(String? province) {
    if (province == null) return const [];
    for (final p in provinces) {
      if (p.name == province) return p.districts;
    }
    return const [];
  }
}
