class Mosquito {
  MosquitoStatus mosquitoStatus;

  Mosquito({this.mosquitoStatus});

  Mosquito.fromJson(Map<String, dynamic> json) {
    mosquitoStatus = json['MosquitoStatus'] != null
        ? new MosquitoStatus.fromJson(json['MosquitoStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mosquitoStatus != null) {
      data['MosquitoStatus'] = this.mosquitoStatus.toJson();
    }
    return data;
  }
}

class MosquitoStatus {
  int listTotalCount;
  RESULT rESULT;
  List<Row> row;

  MosquitoStatus({this.listTotalCount, this.rESULT, this.row});

  MosquitoStatus.fromJson(Map<String, dynamic> json) {
    listTotalCount = json['list_total_count'];
    rESULT =
    json['RESULT'] != null ? new RESULT.fromJson(json['RESULT']) : null;
    if (json['row'] != null) {
      row = new List<Row>();
      json['row'].forEach((v) {
        row.add(new Row.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list_total_count'] = this.listTotalCount;
    if (this.rESULT != null) {
      data['RESULT'] = this.rESULT.toJson();
    }
    if (this.row != null) {
      data['row'] = this.row.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RESULT {
  String cODE;
  String mESSAGE;

  RESULT({this.cODE, this.mESSAGE});

  RESULT.fromJson(Map<String, dynamic> json) {
    cODE = json['CODE'];
    mESSAGE = json['MESSAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODE'] = this.cODE;
    data['MESSAGE'] = this.mESSAGE;
    return data;
  }
}

class Row {
  String mOSQUITODATE;
  String mOSQUITOVALUEWATER;
  String mOSQUITOVALUEHOUSE;
  String mOSQUITOVALUEPARK;

  Row(
      {this.mOSQUITODATE,
        this.mOSQUITOVALUEWATER,
        this.mOSQUITOVALUEHOUSE,
        this.mOSQUITOVALUEPARK});

  Row.fromJson(Map<String, dynamic> json) {
    mOSQUITODATE = json['MOSQUITO_DATE'];
    mOSQUITOVALUEWATER = json['MOSQUITO_VALUE_WATER'];
    mOSQUITOVALUEHOUSE = json['MOSQUITO_VALUE_HOUSE'];
    mOSQUITOVALUEPARK = json['MOSQUITO_VALUE_PARK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MOSQUITO_DATE'] = this.mOSQUITODATE;
    data['MOSQUITO_VALUE_WATER'] = this.mOSQUITOVALUEWATER;
    data['MOSQUITO_VALUE_HOUSE'] = this.mOSQUITOVALUEHOUSE;
    data['MOSQUITO_VALUE_PARK'] = this.mOSQUITOVALUEPARK;
    return data;
  }
}
