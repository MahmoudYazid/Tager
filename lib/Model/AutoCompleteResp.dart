class AutoCompleteResp {
  List<Prediction> predictions;
  String status;

  AutoCompleteResp({
    required this.predictions,
    required this.status,
  });

}

class Prediction {
  String description;
  List<MatchedSubstring> matchedSubstrings;
  String placeId;
  String reference;
  StructuredFormatting structuredFormatting;
  List<Term> terms;
  List<Type> types;

  Prediction({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });

}

class MatchedSubstring {
  int length;
  int offset;

  MatchedSubstring({
    required this.length,
    required this.offset,
  });

}

class StructuredFormatting {
  String mainText;
  List<MatchedSubstring> mainTextMatchedSubstrings;

  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
  });

}

class Term {
  int offset;
  String value;

  Term({
    required this.offset,
    required this.value,
  });

}

enum Type {
  COUNTRY,
  GEOCODE,
  POLITICAL
}
