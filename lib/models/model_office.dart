class MWorkOffice{
  late String rNo;
  late String nm;
  late String mailAd;

  MWorkOffice(String rNo, String nm, String mailAd) {
    this.rNo = rNo;
    this.nm = nm;
    this.mailAd = mailAd;
  }


  MWorkOffice.fromJson(Map json)
      : rNo = json['rNo'],
        nm = json['nm'],
        mailAd = json['mailAd'];

  Map toJson() {
    return {'rNo': rNo, 'nm': nm, 'mailAd' : mailAd};
  }
}