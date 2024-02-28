String CalculateCash(int dist, String type_ofTrans){
  double total = 0;
  switch(type_ofTrans){
    case "furniture": {
      total = dist * 1.40;
    };
    case "satha":  {
      total = dist * 1.40;


    };
    case "goods": {
      total = dist * 1.40;
    };

  }
  return total.toInt().toString();


}