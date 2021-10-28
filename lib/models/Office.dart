class MordreOffice{
  late String rNo;
  late String nm;
  late String mailAd;

  MordreOffice(String rNo, String nm, String mailAd) {
    this.rNo = rNo;
    this.nm = nm;
    this.mailAd = mailAd;
  }


  MordreOffice.fromJson(Map json)
      : rNo = json['rNo'],
        nm = json['nm'],
        mailAd = json['mailAd'];

  Map toJson() {
    return {'rNo': rNo, 'nm': nm, 'mailAd' : mailAd};
  }
}