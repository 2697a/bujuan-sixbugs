class Result<R>{
  static final Result _netUtils = Result._internal(); //1
  factory Result() {
    return _netUtils;
  }
  Result._internal();

  R getData(Map map,R r){

    return r;
  }
}