enum Page { work, shortPause, longPause }

class PageSelector {
  Page currentPage;

  PageSelector() {
    currentPage = Page.work;
  }

  Page get current => currentPage;

  changePage(Page pageEmitter) {
    currentPage = pageEmitter;
  }
}
