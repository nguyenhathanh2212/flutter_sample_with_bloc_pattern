class ItemModel {
  int _page;
  int _title_results;
  int _total_pages;
  List<Result> _result = [];
}

class Result {
  int _id;
  int _vote_count;
}
