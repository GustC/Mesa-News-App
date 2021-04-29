class Pagination {
  int currentPage;
  int perPage;
  int totalPages;
  int totalItems;

  Pagination(
      {this.currentPage, this.perPage, this.totalPages, this.totalItems});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    data['total_pages'] = this.totalPages;
    data['total_items'] = this.totalItems;
    return data;
  }
}
