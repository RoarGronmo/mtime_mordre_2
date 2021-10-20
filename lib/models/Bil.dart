class MordreBil {
  late int rNo;
  late String nm;
  late int r5;
  late String r10;

  MordreBil(int rNo, String nm, int r5, String r10) {
    this.rNo = rNo;
    this.nm = nm;
    this.r5 = r5;
    this.r10 = r10;
  }


  MordreBil.fromJson(Map json)
      : rNo = json['rNo'],
        nm = json['nm'],
        r5 = json['r5'],
        r10 = json['r10'];

  Map toJson() {
    return {'rNo': rNo, 'nm': nm, 'r5': r5, 'r10': r10};
  }
}