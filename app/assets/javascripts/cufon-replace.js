Cufon.CSS.ready(function() {
  Cufon.CSS.addClass(Cufon.DOM.root(), 'cufon-replacing');
});

Cufon.replace('#nav_bar > ul > li', {
  fontFamily: 'Bebas',
  hover: true,
  hoverables: { li: true },
  ignore: { ul: true },
  textless: { li: true }
});

Cufon.replace('#nav_bar > ul > li > ul > li > a', {
  fontFamily: 'Bebas',
  hover: true
});

Cufon.replace('h1, h2, h3, legend', { fontFamily: 'Gayatri', color: '#BD0102' });

Cufon.replace('#slogan', { fontFamily: 'Forelle', color: '-linear-gradient(#ff4040, #a0000f)' });

Cufon.CSS.ready(function() {
  Cufon.CSS.removeClass(Cufon.DOM.root(), 'cufon-replacing');
});
