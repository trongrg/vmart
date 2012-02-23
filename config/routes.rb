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
  get '/sea_freight' => 'homepage#sea_freight'
  get '/air_freight' => 'homepage#air_freight'
  get '/pickup_delivery' => 'homepage#pickup_delivery'
  get '/consolidation_warehouse' => 'homepage#consolidation_warehouse'
  get '/heavy_lift' => 'homepage#heavy_lift'
  get '/removal_packing' => 'homepage#removal_packing'
  get '/quote' => 'homepage#quote'
end
