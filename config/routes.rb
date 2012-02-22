Vmart::Application.routes.draw do
  root :to => 'homepage#index'
  get '/about' => 'homepage#about'
  get '/contact' => 'homepage#contact'
  get '/links' => 'homepage#links'
  get '/services' => 'homepage#services'
  get '/documents' => 'homepage#documents'
  get '/tools' => 'homepage#tool'
  get '/brief_outlook' => 'homepage#brief_outlook'
  get '/bank_details' => 'homepage#bank_details'
  get '/consign_a_shipment' => 'homepage#consign_a_shipment'
  get '/news' => 'homepage#news'
end
