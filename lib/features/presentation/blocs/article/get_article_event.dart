abstract class ArticleEvent {
  const ArticleEvent();
}

class LoadArticlesEvent extends ArticleEvent {
  const LoadArticlesEvent();
}

class LoadMoreArticlesEvent extends ArticleEvent {
  const LoadMoreArticlesEvent();
}

class RefreshArticlesEvent extends ArticleEvent {
  const RefreshArticlesEvent();
}

class LoadPageEvent extends ArticleEvent {
  final int page;

  const LoadPageEvent(this.page);
}